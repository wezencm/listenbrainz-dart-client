// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_listeners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistListeners _$ArtistListenersFromJson(Map<String, dynamic> json) =>
    ArtistListeners(
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      artistName: json['artist_name'] as String,
      from: const DateTimeMillisecondsConverter()
          .fromJson((json['from_ts'] as num).toInt()),
      to: const DateTimeMillisecondsConverter()
          .fromJson((json['to_ts'] as num).toInt()),
      lastUpdated: const DateTimeMillisecondsConverter()
          .fromJson((json['last_updated'] as num).toInt()),
      statsRange:
          $enumDecode(_$AllowedStatisticsRangeEnumMap, json['stats_range']),
      listeners: (json['listeners'] as List<dynamic>)
          .map((e) => StatsListeners.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalListenCount: (json['total_listen_count'] as num).toInt(),
      totalUserCount: (json['total_user_count'] as num).toInt(),
    );

Map<String, dynamic> _$ArtistListenersToJson(ArtistListeners instance) {
  final val = <String, dynamic>{
    'artist_name': instance.artistName,
    'from_ts': const DateTimeMillisecondsConverter().toJson(instance.from),
    'to_ts': const DateTimeMillisecondsConverter().toJson(instance.to),
    'last_updated':
        const DateTimeMillisecondsConverter().toJson(instance.lastUpdated),
    'stats_range': _$AllowedStatisticsRangeEnumMap[instance.statsRange]!,
    'listeners': instance.listeners.map((e) => e.toJson()).toList(),
    'total_listen_count': instance.totalListenCount,
    'total_user_count': instance.totalUserCount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'artist_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.artistMbid, const UuidConverter().toJson));
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
