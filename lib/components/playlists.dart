
import 'package:http/http.dart' as http;
import 'package:listenbrainz/src/utils/rate_limiter.dart';
import 'package:listenbrainz/src/response_handler.dart';
import 'package:listenbrainz/src/types/instance_init.dart';
import 'package:listenbrainz/src/types/playlists.dart';
import 'package:listenbrainz/src/types/types.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/utils/request_helpers.dart';

/// Uses the ListenBrainz API to manage user playlists.
/// 
/// This class provides methods to create, read, update, and delete playlists
/// on ListenBrainz, as well as manage playlist items and import/export playlists
/// from connected music services.
/// 
/// **Important:** Playlist items use 0-based indexing.
class PlaylistManager {
  final RateLimiter limiter;
  final InitParams params;
  final http.Client _client;

  const PlaylistManager(this.params, this.limiter, this._client);

  /// Fetches the playlists of a given user, with optional pagination support.
  /// 
  /// GET /1/user/{user}/playlists
  /// 
  /// From ListenBrainz docs:
  /// > Fetch playlist metadata in [JSPF format](https://musicbrainz.org/doc/jspf#playlist) 
  /// > without recordings for the given user. 
  /// > If a user token is provided in the Authorization header, 
  /// > return private playlists as well as public playlists for that user.
  /// 
  /// Pagination:
  /// - [count]: How many playlists to return in a single call.
  /// - [offset]: Index of the first playlist to return (for paging through results).
  /// 
  /// Example:
  /// ```dart
  /// // First page (defaults to 25 playlists)
  /// final firstPage = await lb.playlists.getPlaylists('username');
  /// 
  /// // Second page
  /// final secondPage = await lb.playlists.getPlaylists('username', null, 25);
  /// ```
  Future<PlaylistApiResponse> getPlaylists(String user, [int? count, int? offset]) async {
    final paramsList = <Map<String, dynamic>>[
      { 'count': count ?? ListenBrainzConstants.DEFAULT_NUMBER_OF_PLAYLISTS_PER_CALL },
    ];

    if (offset != null) {
      paramsList.add({ 'offset': offset });
    }

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/playlists',
      httpClient: _client, 
      rateLimiter: limiter,
      params: paramsList,
      token: params.token,
    );

    final result = ResponseHandler.handleResponse(response, (decoded) {
      return PlaylistApiResponse.fromJson(decoded);
    });

