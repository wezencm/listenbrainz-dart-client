import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'artist_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class ArtistActivityPayload extends StatsFields{
  final List<ArtistActivity> artistActivity;

  ArtistActivityPayload({
    required this.artistActivity,
    super.offset,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory ArtistActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$ArtistActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistActivityPayloadToJson(this);
}

@JsonSerializable(includeIfNull: true)
@UuidConverter()
class ArtistActivity {
  final String name;
  @JsonKey(includeIfNull: false)
  final String? artistName;
  final UuidString? artistMbid;
  final int listenCount;
  final List<ArtistActivityAlbum>? albums;

  ArtistActivity({
    required this.name,
    this.artistName,
    this.artistMbid,
    required this.listenCount,
    this.albums,
  });

  factory ArtistActivity.fromJson(Map<String, dynamic> json) => 
    _$ArtistActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistActivityToJson(this);
}

@JsonSerializable(includeIfNull: true)
@UuidConverter()
class ArtistActivityAlbum {
  final String name;
  final int listenCount;
  final UuidString? releaseGroupMbid;

  ArtistActivityAlbum({
    required this.name,
    required this.listenCount,
    this.releaseGroupMbid,
  });

  factory ArtistActivityAlbum.fromJson(Map<String, dynamic> json) => 
    _$ArtistActivityAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistActivityAlbumToJson(this);
}
