// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_evolution_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistEvolutionActivityPayload _$ArtistEvolutionActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    ArtistEvolutionActivityPayload(
      artistEvolutionActivity:
          (json['artist_evolution_activity'] as List<dynamic>)
              .map((e) =>
                  ArtistEvolutionActivity.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$ArtistEvolutionActivityPayloadToJson(
    ArtistEvolutionActivityPayload instance) {
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
  val['artist_evolution_activity'] =
      instance.artistEvolutionActivity.map((e) => e.toJson()).toList();
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

ArtistEvolutionActivity _$ArtistEvolutionActivityFromJson(
        Map<String, dynamic> json) =>
    ArtistEvolutionActivity(
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      artistName: json['artist_name'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
      timeUnit: json['time_unit'] as String,
    );

Map<String, dynamic> _$ArtistEvolutionActivityToJson(
    ArtistEvolutionActivity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'artist_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.artistMbid, const UuidConverter().toJson));
  val['artist_name'] = instance.artistName;
  val['listen_count'] = instance.listenCount;
  val['time_unit'] = instance.timeUnit;
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
