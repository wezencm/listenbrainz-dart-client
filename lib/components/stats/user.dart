import 'package:listenbrainz/src/fetch_stats_helper.dart';
import 'package:listenbrainz/components/stats/stats.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/response_handler.dart';
import 'package:listenbrainz/src/utils/request_helpers.dart';
import 'package:listenbrainz/types/stats/stats.dart';

class User {
  User(this.parent, this.username);
  final String username;
  final Stats parent;

  /// Get top artists for user 
  /// 
  /// GET /1/stats/user/(mb_username: user_name)/artists
  /// 
  /// Example:
  /// ```dart
  /// final topUserArtists = listenbrainz.stats.user("user").artists();
  /// ```
  Future<TopArtists?> artists({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    return fetchStats<TopArtists>(
      statsInstance: parent,
      endpoint: "/1/stats/user/$username/artists",
      fromJson: TopArtists.fromJson,
      count: count,
      offset: offset,
      range: range,
    );
  }

  Future<TopReleases?> releases({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.value(count);
    }

    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/releases", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "count": count },
        { "offset": offset },
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return TopReleases.fromJson(results);
  }

  Future<TopReleaseGroups?> releaseGroups({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.value(count);
    }

    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/release-groups", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "count": count },
        { "offset": offset },
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return TopReleaseGroups.fromJson(results);
  }

  Future<TopRecordings?> recordings({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    if (count > ListenBrainzConstants.MAX_ITEMS_PER_GET) {
      throw RangeError.value(count);
    }

    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/recordings", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "count": count },
        { "offset": offset },
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return TopRecordings.fromJson(results);
  }

  Future<ListeningActivityPayload?> listeningActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/listening-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return ListeningActivityPayload.fromJson(results);
  }

  Future<ArtistActivityPayload?> artistActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/artist-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return ArtistActivityPayload.fromJson(results);
  }

  Future<EraActivityPayload?> eraActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/era-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return EraActivityPayload.fromJson(results);
  }

  Future<GenreActivityPayload?> genreActivity() async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/genre-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return GenreActivityPayload.fromJson(results);
  }

  Future<ArtistEvolutionActivityPayload?> artistEvolutionActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/artist-evolution-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return ArtistEvolutionActivityPayload.fromJson(results);
  }

  Future<DailyActivityPayload?> dailyActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/daily-activity", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return DailyActivityPayload.fromJson(results);
  }

  Future<ArtistMapPayload?> artistMap([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/artist-map", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
      params: [
        { "range": range.value },
      ],
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return ArtistMapPayload.fromJson(results);
  }

  Future<YearInMusic?> yearInMusic([int? year, bool legacy = false]) async {

    /* final useLegacy = legacy ? "legacy/" : "";
    final useYear = year ?? ""; */

    final response = await getFromLb(
      listenbrainzURL: parent.params.listenBrainzServerUrl, 
      endpoint: "/1/stats/user/$username/year-in-music",///$useLegacy$useYear", 
      httpClient: parent.client, 
      rateLimiter: parent.limiter,
    );

    final results = ResponseHandler.handleResponse(response, (decoded) {
      return ResponseHandler.extractPayload(decoded);
    });

    return YearInMusic.fromJson(results['data']);
  }
}

class UserHandler {
  UserHandler(this.parent);
  final Stats parent;

  User call(String username) {
    return User(parent, username);
  }
}
