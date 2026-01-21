// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListeningActivityPayload _$ListeningActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    ListeningActivityPayload(
      from: const DateTimeMillisecondsConverter()
          .fromJson((json['from_ts'] as num).toInt()),
      to: const DateTimeMillisecondsConverter()
          .fromJson((json['to_ts'] as num).toInt()),
      lastUpdated: const DateTimeMillisecondsConverter()
          .fromJson((json['last_updated'] as num).toInt()),
      userId: json['user_id'] as String?,
      range:
          $enumDecodeNullable(_$AllowedStatisticsRangeEnumMap, json['range']),
      listeningActivity: (json['listening_activity'] as List<dynamic>)
          .map((e) => ListeningActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListeningActivityPayloadToJson(
    ListeningActivityPayload instance) {
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
  val['listening_activity'] =
      instance.listeningActivity.map((e) => e.toJson()).toList();
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

ListeningActivity _$ListeningActivityFromJson(Map<String, dynamic> json) =>
    ListeningActivity(
      from: const DateTimeMillisecondsConverter()
          .fromJson((json['from_ts'] as num).toInt()),
      to: const DateTimeMillisecondsConverter()
          .fromJson((json['to_ts'] as num).toInt()),
      listenCount: (json['listen_count'] as num).toInt(),
      timeRange: json['time_range'] as String,
    );

Map<String, dynamic> _$ListeningActivityToJson(ListeningActivity instance) =>
    <String, dynamic>{
      'from_ts': const DateTimeMillisecondsConverter().toJson(instance.from),
      'to_ts': const DateTimeMillisecondsConverter().toJson(instance.to),
      'listen_count': instance.listenCount,
      'time_range': instance.timeRange,
    };
