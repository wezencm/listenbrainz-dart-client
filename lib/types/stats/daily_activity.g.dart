// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyActivityPayload _$DailyActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    DailyActivityPayload(
      dailyActivity: DailyActivity.fromJson(
          json['daily_activity'] as Map<String, dynamic>),
      range:
          $enumDecodeNullable(_$AllowedStatisticsRangeEnumMap, json['range']),
      lastUpdated: const DateTimeMillisecondsConverter()
          .fromJson((json['last_updated'] as num).toInt()),
      userId: json['user_id'] as String?,
      from: const DateTimeMillisecondsConverter()
          .fromJson((json['from_ts'] as num).toInt()),
      to: const DateTimeMillisecondsConverter()
          .fromJson((json['to_ts'] as num).toInt()),
    );

Map<String, dynamic> _$DailyActivityPayloadToJson(
    DailyActivityPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('range', _$AllowedStatisticsRangeEnumMap[instance.range]);
  val['last_updated'] =
      const DateTimeMillisecondsConverter().toJson(instance.lastUpdated);
  writeNotNull('user_id', instance.userId);
  val['from_ts'] = const DateTimeMillisecondsConverter().toJson(instance.from);
  val['to_ts'] = const DateTimeMillisecondsConverter().toJson(instance.to);
  val['daily_activity'] = instance.dailyActivity.toJson();
  return val;
}

const _$AllowedStatisticsRangeEnumMap = {
  AllowedStatisticsRange.thisWeek: 'this_week',
  AllowedStatisticsRange.thisMonth: 'this_month',
  AllowedStatisticsRange.thisYear: 'this_year',
  AllowedStatisticsRange.week: 'week',
  AllowedStatisticsRange.month: 'month',
  AllowedStatisticsRange.quarter: 'quarter',
  AllowedStatisticsRange.year: 'year',
  AllowedStatisticsRange.halfYearly: 'half_yearly',
  AllowedStatisticsRange.allTime: 'all_time',
};

DailyActivity _$DailyActivityFromJson(Map<String, dynamic> json) =>
    DailyActivity(
      sunday: (json['Sunday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      monday: (json['Monday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['Tuesday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['Wednesday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['Thursday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      friday: (json['Friday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['Saturday'] as List<dynamic>)
          .map((e) => DailyActivityDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyActivityToJson(DailyActivity instance) =>
    <String, dynamic>{
      'Sunday': instance.sunday.map((e) => e.toJson()).toList(),
      'Monday': instance.monday.map((e) => e.toJson()).toList(),
      'Tuesday': instance.tuesday.map((e) => e.toJson()).toList(),
      'Wednesday': instance.wednesday.map((e) => e.toJson()).toList(),
      'Thursday': instance.thursday.map((e) => e.toJson()).toList(),
      'Friday': instance.friday.map((e) => e.toJson()).toList(),
      'Saturday': instance.saturday.map((e) => e.toJson()).toList(),
    };

DailyActivityDay _$DailyActivityDayFromJson(Map<String, dynamic> json) =>
    DailyActivityDay(
      hour: (json['hour'] as num).toInt(),
      listenCount: (json['listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$DailyActivityDayToJson(DailyActivityDay instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'listen_count': instance.listenCount,
    };
