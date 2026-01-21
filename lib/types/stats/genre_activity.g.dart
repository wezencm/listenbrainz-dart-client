// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreActivityPayload _$GenreActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    GenreActivityPayload(
      genreActivity: (json['genre_activity'] as List<dynamic>)
          .map((e) => GenreActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$GenreActivityPayloadToJson(
    GenreActivityPayload instance) {
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
  val['genre_activity'] =
      instance.genreActivity.map((e) => e.toJson()).toList();
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

GenreActivity _$GenreActivityFromJson(Map<String, dynamic> json) =>
    GenreActivity(
      genre: json['genre'] as String,
      hour: (json['hour'] as num).toInt(),
      listenCount: (json['listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$GenreActivityToJson(GenreActivity instance) =>
    <String, dynamic>{
      'genre': instance.genre,
      'hour': instance.hour,
      'listen_count': instance.listenCount,
    };