    return result;
  }

  /// Fetches playlists that have been created for a given user.
  /// 
  /// GET /1/user/{user}/playlists/createdfor
  /// 
  /// From ListenBrainz docs:
  /// > Fetch playlist metadata in [JSPF format](https://musicbrainz.org/doc/jspf#playlist) 
  /// > without recordings that have been created for the user. 
  /// > Createdfor playlists are all public, so no Authorization is needed for this call.
  /// 
  /// These are playlists that were automatically generated for the user
  /// (e.g., by playlist bots or recommendation systems).
  /// 
  /// Example:
  /// ```dart
  /// final createdForPlaylists = await lb.playlists.getCreatedFor('username');
  /// ```
  Future<PlaylistApiResponse> getCreatedFor(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/playlists/createdfor',
      httpClient: _client, 
      rateLimiter: limiter,
    );

    final result = ResponseHandler.handleResponse(response, (decoded) {
      return PlaylistApiResponse.fromJson(decoded);
    });

    return result;
  }

  /// Fetches playlists for which a user is a collaborator.
  /// 
  /// GET /1/user/{user}/playlists/collaborator
  /// 
  /// From ListenBrainz docs:
  /// > Fetch playlist metadata in [JSPF format](https://musicbrainz.org/doc/jspf#playlist) 
  /// > without recordings for which a user is a collaborator.
  /// > If a playlist is private, it will only be returned if the caller is authorized 
  /// > to edit that playlist.
  /// 
  /// Requires authentication. The user token must be provided in the Authorization header.
  /// 
  /// Example:
  /// ```dart
  /// final collaboratorPlaylists = await lb.playlists.getCollaborator('username');
  /// ```
  Future<PlaylistApiResponse> getCollaborator(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/playlists/collaborator',
      httpClient: _client, 
      rateLimiter: limiter,
      token: params.token,
    );

    final result = ResponseHandler.handleResponse(response, (decoded) {
      return PlaylistApiResponse.fromJson(decoded);
    });

    return result;
  }

  /// Fetches recommended playlists for a given user.
  /// 
  /// GET /1/user/{user}/playlists/recommendations
  /// 
  /// Returns playlist recommendations based on the user's listening history.
  /// 
  /// Example:
  /// ```dart
  /// final recommendedPlaylists = await lb.playlists.recommendations('username');
  /// ```
  Future<PlaylistApiResponse> recommendations(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/user/$user/playlists/recommendations',
      httpClient: _client, 
      rateLimiter: limiter,
    );

    final result = ResponseHandler.handleResponse(response, (decoded) {
      return PlaylistApiResponse.fromJson(decoded);
    });

    return result;
  }

  /// From ListenBrainz docs:
  /// > Create a playlist. 
  /// > The playlist must be in JSPF format with MusicBrainz extensions, 
  /// > which is defined here: https://musicbrainz.org/doc/jspf . 
  /// > To create an empty playlist, you can send an empty playlist with only the title field filled out. 
  /// > If you would like to create a playlist populated with recordings, 
  /// > each of the track items in the playlist must have an identifier 
  /// > element that contains the MusicBrainz recording that includes the recording MBID.
  ///
  /// > When creating a playlist, only the playlist title and the track identifier elements will be used,
  /// > all other elements in the posted JSPF wil be ignored.
  /// 
  /// If a created_for field is found and the user is not an approved playlist bot, 
  /// then an [ApiException] will be thrown.
  Future<bool> create(Playlist playlist) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/playlist/create', 
      body: playlist.toJson(), 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse<bool>(response, (decoded) {
      if (decoded['status'] == 'ok') return true;
      return response.statusCode == 200;
    });
  }

  /// Searches for playlists by name or description.
  /// 
  /// GET /1/playlist/search
  /// 
  /// Parameters:
  /// - [query]: The search query string. Must be at least 3 characters long.
  /// 
  /// Throws an [ArgumentError] if the query is less than 3 characters.
  /// 
  /// Returns a [PlaylistApiResponse] containing matching playlists.
  /// 
  /// Example:
  /// ```dart
  /// final results = await lb.playlists.search('jazz classics');
  /// ```
  Future<PlaylistApiResponse> search(String query) async {
    if (query.length < 3) throw ArgumentError('The search query must be at least 3 characters long.');

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/playlist/search',
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
        { 'query': query },
      ],
    );

    final result = ResponseHandler.handleResponse(response, (decoded) {
      return PlaylistApiResponse.fromJson(decoded);
    });
    
    return result;
  }

  /// Edits the metadata of an existing playlist.
  /// 
  /// POST /1/playlist/edit/{mbid}
  /// 
  /// Edits the private/public status, name, description, or list of collaborators 
  /// for an existing playlist. All fields will be overwritten with new values.
  /// 
  /// Parameters:
  /// - [playlist]: The playlist object with updated values. The [Playlist.identifier] 
  ///   field must be set to the MBID of the playlist to edit.
  /// 
  /// The Authorization header must be set and correspond to the owner of the playlist,
  /// otherwise an [ApiException] will be thrown.
  /// 
  /// Returns `true` if the edit was successful.
  /// 
  /// Example:
  /// ```dart
  /// final updatedPlaylist = Playlist(
  ///   identifier: existingPlaylistMbid,
  ///   title: 'Updated Playlist Name',
  ///   // ... other fields
  /// );
  /// await lb.playlists.edit(updatedPlaylist);
  /// ```
  Future<bool> edit(Playlist playlist) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/edit/${playlist.identifier}',
      body: PlaylistPayload(playlist: playlist).toJson(),
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return response.statusCode == 200;
    });
  }

  /// Fetches a playlist by its MusicBrainz ID (MBID).
  /// 
  /// GET /1/playlist/{mbid}
  /// 
  /// Parameters:
  /// - [mbid]: The MusicBrainz ID of the playlist to fetch.
  /// - [metadata]: Whether to fetch additional metadata for the playlist tracks.
  /// 
  /// Returns the full playlist object including all tracks and metadata.
  /// 
  /// Example:
  /// ```dart
  /// final playlist = await lb.playlists.getByMbid(
  ///   UuidString('playlist-mbid-here'),
  ///   true, // fetchMetadata
  /// );
  /// ```
  Future<Playlist> getByMbid(UuidString mbid, bool metadata/* , bool xspf */) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/$mbid', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
        { 'fetch_metadata': metadata },
      ],
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return Playlist.fromJson(decoded['playlist']);
    });
  }

  /// Appends recordings to an existing playlist.
  /// 
  /// POST /1/playlist/{mbid}/item/add/{offset}
  /// 
  /// From ListenBrainz docs:
  /// > Append recordings to an existing playlist by posting a playlist with one or more recordings in it. 
  /// > The playlist must be in [JSPF format](https://musicbrainz.org/doc/jspf) with MusicBrainz extensions.
  /// > If the offset is provided, then the recordings will be added at that offset, 
  /// > otherwise they will be added at the end of the playlist.
  /// > You may only add [ListenBrainzConstants.MAX_RECORDINGS_PER_ADD] recordings in one call to this endpoint.
  /// 
  /// Parameters:
  /// - [offset]: Optional 0-based index where to insert the recordings. If `null`, recordings are appended to the end.
  /// - [playlist]: The playlist object containing the recordings to add. You do not need to send an entire 
  ///   [Playlist] object; the only requirement is the [Playlist.track] field. You should also set the 
  ///   [Playlist.identifier] field to match the playlist you want to append to.
  /// 
  /// Returns `true` if the recordings were successfully added.
  /// 
  /// Example:
  /// ```dart
  /// final playlist = Playlist(
  ///   identifier: existingPlaylistMbid,
  ///   track: [/* new tracks to add */],
  /// );
  /// // Add at the end
  /// await lb.playlists.addRecordings(playlist: playlist);
  /// 
  /// // Add at index 5
  /// await lb.playlists.addRecordings(offset: 5, playlist: playlist);
  /// ```
  Future<bool> addRecordings({int? offset, required Playlist playlist}) async {
    final endpoint = 
        '/1/playlist/${playlist.identifier}/item/add${offset == null ? '' : '/$offset'}';

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: endpoint, 
      body: PlaylistPayload(playlist: playlist).toJson(),
      userToken: params.token,
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return decoded['status'] == 'ok';
    });
  }

  /// Moves one or more recordings within a playlist.
  /// 
  /// POST /1/playlist/{mbid}/item/move
  /// 
  /// From ListenBrainz docs:
  /// > To move an item in a playlist, the POST data needs to specify the recording MBID 
  /// > and current index of the track to move (from), where to move it to (to) 
  /// > and how many tracks from that position should be moved (count).
  /// 
  /// Parameters:
  /// - [playlistMbid]: The MusicBrainz ID of the playlist.
  /// - [recMbid]: The MusicBrainz ID of the recording to move.
  /// - [from]: The 0-based index of the current position of the recording(s).
  /// - [to]: The 0-based index of the target position.
  /// - [count]: The number of tracks to move starting from [from].
  /// 
  /// Returns `true` if the move was successful.
  /// 
  /// Example:
  /// ```dart
  /// // Move a single recording from index 5 to index 2
  /// await lb.playlists.moveRecording(
  ///   playlistMbid,
  ///   recordingMbid,
  ///   5, // from
  ///   2, // to
  ///   1, // count
  /// );
  /// ```
  Future<bool> moveRecording(UuidString playlistMbid, UuidString recMbid, int from, int to, int count) async {
    final body = {
      "mbid": recMbid.value,
      "from": from,
      "to": to,
      "count": count
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/${playlistMbid.value}/item/move',
      body: body,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return decoded['status'] == 'ok';
    });
  }

  /// Deletes one or more recordings from a playlist.
  /// 
  /// POST /1/playlist/{mbid}/item/delete
  /// 
  /// Parameters:
  /// - [playlistMbid]: The MusicBrainz ID of the playlist.
  /// - [index]: The 0-based index of the first recording to delete.
  /// - [count]: The number of recordings to delete starting from [index].
  /// 
  /// Returns `true` if the deletion was successful.
  /// 
  /// Example:
  /// ```dart
  /// // Delete a single recording at index 5
  /// await lb.playlists.deleteRecording(playlistMbid, 5, 1);
  /// 
  /// // Delete 3 recordings starting from index 10
  /// await lb.playlists.deleteRecording(playlistMbid, 10, 3);
  /// ```
  Future<bool> deleteRecording(UuidString playlistMbid, int index, int count) async {
    final body = {
      "index": index,
      "count": count
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/${playlistMbid.value}/item/delete',
      body: body,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return decoded['status'] == 'ok';
    });
  }

  /// Deletes a playlist permanently.
  /// 
  /// POST /1/playlist/{mbid}/delete
  /// 
  /// Parameters:
  /// - [playlistMbid]: The MusicBrainz ID of the playlist to delete.
  /// 
  /// The Authorization header must be set and correspond to the owner of the playlist,
  /// otherwise an [ApiException] will be thrown.
  /// 
  /// Returns `true` if the deletion was successful.
  /// 
  /// **Warning:** This action cannot be undone.
  /// 
  /// Example:
  /// ```dart
  /// await lb.playlists.delete(playlistMbid);
  /// ```
  Future<bool> delete(UuidString playlistMbid) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/${playlistMbid.value}/delete',
      body: null,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return decoded['status'] == 'ok';
    });
  }

  /// Creates a copy of an existing playlist.
  /// 
  /// POST /1/playlist/{mbid}/copy
  /// 
  /// Parameters:
  /// - [playlistMbid]: The MusicBrainz ID of the playlist to copy.
  /// 
  /// Creates a new playlist that is a copy of the specified playlist.
  /// The new playlist will be owned by the authenticated user.
  /// 
  /// Returns `true` if the copy was successful.
  /// 
  /// Example:
  /// ```dart
  /// await lb.playlists.copy(playlistMbid);
  /// ```
  Future<bool> copy(UuidString playlistMbid) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/${playlistMbid.value}/copy',
      body: null,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return decoded['status'] == 'ok';
    });
  }

  /// Exports a playlist to a connected music service.
  /// 
  /// POST /1/playlist/{mbid}/export/{service}
  /// 
  /// Parameters:
  /// - [playlistMbid]: The MusicBrainz ID of the playlist to export.
  /// - [service]: The music service to export to (e.g., [ConnectedServices.spotify]).
  /// - [isPublic]: Whether the exported playlist should be public on the target service.
  /// 
  /// The user must have authorized ListenBrainz to connect to the specified service
  /// before exporting playlists to it.
  /// 
  /// Returns a record containing the external URL of the exported playlist on the target service.
  /// 
  /// Example:
  /// ```dart
  /// final result = await lb.playlists.export(
  ///   playlistMbid,
  ///   ConnectedServices.spotify,
  ///   isPublic: true,
  /// );
  /// print('Exported playlist URL: ${result.externalUrl}');
  /// ```
  Future<({String externalUrl})> export(UuidString playlistMbid, ConnectedServices service, bool isPublic) async {
    final body = {
      'is_public': isPublic
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/${playlistMbid.value}/export/${service.value}',
      body: body,
      userToken: params.token,
      httpClient: _client,
      rateLimiter: limiter
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return (externalUrl: decoded['external_url'] as String);
    });
  }

  /// Gets playlists from a music service connected to the user account.
  /// 
  /// GET /1/playlist/import/{service}
  /// 
  /// Parameters:
  /// - [service]: The music service to fetch playlists from (e.g., [ConnectedServices.spotify]).
  /// 
  /// The user must have authorized ListenBrainz to connect to the specified service
  /// before importing playlists from it.
  /// 
  /// Returns a list of playlists available for import from the specified service.
  /// 
  /// Example:
  /// ```dart
  /// final spotifyPlaylists = await lb.playlists.get3rdPartyPlaylists(
  ///   ConnectedServices.spotify,
  /// );
  /// ```
  Future<List<ImportedPlaylist>> get3rdPartyPlaylists(ConnectedServices service) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: '/1/playlist/import/${service.value}',
      httpClient: _client,
      rateLimiter: limiter,
      token: params.token,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      final List<ImportedPlaylist> importedPlaylists = [];

      for (var pl in decoded as List) {
        importedPlaylists.add(ImportedPlaylist.fromJson(pl));
      }
      return importedPlaylists;
    });
  }

  /// Imports a playlist from a connected music service into ListenBrainz.
  /// 
  /// GET /1/playlist/{service}/{playlist_id}/tracks
  /// 
  /// Parameters:
  /// - [serviceToImport]: The music service to import from (e.g., [ConnectedServices.spotify]).
  /// - [playlistIdOnService]: The ID of the playlist on the source service.
  /// 
  /// The user must have authorized ListenBrainz to connect to the specified service
  /// before importing playlists from it.
  /// 
  /// Returns a record containing:
  /// - [identifier]: The MusicBrainz ID of the newly created playlist in ListenBrainz.
  /// - [playlist]: The imported playlist object.
  /// 
  /// Example:
  /// ```dart
  /// final result = await lb.playlists.importFrom(
  ///   ConnectedServices.spotify,
  ///   'spotify-playlist-id',
  /// );
  /// print('Imported playlist MBID: ${result.identifier}');
  /// ```
  Future<({
    UuidString identifier,
    Playlist playlist,
  })> importFrom(ConnectedServices serviceToImport, String playlistIdOnService) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/playlist/${serviceToImport.value}/$playlistIdOnService/tracks', 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      final identifier = UuidString(decoded['identifier']);
      final playlist = Playlist.fromJson(decoded['playlist']);

      return (
        identifier: identifier,
        playlist: playlist,
      );
    });
  }

  /// Exports a playlist in JSPF format to a connected music service.
  /// 
  /// POST /1/playlist/export-jspf/{service}
  /// 
  /// Parameters:
  /// - [service]: The music service to export to (e.g., [ConnectedServices.spotify]).
  /// - [playlist]: The playlist object to export (must be in JSPF format).
  /// - [isPublic]: Whether the exported playlist should be public on the target service.
  /// 
  /// This method exports a playlist object directly (rather than an existing playlist by MBID).
  /// The playlist must be in [JSPF format](https://musicbrainz.org/doc/jspf) with MusicBrainz extensions.
  /// 
  /// The user must have authorized ListenBrainz to connect to the specified service
  /// before exporting playlists to it.
  /// 
  /// Returns a record containing the external URL of the exported playlist on the target service.
  /// 
  /// Example:
  /// ```dart
  /// final playlist = Playlist(
  ///   title: 'My Playlist',
  ///   track: [/* playlist tracks */],
  /// );
  /// final result = await lb.playlists.exportJspf(
  ///   ConnectedServices.spotify,
  ///   playlist,
  ///   isPublic: false,
  /// );
  /// ```
  Future<({
    String externalUrl,
  })> exportJspf(ConnectedServices service, Playlist playlist, bool isPublic) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/playlist/export-jspf/${service.value}', 
      body: PlaylistPayload(playlist: playlist).toJson(), 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return (
        externalUrl: decoded['external_url'] as String
      );
    });
  }
}
