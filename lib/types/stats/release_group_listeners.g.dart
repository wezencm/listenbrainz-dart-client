// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_group_listeners.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseGroupListeners _$ReleaseGroupListenersFromJson(
        Map<String, dynamic> json) =>
    ReleaseGroupListeners(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
      releaseGroupMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_group_mbid'], const UuidConverter().fromJson),
      releaseGroupName: json['release_group_name'] as String,
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

Map<String, dynamic> _$ReleaseGroupListenersToJson(
        ReleaseGroupListeners instance) =>
    <String, dynamic>{
      'artist_name': instance.artistName,
      'from_ts': const DateTimeMillisecondsConverter().toJson(instance.from),
      'to_ts': const DateTimeMillisecondsConverter().toJson(instance.to),
      'last_updated':
          const DateTimeMillisecondsConverter().toJson(instance.lastUpdated),
      'stats_range': _$AllowedStatisticsRangeEnumMap[instance.statsRange]!,
      'listeners': instance.listeners.map((e) => e.toJson()).toList(),
      'total_listen_count': instance.totalListenCount,
      'total_user_count': instance.totalUserCount,
      'artist_mbids':
          instance.artistMbids?.map(const UuidConverter().toJson).toList(),
      'caa_id': instance.caaId,
      'caa_release_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.caaReleaseMbid, const UuidConverter().toJson),
      'release_group_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.releaseGroupMbid, const UuidConverter().toJson),
      'release_group_name': instance.releaseGroupName,
    };

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
