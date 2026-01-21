import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';
import 'package:listenbrainz/types/stats/top_releases.dart';

part 'top_release_groups.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class TopReleaseGroups extends StatsFields {
  final List<TopReleaseGroup> releaseGroups;
  final int totalReleaseGroupCount;
  
  TopReleaseGroups({
    required this.releaseGroups,
    required this.totalReleaseGroupCount,
    super.offset,
    super.count,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory TopReleaseGroups.fromJson(Map<String, dynamic> json) => 
    _$TopReleaseGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$TopReleaseGroupsToJson(this);
}

@UuidConverter()
@JsonSerializable(includeIfNull: true)
class TopReleaseGroup {
  final List<UuidString>? artistMbids;
  final String artistName;
  final int? caaId;
  final UuidString? caaReleaseMbid;
  final int listenCount;
  final UuidString? releaseGroupMbid;
  final String releaseGroupName;
  @JsonKey(includeIfNull: false)
  final List<TopReleaseArtist>? artists;

  TopReleaseGroup({
    this.artistMbids,
    required this.artistName,
    this.caaId,
    this.caaReleaseMbid,
    required this.listenCount,
    required this.releaseGroupMbid,
    required this.releaseGroupName,
    this.artists,
  });

  factory TopReleaseGroup.fromJson(Map<String, dynamic> json) => 
    _$TopReleaseGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TopReleaseGroupToJson(this);
}
