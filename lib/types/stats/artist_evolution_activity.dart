import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'artist_evolution_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class ArtistEvolutionActivityPayload extends StatsFields{
  final List<ArtistEvolutionActivity> artistEvolutionActivity;

  ArtistEvolutionActivityPayload({
    required this.artistEvolutionActivity,
    super.offset,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory ArtistEvolutionActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$ArtistEvolutionActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistEvolutionActivityPayloadToJson(this);
}

@JsonSerializable()
@UuidConverter()
class ArtistEvolutionActivity {
  final UuidString? artistMbid;
  final String artistName;
  final int listenCount;
  final String timeUnit;

  ArtistEvolutionActivity({
    this.artistMbid,
    required this.artistName,
    required this.listenCount,
    required this.timeUnit,
  });

  factory ArtistEvolutionActivity.fromJson(Map<String, dynamic> json) => 
    _$ArtistEvolutionActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistEvolutionActivityToJson(this);
}