import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'genre_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class GenreActivityPayload extends StatsFields {
  final List<GenreActivity> genreActivity;

  GenreActivityPayload({
    required this.genreActivity,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory GenreActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$GenreActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$GenreActivityPayloadToJson(this);
}

@JsonSerializable()
class GenreActivity {
  final String genre;
  final int hour;
  final int listenCount;

  GenreActivity({
    required this.genre,
    required this.hour,
    required this.listenCount,
  });

  factory GenreActivity.fromJson(Map<String, dynamic> json) => 
    _$GenreActivityFromJson(json);

  Map<String, dynamic> toJson() => _$GenreActivityToJson(this);
}