import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:listenbrainz/exceptions/api_exception.dart';
import 'package:listenbrainz/utils/rate_limiter.dart';
import 'package:listenbrainz/src/response_handler.dart';
import 'package:listenbrainz/types/instance_init.dart';
import 'package:listenbrainz/types/response_listen.dart';
import 'package:listenbrainz/types/submission_listen.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:listenbrainz/src/utils/request_helpers.dart';

class Core {
  final RateLimiter limiter;
  final InitParams params;
  final http.Client _client;
  //String listenBrainzServerUrl = 'https://api.listenbrainz.org';

  const Core(this.params, this.limiter, this._client);

  /// Search for a user registered on ListenBrainz
  /// 
  /// Returns a list of usernames if the request was successful, throws [ApiException] otherwise.
  Future<List<String>> searchUser(String query) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/search/users/', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
          {'search_term': query}
      ],
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      final users = (decoded['users'] as List? ?? [])
          .map((user) {
            if (user is Map<String, dynamic>) {
              return user['user_name'] as String?;
            }
            return null;
          })
          .whereType<String>()
          .toList();
      return users;
    });
  }

  /// Submits a single listen to the ListenBrainz server.
  /// 
  /// POST /1/submit-listens
  /// 
  /// ListenBrainz api documentation says:
  /// > Listens should be submitted for tracks when the user has listened to 
  /// > half the track or 4 minutes of the track, whichever is lower. 
  /// > If the user hasn’t listened to 4 minutes or half the track, 
  /// > it doesn’t fully count as a listen and should not be submitted.
  /// 
  /// This method will submit to listenbrainz any listen passed to it.
  /// You are responsible to check how much of the song the user listened and decide if pass the listen to this method or not.
  /// 
  /// Returns `true` if the submission was successful, throws [ApiException] otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final listen = SubmissionListen(...);
  /// final listenbrainz = ListenBrainz(...);
  /// final success = await listenbrainz.core.submitSingleListen(listen);
  /// ```
  Future<bool> submitSingleListen(SubmissionListen listen) async {
    if (listen.trackMetadata.artistName.isEmpty) {
      throw ArgumentError('Artist name cannot be empty');
    }
    if (listen.trackMetadata.trackName.isEmpty) {
      throw ArgumentError('Track name cannot be empty');
    }

    final response = await submitListen(
      listenbrainzURL: params.listenBrainzServerUrl, 
      listen: listen,
      type: SubmissionListenTypes.single,
      userToken: params.token,
      httpClient: _client, 
      rateLimiter: limiter,
    );

    final results = ResponseHandler.handleResponse(response, (decoded) => decoded);
    
    if (results['status'] == 'ok') {
      return true;
    }
    throw ApiException(response.statusCode, 'Unknown error');
  }

  /// Send multiple listens to ListenBrainz
  /// 
  /// POST /1/submit-listens
  /// 
  /// This is intended for when user is listening while offline or when was a error 
  /// while submiting a single listen, so when the app is online again you can
  /// recover listening data from a offline storage and pass to this method.
  /// You can pass how many listens you want, the method will take care of ListenBrainz limitations.
  /// 
  /// Returns a list of the listens that the submission was unsuccessful,
  /// or a empty list if it can submit all listens.
  /// 
  /// Throws [ApiException]  
  Future<List<SubmissionListen>> importListens(List<SubmissionListen> listens) async {
    while (listens.isNotEmpty) {
      final List<SubmissionListen> listensToImport = 
          listens.take(ListenBrainzConstants.MAX_LISTENS_PER_REQUEST).toList();
      
      final response = await submitListen(
        listenbrainzURL: params.listenBrainzServerUrl, 
        listen: listensToImport, 
        type: SubmissionListenTypes.import, 
        userToken: params.token, 
        httpClient: _client, 
        rateLimiter: limiter
      );

      ResponseHandler.handleResponse(response, (decoded) => decoded);

      if (response.statusCode == 200) {
        listens.removeRange(0, listensToImport.length);
      }
    }

    return listens;
  }

  /// Fetches listens for a user with optional pagination support.
  /// 
  /// GET /1/user/{user_name}/listens
  /// 
  /// The ListenBrainz API uses timestamp-based pagination:
  /// - Use `maxTs` to fetch listens older than a specific timestamp (for next page)
  /// - Use `minTs` to fetch listens newer than a specific timestamp (for previous page)
  /// - Use the `oldestListenTs` from the response as `maxTs` for the next page
  /// - Use the `latestListenTs` from the response as `minTs` for the previous page
  /// 
  /// Returns a record containing the listens, count, timestamps, and user ID.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// // Get first page
  /// final firstPage = await lb.core.userListens('username', 25);
  /// 
  /// // Get next page (older listens)
  /// final nextPage = await lb.core.userListens(
  ///   'username', 
  ///   25,
  ///   maxTs: firstPage.oldestListenTs,
  /// );
  /// 
  /// // Get previous page (newer listens)
  /// final prevPage = await lb.core.userListens(
  ///   'username',
  ///   25,
  ///   minTs: firstPage.latestListenTs,
  /// );
  /// ```
  Future<({
    int count,
    int latestListenTs,
    List<ResponseListen> listens,
    int oldestListenTs,
    String? userId,
  })> userListens(
    String user,
    int? count, {
    int? maxTs,
    int? minTs,
  }) async {
  
    if (count != null && count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw ArgumentError('`count` must not exceed MAX_ITEMS_PER_GET: ${ListenBrainzConstants.MAX_ITEMS_PER_GET}.');
    }

    if (count != null && count <= 0) {
      throw ArgumentError('`count` must be a positive integer when provided.');
    }

    if (maxTs != null && minTs != null) {
      throw ArgumentError('Cannot specify both `maxTs` and `minTs` at the same time');
    }
    
    final paramsList = <Map<String, dynamic>>[
      { 'count': count ?? ListenBrainzConstants.DEFAULT_ITEMS_PER_GET },
    ];

    if (maxTs != null) {
      paramsList.add({ 'max_ts': maxTs });
    }

    if (minTs != null) {
      paramsList.add({ 'min_ts': minTs });
    }

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/listens', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: paramsList,
    );

    final payload = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return (
      count: (payload['count'] as num).toInt(),
      latestListenTs: (payload['latest_listen_ts'] as num).toInt(),
      listens: (payload['listens'] as List).map((l) => 
          ResponseListen.fromJson(l)).toList(),
      oldestListenTs: (payload['oldest_listen_ts'] as num).toInt(),
      userId: payload['user_id'] as String,
    );
  }


  /// Fetches the total count of listens for a user.
  /// 
  /// GET /1/user/{user_name}/listen-count
  /// 
  /// Returns the total number of listens submitted by the specified user.
  /// Throws [ApiException] if the request fails or the user is not found.
  /// 
  /// Example:
  /// ```dart
  /// final count = await lb.core.listenCount('username');
  /// print('User has $count listens');
  /// ```
  Future<int> listenCount(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/listen-count', 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    final payload = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return payload['count'] as int;
  }

  /// Submits a "playing now" status to ListenBrainz.
  /// 
  /// POST /1/submit-listens
  /// 
  /// This method is used to indicate that a user is currently listening to a track.
  /// Unlike regular listens, playing now submissions do not have a `listenedAt` timestamp
  /// and are temporary - they are automatically removed after a few minutes.
  /// 
  /// The `listen.listenedAt` field must be `null` when submitting a playing now listen.
  /// 
  /// Returns `true` if the submission was successful, throws [ApiException] otherwise.
  /// Throws [ArgumentError] if `listen.listenedAt` is not `null`.
  /// 
  /// Example:
  /// ```dart
  /// final listen = SubmissionListen(
  ///   trackName: 'Song Title',
  ///   artistName: 'Artist Name',
  ///   listenedAt: null, // Must be null for playing now
  /// );
  /// final success = await lb.core.setPlayingNow(listen);
  /// ```
  Future<bool> setPlayingNow(SubmissionListen listen) async {
    if (listen.listenedAt != null) {
      throw ArgumentError('listen.listenedAt should be null when submitting a playing_now listen');
    }

    final response = await submitListen(
      listenbrainzURL: params.listenBrainzServerUrl,
      listen: listen,
      type: SubmissionListenTypes.playingNow,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter,
    );

    final results = ResponseHandler.handleResponse(response, (decoded) => decoded);

    if (results['status'] == 'ok') return true;

    throw ApiException(results['code'], results['error']);
  }

  /// Fetches the current "playing now" status for a user.
  /// 
  /// GET /1/user/{user_name}/playing-now
  /// 
  /// Returns information about what the user is currently listening to, if anything.
  /// The `playingNow` field indicates whether the user has an active playing now status.
  /// 
  /// Returns a record containing the count, listens, playing status, and user ID.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final playingNow = await lb.core.getPlayingNow('username');
  /// if (playingNow.playingNow) {
  ///   print('User is currently listening to: ${playingNow.listens.first.trackName}');
  /// }
  /// ```
  Future<({
    int count, 
    List<ResponseListen> listens,
    bool playingNow,
    String userId,
  })> getPlayingNow(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/playing-now', 
      httpClient: _client, 
      rateLimiter: limiter,
    );
    
    final payload = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    final int count = payload['count'] as int;
    final List<ResponseListen> listens = 
        (payload['listens'] as List)
          .map((listen) => ResponseListen.fromJson(listen))
          .toList();

    return (
      count: count, 
      listens: listens,
      playingNow: payload['playing_now'] as bool,
      userId: payload['user_id'] as String,
    );
  }

  /// Fetches a list of users with similar listening habits to the specified user.
  /// 
  /// GET /1/user/{user_name}/similar-users
  /// 
  /// Returns a list of users sorted by similarity score, where higher scores indicate
  /// more similar listening patterns.
  /// 
  /// Returns a list of records containing similarity scores and usernames.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final similar = await lb.core.similarUsers('username');
  /// for (final user in similar) {
  ///   print('${user.userName}: ${user.similarity}% similar');
  /// }
  /// ```
  Future<List<({double similarity, String userName})>> similarUsers(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/similar-users', 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    final List<Map<String, dynamic>> payload = ResponseHandler.handleResponse(
      response,
      (decoded) {
        final dynamic raw = ResponseHandler.extractPayload(decoded);
        if (raw is! List) {
          throw ApiException(
            500,
            'Unexpected payload type for similar users',
          );
        }
        return raw
            .whereType<Map>()
            .map((entry) => entry.cast<String, dynamic>())
            .toList();
      },
    );

    return payload.map((item) {
      final map = item;
      return (
        similarity: (map['similarity'] as num).toDouble(),
        userName: map['user_name'] as String,
      );
    }).toList();
  }

  /// Calculates the similarity between two users' listening habits.
  /// 
  /// GET /1/user/{user_name}/similar-to/{other_user_name}
  /// 
  /// Returns the similarity score between the specified user and another user,
  /// indicating how similar their listening patterns are.
  /// 
  /// Returns a record containing the similarity score and username.
  /// Throws [ApiException] if the request fails or either user is not found.
  /// 
  /// Example:
  /// ```dart
  /// final similarity = await lb.core.similarTo('user1', 'user2');
  /// print('Similarity: ${similarity.similarity}%');
  /// ```
  Future<({double similarity, String userName})> similarTo(String user, String otherUser) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/similar-to/$otherUser',
      httpClient: _client,
      rateLimiter: limiter,
    );

    final payload = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return (
      similarity: (payload['similarity'] as num).toDouble(),
      userName: payload['user_name'] as String,
    );
  }

  /// Validates the current user's authentication token.
  /// 
  /// GET /1/validate-token
  /// 
  /// Checks if the token provided during initialization is valid and returns
  /// information about the authenticated user.
  /// 
  /// Returns a [TokenValidationResponse] containing token validation details.
  /// Throws [ApiException] if the token is invalid or the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final validation = await lb.core.validateToken();
  /// if (validation.valid) {
  ///   print('Token is valid for user: ${validation.userName}');
  /// }
  /// ```
  Future<TokenValidationResponse> validateToken() async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/validate-token', 
      httpClient: _client, 
      rateLimiter: limiter,
      token: params.token,  
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return TokenValidationResponse.fromJson(decoded);
    });
  }

  /// Deletes a specific listen from the user's listening history.
  /// 
  /// POST /1/delete-listen
  /// 
  /// Removes a listen identified by its timestamp and recording MSID from the user's
  /// ListenBrainz history. This operation requires authentication.
  /// 
  /// Returns `true` if the deletion was successful, throws [ApiException] otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final success = await lb.core.deleteListen(
  ///   1234567890, // listenedAt timestamp
  ///   'recording-msid-here',
  /// );
  /// ```
  Future<bool> deleteListen(int listenedAt, UuidString recordingMsid) async {
    final Map<String, dynamic> body = {
      'listened_at': listenedAt,
      'recording_msid': recordingMsid,
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/delete-listen',
      body: body,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter,
    );

    ResponseHandler.handleResponse(response, (decoded) => decoded);

    return response.statusCode == 200;
  }

  /// Fetches the list of connected music services for a user.
  /// 
  /// GET /1/user/{user_name}/services
  /// 
  /// Returns information about which external music services (e.g., Spotify, Last.fm)
  /// are connected to the user's ListenBrainz account.
  /// 
  /// Returns a record containing the username and list of connected services.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final userServices = await lb.core.services('username');
  /// print('Connected services: ${userServices.services}');
  /// ```
  Future<({
    String userName,
    List<ConnectedServices> services,
  })> services(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/user/$user/services',
      httpClient: _client,
      rateLimiter: limiter,
      token: params.token,
    );

    final decodedBody = ResponseHandler.handleResponse(response, (decoded) => decoded);
    
    final userName = decodedBody['user_name'] as String;
    final services = (decodedBody['services'] as List<dynamic>).cast<String>();

    final serviceEnums = services
        .map((s) => ConnectedServices.fromString(s))
        .toList();

    return (
      userName: userName,
      services: serviceEnums,
    );
  }

  /// Generates a radio playlist based on tags.
  /// 
  /// GET /1/lb-radio/tags
  /// 
  /// Creates a personalized radio playlist using tags as criteria. You can specify
  /// multiple tags and use operators to combine them (AND/OR).
  /// 
  /// Parameters:
  /// - [tag]: List of tags to use for generating the playlist
  /// - [operator]: Operator to use when combining multiple tags (required if more than one tag)
  /// - [popBegin]: Minimum popularity threshold (0-100)
  /// - [popEnd]: Maximum popularity threshold (0-100)
  /// - [count]: Number of tracks to return
  /// 
  /// Returns a list of [RadioTagResponse] objects representing the generated tracks.
  /// Throws [ApiException] if the request fails or parameters are invalid.
  /// Throws [RangeError] if popularity values are out of range (0-100).
  /// 
  /// Example:
  /// ```dart
  /// final tracks = await lb.core.lbRadioTags(
  ///   tag: ['rock', 'indie'],
  ///   operator: LbRadioOperators.and,
  ///   popBegin: 0,
  ///   popEnd: 100,
  ///   count: 20,
  /// );
  /// ```
  Future<List<RadioTagResponse>> lbRadioTags({
    required List<String> tag,
    LbRadioOperators? operator,
    required int popBegin,
    required int popEnd,
    required int count,
  }) async {
    if (tag.length > 1 && operator == null) {
      throw ApiException(400, "When passing more than one tag, you must pass an operator too.");
    }

    if (popBegin < 0 || popBegin > 100){
      throw RangeError.value(popBegin);
    }

    if (popEnd < 0 || popEnd > 100){
      throw RangeError.value(popEnd);
    }

    final urlParams = [
      {'pop_begin': popBegin},
      {'pop_end': popEnd},
      {'count': count},
      ...tag.map((tg) => {'tag': tg}),
      if (operator != null) {'operator': operator.value}
    ];

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/lb-radio/tags',
      httpClient: _client,
      rateLimiter: limiter,
      params: urlParams,
    );

    final results = ResponseHandler.handleResponse(response, (decoded) => decoded);


    final ret = 
        (results as List)
          .map((r) => RadioTagResponse.fromJson(r))
          .toList();

    return ret;
  }

  /// Generates a radio playlist based on an artist.
  /// 
  /// GET /1/lb-radio/artist/{seed_artist_mbid}
  /// 
  /// Creates a personalized radio playlist using an artist as the seed. The playlist
  /// can include tracks from similar artists or from the seed artist themselves,
  /// depending on the mode.
  /// 
  /// Parameters:
  /// - [seedArtistMbid]: MusicBrainz ID of the seed artist
  /// - [mode]: Radio mode (e.g., similar artists, same artist, etc.)
  /// - [maxSimilarArtists]: Maximum number of similar artists to include
  /// - [maxRecordingsPerArtist]: Maximum number of recordings per artist
  /// - [popBegin]: Minimum popularity threshold (0-100)
  /// - [popEnd]: Maximum popularity threshold (0-100)
  /// 
  /// Returns a list of [RadioArtistResponse] objects representing the generated tracks.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final tracks = await lb.core.lbRadioArtist(
  ///   seedArtistMbid: 'artist-mbid-here',
  ///   mode: RadioModes.similar,
  ///   maxSimilarArtists: 5,
  ///   maxRecordingsPerArtist: 3,
  ///   popBegin: 0,
  ///   popEnd: 100,
  /// );
  /// ```
  Future<List<RadioArtistResponse>> lbRadioArtist({
    required String seedArtistMbid,
    required RadioModes mode,
    required int maxSimilarArtists,
    required int maxRecordingsPerArtist,
    required int popBegin,
    required int popEnd,
  }) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/lb-radio/artist/$seedArtistMbid',
      httpClient: _client,
      rateLimiter: limiter,
      params: [
        { 'mode': mode.value },
        { 'max_similar_artists': maxSimilarArtists },
        { 'max_recordings_per_artist': maxRecordingsPerArtist },
        { 'pop_begin': popBegin },
        { 'pop_end': popEnd },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) => decoded);

    final List<RadioArtistResponse> responses = [];
    for (var entry in results.entries) {
      for (var value in entry.value) {
        responses.add(RadioArtistResponse.fromJson(value));
      }
    }

    return responses;
  }

  /// Fetches the latest import timestamp for a user.
  /// 
  /// GET /1/latest-import
  /// 
  /// Returns information about the most recent data import for the specified user,
  /// including the timestamp of the latest import and their MusicBrainz ID.
  /// 
  /// Returns a record containing the latest import timestamp and MusicBrainz ID.
  /// Throws [ApiException] if the request fails.
  /// 
  /// Example:
  /// ```dart
  /// final import = await lb.core.getLatestImport('username');
  /// print('Latest import: ${DateTime.fromMillisecondsSinceEpoch(import.latestImport * 1000)}');
  /// ```
  Future<({
    int latestImport,
    String musicbrainzId,
  })> getLatestImport(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/latest-import',
      httpClient: _client,
      rateLimiter: limiter,
      params: [
        { 'user_name': user },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) => decoded);

    return (
      latestImport: results['latest_import'] as int,
      musicbrainzId: results['musicbrainz_id'] as String,
    );

  }

  /// Sets the latest import timestamp for the authenticated user.
  /// 
  /// POST /1/latest-import
  /// 
  /// Updates the timestamp indicating when the user's data was last imported.
  /// This is typically used when importing listening history from external services.
  /// 
  /// Parameters:
  /// - [ts]: Unix timestamp of the latest import
  /// 
  /// Returns `true` if the update was successful, throws [ApiException] otherwise.
  /// 
  /// Example:
  /// ```dart
  /// final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  /// final success = await lb.core.setLatestImport(timestamp);
  /// ```
  Future<bool> setLatestImport(int ts) async {
    final Map<String, int> body = {
      'ts': ts
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/latest-import', 
      body: body,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    ResponseHandler.handleResponse(response, (decoded) => decoded);

    return response.statusCode == 200;
  }
}
