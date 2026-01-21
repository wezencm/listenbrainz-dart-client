import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'era_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class EraActivityPayload extends StatsFields {
  final List<EraActivity> eraActivity;

  EraActivityPayload({
    required this.eraActivity,
    super.offset,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory EraActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$EraActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$EraActivityPayloadToJson(this);
}

@JsonSerializable()
class EraActivity {
  final int year;
  final int listenCount;

  EraActivity({
    required this.year,
    required this.listenCount,
  });

  factory EraActivity.fromJson(Map<String, dynamic> json) => 
    _$EraActivityFromJson(json);

  Map<String, dynamic> toJson() => _$EraActivityToJson(this);
}