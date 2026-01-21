import 'package:listenbrainz/src/fetch_stats_helper.dart';
import 'package:listenbrainz/components/stats/stats.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/types/stats/stats.dart';

/// Provides access to sitewide statistics from ListenBrainz.
///
/// This class contains methods to fetch various sitewide statistics such as top artists,
/// releases, recordings, and activity data across the entire ListenBrainz platform.
class SiteWide {
  SiteWide(this.parent);
  final Stats parent;

  /// Get sitewide top artists.
  /// 
  /// GET /1/stats/sitewide/artists
  /// 
  /// Parameters:
  /// - [count]: The number of items to return (default: 25)
  /// - [offset]: The offset for pagination (default: 0)
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ArtistListeners] with the statistic data,
  /// or `null` if the statistics wwasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final topArtists = listenbrainz
  ///                       .stats
  ///                       .sitewide
  ///                       .artists(range: AllowedStatisticsRange.thisWeek);
  /// ```
  Future<TopArtists?> artists({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    return fetchStats<TopArtists>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/artists",
      fromJson: TopArtists.fromJson,
      count: count,
      offset: offset,
      range: range,
    );
  }

  /// Get sitewide top releases.
  /// 
  /// GET /1/stats/sitewide/releases
  /// 
  /// Parameters:
  /// - [count]: The number of items to return (default: 25)
  /// - [offset]: The offset for pagination (default: 0)
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [TopReleases] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final topReleases = listenbrainz
  ///                        .stats
  ///                        .sitewide
  ///                        .releases(range: AllowedStatisticsRange.thisWeek);
  /// ```
  Future<TopReleases?> releases({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    return fetchStats<TopReleases>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/releases",
      fromJson: TopReleases.fromJson,
      count: count,
      offset: offset,
      range: range,
    );
  }

  /// Get sitewide top release groups.
  /// 
  /// GET /1/stats/sitewide/release-groups
  /// 
  /// Parameters:
  /// - [count]: The number of items to return (default: 25)
  /// - [offset]: The offset for pagination (default: 0)
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [TopReleaseGroups] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final topReleaseGroups = 
  ///     listenbrainz
  ///        .stats
  ///        .sitewide
  ///        .releaseGroups(range: AllowedStatisticsRange.thisWeek);
  /// ```
  Future<TopReleaseGroups?> releaseGroups({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    return fetchStats<TopReleaseGroups>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/release-groups",
      fromJson: TopReleaseGroups.fromJson,
      count: count,
      offset: offset,
      range: range,
    );
  }

  /// Get sitewide top recordings.
  /// 
  /// GET /1/stats/sitewide/recordings
  /// 
  /// Parameters:
  /// - [count]: The number of items to return (default: 25)
  /// - [offset]: The offset for pagination (default: 0)
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [TopRecordings] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final topRecordings = 
  ///     listenbrainz
  ///        .stats
  ///        .sitewide
  ///        .recordings(range: AllowedStatisticsRange.thisWeek);
  /// ```
  Future<TopRecordings?> recordings({
    int count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    int offset = 0,
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime,
  }) async {
    return fetchStats<TopRecordings>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/recordings",
      fromJson: TopRecordings.fromJson,
      count: count,
      offset: offset,
      range: range,
    );
  }
  
  /// Get sitewide listening activity.
  /// 
  /// GET /1/stats/sitewide/listening-activity
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ListeningActivityPayload] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final listeningActivity = 
  ///     listenbrainz
  ///        .stats
  ///        .sitewide
  ///        .listeningActivity(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ListeningActivityPayload?> listeningActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ListeningActivityPayload>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/listening-activity",
      fromJson: ListeningActivityPayload.fromJson,
      range: range,
    );
  }

  /// Get sitewide artist activity.
  /// 
  /// GET /1/stats/sitewide/artist-activity
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ArtistActivityPayload] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final artistActivity = listenbrainz
  ///                           .stats
  ///                           .sitewide
  ///                           .artistActivity(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ArtistActivityPayload?> artistActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ArtistActivityPayload>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/artist-activity",
      fromJson: ArtistActivityPayload.fromJson,
      range: range,
    );
  }

  /// Get sitewide era activity.
  /// 
  /// GET /1/stats/sitewide/era-activity
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [EraActivityPayload] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final eraActivity = listenbrainz
  ///                        .stats
  ///                        .sitewide
  ///                        .eraActivity(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<EraActivityPayload?> eraActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<EraActivityPayload>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/era-activity",
      fromJson: EraActivityPayload.fromJson,
      range: range,
    );
  }

  /// Get sitewide artist evolution activity.
  /// 
  /// GET /1/stats/sitewide/artist-evolution-activity
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ArtistEvolutionActivityPayload] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final artistEvolutionActivity = 
  ///     listenbrainz
  ///       .stats
  ///       .sitewide
  ///       .artistEvolutionActivity(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ArtistEvolutionActivityPayload?> artistEvolutionActivity([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ArtistEvolutionActivityPayload>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/artist-evolution-activity",
      fromJson: ArtistEvolutionActivityPayload.fromJson,
      range: range,
    );
  }

  /// Get sitewide artist map.
  /// 
  /// GET /1/stats/sitewide/artist-map
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ArtistMapPayload] with the statistic data,
  /// or `null` if the statistics wasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final artistMap = listenbrainz
  ///                      .stats
  ///                      .sitewide
  ///                      .artistMap(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ArtistMapPayload?> artistMap([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ArtistMapPayload>(
      statsInstance: parent,
      endpoint: "/1/stats/sitewide/artist-map",
      fromJson: ArtistMapPayload.fromJson,
      range: range,
    );
  }
}