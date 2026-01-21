import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'top_artists.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class TopArtists extends StatsFields {
  final List<TopArtist> artists;
  final int totalArtistCount;
  
  TopArtists({
    required this.artists,
    required this.totalArtistCount,
    super.offset,
    super.count,
    super.range,
    required super.lastUpdated, 
    super.userId, 
    required super.from, 
    required super.to,
  });

  factory TopArtists.fromJson(Map<String, dynamic> json) => 
    _$TopArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$TopArtistsToJson(this);
}

@UuidConverter()
@JsonSerializable(includeIfNull: true)
class TopArtist {
  final UuidString? artistMbid;
  final String artistName;
  final int listenCount;

  TopArtist({
    required this.artistMbid,
    required this.artistName,
    required this.listenCount,
  });

  factory TopArtist.fromJson(Map<String, dynamic> json) => 
    _$TopArtistFromJson(json);

  Map<String, dynamic> toJson() => _$TopArtistToJson(this);
}
