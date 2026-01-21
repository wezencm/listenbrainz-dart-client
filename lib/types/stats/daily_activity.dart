import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';
import 'package:listenbrainz/types/stats/fields.dart';

part 'daily_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class DailyActivityPayload extends StatsFields {
  final DailyActivity dailyActivity;

  DailyActivityPayload({
    required this.dailyActivity,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory DailyActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$DailyActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DailyActivityPayloadToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DailyActivity {
  final List<DailyActivityDay> sunday;
  final List<DailyActivityDay> monday;
  final List<DailyActivityDay> tuesday;
  final List<DailyActivityDay> wednesday;
  final List<DailyActivityDay> thursday;
  final List<DailyActivityDay> friday;
  final List<DailyActivityDay> saturday;

  DailyActivity({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  
  factory DailyActivity.fromJson(Map<String, dynamic> json) => 
    _$DailyActivityFromJson(json);

  Map<String, dynamic> toJson() => _$DailyActivityToJson(this);
}

@JsonSerializable()
class DailyActivityDay {
  final int hour;
  final int listenCount;

  DailyActivityDay({
    required this.hour,
    required this.listenCount,
  });

  factory DailyActivityDay.fromJson(Map<String, dynamic> json) => 
    _$DailyActivityDayFromJson(json);

  Map<String, dynamic> toJson() => _$DailyActivityDayToJson(this);
}