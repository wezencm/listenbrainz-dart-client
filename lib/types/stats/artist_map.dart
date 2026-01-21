import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'artist_map.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class ArtistMapPayload extends StatsFields {
  final List<ArtistMap> artistMap;
  final AllowedStatisticsRange? statsRange;
  
  ArtistMapPayload({
    required this.artistMap,
    this.statsRange,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory ArtistMapPayload.fromJson(Map<String, dynamic> json) => 
    _$ArtistMapPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistMapPayloadToJson(this);
}

@JsonSerializable()
class ArtistMap {
  final int artistCount;
  final String country;
  final int listenCount;
  final List<ArtistMapArtist> artists;

  ArtistMap({
    required this.artistCount,
    required this.country,
    required this.listenCount,
    required this.artists,
  });

  factory ArtistMap.fromJson(Map<String, dynamic> json) => 
    _$ArtistMapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistMapToJson(this);
}

@JsonSerializable()
@UuidConverter()
class ArtistMapArtist {
  final UuidString? artistMbid;
  final String artistName;
  final int listenCount;

  ArtistMapArtist({
    this.artistMbid,
    required this.artistName,
    required this.listenCount,
  });

  factory ArtistMapArtist.fromJson(Map<String, dynamic> json) => 
    _$ArtistMapArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistMapArtistToJson(this);
}