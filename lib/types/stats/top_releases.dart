import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/fields.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';

part 'top_releases.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class TopReleases extends StatsFields {
  final List<TopRelease> releases;
  final int totalReleaseCount;

  TopReleases({
    required this.releases,
    required this.totalReleaseCount,
    super.offset,
    super.count,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory TopReleases.fromJson(Map<String, dynamic> json) => 
    _$TopReleasesFromJson(json);

  Map<String, dynamic> toJson() => _$TopReleasesToJson(this);
}

@UuidConverter()
@JsonSerializable(includeIfNull: true)
class TopRelease {
  final List<UuidString>? artistMbids;
  final String artistName;
  @JsonKey(includeIfNull: false)
  final List<TopReleaseArtist>? artists;
  final int? caaId;
  final UuidString? caaReleaseMbid;
  final int listenCount;
  final UuidString? releaseMbid;
  final String releaseName;

  TopRelease({
    this.artistMbids,
    required this.artistName,
    this.artists,
    this.caaId,
    this.caaReleaseMbid,
    required this.listenCount,
    this.releaseMbid,
    required this.releaseName,
  });

  factory TopRelease.fromJson(Map<String, dynamic> json) => 
    _$TopReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$TopReleaseToJson(this);
}

@UuidConverter()
@JsonSerializable(includeIfNull: true)
class TopReleaseArtist {
  final String artistCreditName;
  final UuidString? artistMbid;
  final String joinPhrase;

  TopReleaseArtist({
    required this.artistCreditName,
    this.artistMbid,
    required this.joinPhrase,
  });

  factory TopReleaseArtist.fromJson(Map<String, dynamic> json) => 
    _$TopReleaseArtistFromJson(json);

  Map<String, dynamic> toJson() => _$TopReleaseArtistToJson(this);
}
