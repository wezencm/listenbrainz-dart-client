import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/stats_listeners.dart';

part 'release_group_listeners.g.dart';

@JsonSerializable(includeIfNull: true)
@UuidConverter()
@DateTimeMillisecondsConverter()
class ReleaseGroupListeners extends StatsListenersBase {
  final List<UuidString>? artistMbids;
  final int? caaId;
  final UuidString? caaReleaseMbid;
  final UuidString? releaseGroupMbid;
  final String releaseGroupName;

  ReleaseGroupListeners({
    this.artistMbids,
    this.caaId,
    this.caaReleaseMbid,
    this.releaseGroupMbid,
    required this.releaseGroupName,
    required super.artistName,
    required super.from,
    required super.to,
    required super.lastUpdated,
    required super.statsRange,
    required super.listeners,
    required super.totalListenCount,
    required super.totalUserCount,
  });

  
  factory ReleaseGroupListeners.fromJson(Map<String, dynamic> json) => 
    _$ReleaseGroupListenersFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseGroupListenersToJson(this);
}