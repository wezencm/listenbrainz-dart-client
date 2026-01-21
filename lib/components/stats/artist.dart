import 'package:listenbrainz/src/fetch_stats_helper.dart';
import 'package:listenbrainz/components/stats/stats.dart';
import 'package:listenbrainz/types/stats/stats.dart';
import 'package:listenbrainz/types/types.dart';


class Artist {
  Artist(this.parent, this.artistMbid);
  final UuidString artistMbid;
  final Stats parent;

  /// Get top listeners for the artist. 
  /// 
  /// This includes the total listen count for the artist and top N listeners with 
  /// their individual listen count for that artist in a given time range.
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ArtistListeners] with the statistic data,
  /// or `null` if the statistics wwasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final artistMbid = UuidString('650726c6-cda9-4fc6-aac5-291e8628dfdf');
  /// final statsListeners = listenbrainz
  ///                           .stats
  ///                           .artist(artistMbid)
  ///                           .listeners(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ArtistListeners?> listeners([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ArtistListeners>(
      statsInstance: parent,
      endpoint: "/1/stats/artist/$artistMbid/listeners",
      fromJson: ArtistListeners.fromJson,
      range: range,
    );
  }
}

class ArtistHandler {
  ArtistHandler(this.parent);
  final Stats parent;

  Artist call(UuidString artistMbid) {
    return Artist(parent, artistMbid);
  }
}