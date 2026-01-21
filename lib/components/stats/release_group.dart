
import 'package:listenbrainz/src/fetch_stats_helper.dart';
import 'package:listenbrainz/components/stats/stats.dart';
import 'package:listenbrainz/types/stats/stats.dart';
import 'package:listenbrainz/types/types.dart';

class ReleaseGroup {
  ReleaseGroup(this.parent, this.releaseGroupMbid);
  final UuidString releaseGroupMbid;
  final Stats parent;

  /// Get top listeners for the release group. 
  /// 
  /// This includes the total listen count for the release group and top N listeners with 
  /// their individual listen count for that release group in a given time range.
  /// 
  /// Parameters:
  /// - [range]: A [AllowedStatisticsRange] time interval for which statistics should be returned
  /// 
  /// Returns [ReleaseGroupListeners] with the statistic data,
  /// or `null` if the statistics wwasn't calculated.
  /// 
  /// Example:
  /// ```dart
  /// final releaseGroupMbid = UuidString('8042c203-e000-4690-94dd-2e2b46a4e538');
  /// final statsListeners = listenbrainz
  ///                           .stats
  ///                           .releaseGroup(releaseGroupMbid)
  ///                           .listeners(AllowedStatisticsRange.thisWeek);
  /// ```
  Future<ReleaseGroupListeners?> listeners([
    AllowedStatisticsRange range = AllowedStatisticsRange.allTime
  ]) async {
    return fetchStats<ReleaseGroupListeners>(
      statsInstance: parent,
      endpoint: "/1/stats/release-group/$releaseGroupMbid/listeners",
      fromJson: ReleaseGroupListeners.fromJson,
      range: range,
    );
  }
}

class ReleaseGroupHandler {
  ReleaseGroupHandler(this.parent);
  final Stats parent;
  
  ReleaseGroup call(UuidString releaseGroupMbid) {
    return ReleaseGroup(parent, releaseGroupMbid);
  }
}
