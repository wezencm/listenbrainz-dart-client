import 'package:http/http.dart' as http;
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/response_handler.dart';
import 'package:listenbrainz/src/utils/request_helpers.dart';
import 'package:listenbrainz/types/feedback_score.dart';
import 'package:listenbrainz/types/fetched_feedbacks.dart';
import 'package:listenbrainz/types/instance_init.dart';
import 'package:listenbrainz/types/recording_feedback.dart';
import 'package:listenbrainz/types/recording_pin.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:listenbrainz/utils/rate_limiter.dart';

class Recordings {
  final RateLimiter limiter;
  final InitParams params;
  final http.Client _client;

  const Recordings(this.params, this.limiter, this._client);

  /// Marks a recording as `loved`.
  /// 
  /// POST /1/feedback/recording-feedback
  /// 
  /// Submit recording feedback to the ListenBrainz server
  /// 
  /// Parameters:
  /// - [mbid]: A UuidString MusicBrainz id of a recording to send the feedback
  /// - [msid]: A UuidString MessyBrainz id of a recording to send the feedback
  /// 
  /// You should pass at least one of `mbid` or `msid` of an recording.
  /// If you pass a `mbid` and a `msid`, only the `mbid` will be used.
  /// 
  /// Returns a [bool] indicating if the feedback was accepted or not.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> love({UuidString? mbid, UuidString? msid}) {
    return _updateFeedback(FeedbackScore.love, mbid: mbid, msid: msid);
  }

  /// Marks a recording as `hated`.
  /// 
  /// POST /1/feedback/recording-feedback
  /// 
  /// Submit recording feedback to the ListenBrainz server
  /// 
  /// Parameters:
  /// - [mbid]: A UuidString MusicBrainz id of a recording to send the feedback
  /// - [msid]: A UuidString MessyBrainz id of a recording to send the feedback
  /// 
  /// You should pass at least one of `mbid` or `msid` of an recording.
  /// If you pass a `mbid` and a `msid`, only the `mbid` will be used.
  /// 
  /// Returns a [bool] indicating if the feedback was accepted or not.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> hate({UuidString? mbid, UuidString? msid}){
    return _updateFeedback(FeedbackScore.hate, mbid: mbid, msid: msid);
  }

  /// Removes a feedback from a recording.
  /// 
  /// POST /1/feedback/recording-feedback
  /// 
  /// Submit recording feedback to the ListenBrainz server
  /// 
  /// Parameters:
  /// - [mbid]: A UuidString MusicBrainz id of a recording to send the feedback
  /// - [msid]: A UuidString MessyBrainz id of a recording to send the feedback
  /// 
  /// You should pass at least one of `mbid` or `msid` of an recording.
  /// If you pass a `mbid` and a `msid`, only the `mbid` will be used.
  /// 
  /// Returns a [bool] indicating if the feedback was accepted or not.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> removeFeedback({UuidString? mbid, UuidString? msid}){
    return _updateFeedback(FeedbackScore.neutral, mbid: mbid, msid: msid);
  }

  Future<bool> _updateFeedback(FeedbackScore feedback, {UuidString? mbid, UuidString? msid}) async {
/*     final score = switch (feedback) {
      'love' => 1,
      'hate' => -1,
      'remove' => 0,
      _ => 0,
    }; */

    if (mbid == null && msid == null) {
      throw ArgumentError("You should pass at least one of mbid or msid");
    }

    final body = {
      "score": feedback.value,
      if (mbid != null) "recording_mbid": mbid.toString(),
      if (msid != null) "recording_msid": msid.toString(),
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/feedback/recording-feedback', 
      body: body, 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded){
      return decoded['status'] == 'ok';
    });
  }

  /// Fetches all feedbacks ever given by a user.
  /// 
  /// GET /1/feedback/user/(mb_username: user_name)/get-feedback
  /// 
  /// Parameters:
  /// - [user]: The MusicBrainz username from the user to fetch the feedbacks
  /// - [score]: A [FeedbackScore] to filter the results.
  /// - [count]: The count of feedbacks to return
  /// - [offset]: Index of the first playlist to return (for paging through results).
  /// - [metadata]: A [bool] indicating if should return metadata for the recording
  /// 
  /// Returns a [FetchedFeedbacks] containing the feedbacks.
  Future<FetchedFeedbacks> getAllFeedbackFromUser(String user, {
    FeedbackScore? score,
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    bool metadata = false,
  }) async {

    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.range(count, 0, ListenBrainzConstants.MAX_ITEMS_PER_GET);
    }

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/feedback/user/$user/get-feedback', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
        if (score != null) {'score': score.value},
        {'count': count},
        {'offset': offset},
        {'metadata': metadata},
      ]
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return FetchedFeedbacks.fromJson(decoded);
    });
  }

  /// Get the user feedback for the given recordings.
  /// 
  /// POST /1/feedback/user/$user/get-feedback-for-recordings
  /// 
  /// Parameters:
  /// - [user]: The MusicBrainz username from the user to fetch the feedbacks
  /// - [mbids]: Alist of [UuidString] containig the `mbid`s to fetch the feedback
  /// - [msids]: Alist of [UuidString] containig the `msid`s to fetch the feedback
  /// 
  /// Return a list of [RecordingFeedback]
  Future<List<RecordingFeedback>> getUserFeedback(String user, {
    List<UuidString>? mbids, 
    List<UuidString>? msids
  }) async {
    if (mbids == null && msids == null) {
      throw ArgumentError("You should pass at least one of mbid or msid");
    }

    final body = {
      if (mbids != null) "recording_mbids": mbids.map((mbid) => mbid.toString()).toList(),
      if (msids != null) "recording_msids": msids.map((msid) => msid.toString()).toList(),
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/feedback/user/$user/get-feedback-for-recordings',
      body: body, 
      userToken: params.token, 
      httpClient: _client,
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded){
      final List<RecordingFeedback> feedbacks = [];
      for (var feedback in decoded['feedback']) {
        feedbacks.add(RecordingFeedback.fromJson(feedback));
      }
      return feedbacks;
    });
  }

  /// Get all feedbacks ever given for a recording
  Future<FetchedFeedbacks> getAllFeedbacks({
    UuidString? mbid, 
    UuidString? msid,
    FeedbackScore? score,
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
  }) async {
    if (mbid == null && msid == null) {
      throw ArgumentError("You should pass at least one of mbid or msid");
    }

    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.range(count, 0, ListenBrainzConstants.MAX_ITEMS_PER_GET);
    }

    final endpoint = '/1/feedback/recording/${mbid != null ? mbid.toString() : msid.toString()}/get-feedback${mbid != null ? '-mbid' : ''}';

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl,
      endpoint: endpoint,
      httpClient: _client,
      rateLimiter: limiter,
      params: [
        if (score != null) {'score': score.value},
        {'count': count},
        {'offset': offset},
      ],
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return FetchedFeedbacks.fromJson(decoded);
    });
  }

  // ListenBrainz docs cite a existence of a endpoint to import feedback 
  // from a external service, but there is no documentation, 
  // i tried to post to this endpoint, but all my tries resulted on an error.
  @Deprecated("There is no documentation for this endpoint")
  Future<bool> importFeedbackFrom(ConnectedServices service) async {
    return false;
  }

  /// Pin a recording
  /// 
  /// POST /1/pin
  /// 
  /// Parameters:
  /// - [pinData]: A [RecordingPin] containing info about the recording to pin
  /// 
  /// Returns a [RecordingPin] with the recording that was pinned.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<RecordingPin> pin(RecordingPin pinData) async {
    if (pinData.recordingMbid == null && pinData.recordingMsid == null) {
      throw ArgumentError('You must pass at least one of pinData.recordingMsid or pinData.recordingMbid');
    }
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/pin', 
      body: pinData.toJson(), 
      userToken: params.token,
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded){
      return RecordingPin.fromJson(decoded['pinned_recording']);
    });
  }

  /// Remove a pin
  /// 
  /// POST /1/pin/unpin
  /// 
  /// Removes the active recording pinned for the user.
  /// 
  /// Returns a [bool] indicating if the pin was removed or not.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> unpin() async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/pin/unpin', 
      body: null, 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded){
      return decoded['status'] == 'ok';
    });
  }

  /// Delete pin.
  /// 
  /// POST /1/pin/delete/(row_id)
  /// 
  /// Deletes a pin from the user history.
  /// 
  /// [unpin] will only remove the recording from the status of 'pinned',
  /// but the recording will remain in the history of recordings pinned.
  /// You'll may want to call [getAllPinsOfUser] to get a list of recording ever pinned
  /// and use this method to remove one of them.
  /// 
  /// Parameters:
  /// - [row]: The row number of the recording found in [RecordingPin.rowId].
  /// 
  /// Returns a [bool] indicating if the recording was deleted from the history.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> deletePin(int row) async {
    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/pin/delete/$row', 
      body: null, 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded){
      return decoded['status'] == 'ok';
    });
  }

  /// Get all pins of the user
  /// 
  /// GET /1/(mb_username: user_name)/pins
  /// 
  /// Get all the pins in the user pin list.
  /// 
  /// parameters:
  /// - [user]: The MusicBrainz username from the user to fetch the pins
  /// - [count]: The count of pins to return
  /// - [offset]: Index of the first playlist to return (for paging through results).
  /// 
  /// Returns a [FetchedPins] containing the pins.
  Future<FetchedPins> getAllPinsOfUser(String user, {
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
  }) async {
    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.range(count, 0, ListenBrainzConstants.MAX_ITEMS_PER_GET);
    }

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/$user/pins', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
        {'count': count},
        {'offset': offset},
      ],
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return FetchedPins.fromJson(decoded);
    });
  }

  /// Get pins from following list
  /// 
  /// GET /1/(mb_username: user_name)/pins/following
  /// 
  /// Get the current pins from all users that [user] follows.
  /// 
  /// Parameters:
  /// - [user]: The MusicBrainz username from the user to fetch the pins
  /// - [count]: The count of pins to return
  /// - [offset]: Index of the first playlist to return (for paging through results).
  /// 
  /// Returns a [FetchedPins] containing the pins.
  Future<FetchedPins> getPinsFromFollowing(String user, {
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
  }) async {
    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.range(count, 0, ListenBrainzConstants.MAX_ITEMS_PER_GET);
    }

    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/$user/pins/following', 
      httpClient: _client, 
      rateLimiter: limiter,
      params: [
        {'count': count},
        {'offset': offset},
      ],
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      return FetchedPins.fromJson(decoded);
    });
  }

  /// Update a pin
  /// 
  /// POST /1/pin/update/(row_id)
  /// 
  /// Updates the description of the pin
  /// 
  /// Parameters:
  /// - [row]: The row number of the pin to update.
  /// - [blurb]: The text content that will replace the pin content.
  /// 
  /// REturns a [bool] indicating if the pin was updated.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<bool> updatePin(int row, String blurb) async {

    final body = {
      "blurb_content": blurb,
    };

    final response = await postToLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/pin/update/$row', 
      body: body, 
      userToken: params.token, 
      httpClient: _client, 
      rateLimiter: limiter,
    );
    return ResponseHandler.handleResponse(response, (decoded){
      return decoded['status'] == 'ok';
    });
  }

  /// Get the current pin
  /// 
  /// GET /1/(mb_username: user_name)/pins/current
  /// 
  /// Get the active pin of the user
  /// 
  /// Parameters:
  /// - [user]: The MusicBrainz username from the user to fetch the pin.
  /// 
  /// Retuns a [RecordingPin] if a pin was found, [null] otherwise.
  /// 
  /// Throws an [ApiException] in case of an unknown error or 
  /// an [ApiUnauthorized] in case token authentication fails.
  Future<RecordingPin?> getCurrentPinForUser(String user) async {
    final response = await getFromLb(
      listenbrainzURL: params.listenBrainzServerUrl, 
      endpoint: '/1/$user/pins/current', 
      httpClient: _client, 
      rateLimiter: limiter,
    );

    return ResponseHandler.handleResponse(response, (decoded) {
      if(decoded['pinned_recording'] == null) return null;
      decoded['pinned_recording']['user_name'] = decoded['user_name'];

      return RecordingPin.fromJson(decoded['pinned_recording']);
    });
  }
}
