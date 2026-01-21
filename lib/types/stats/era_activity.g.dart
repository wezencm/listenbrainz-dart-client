// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'era_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EraActivityPayload _$EraActivityPayloadFromJson(Map<String, dynamic> json) =>
    EraActivityPayload(
      eraActivity: (json['era_activity'] as List<dynamic>)
          .map((e) => EraActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: (json['offset'] as num?)?.toInt(),
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

Map<String, dynamic> _$EraActivityPayloadToJson(EraActivityPayload instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  writeNotNull('range', _$AllowedStatisticsRangeEnumMap[instance.range]);
  val['last_updated'] =
      const DateTimeMillisecondsConverter().toJson(instance.lastUpdated);
  writeNotNull('user_id', instance.userId);
  val['from_ts'] = const DateTimeMillisecondsConverter().toJson(instance.from);
  val['to_ts'] = const DateTimeMillisecondsConverter().toJson(instance.to);
  val['era_activity'] = instance.eraActivity.map((e) => e.toJson()).toList();
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

EraActivity _$EraActivityFromJson(Map<String, dynamic> json) => EraActivity(
      year: (json['year'] as num).toInt(),
      listenCount: (json['listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$EraActivityToJson(EraActivity instance) =>
    <String, dynamic>{
      'year': instance.year,
      'listen_count': instance.listenCount,
    };
