// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_release_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopReleaseGroups _$TopReleaseGroupsFromJson(Map<String, dynamic> json) =>
    TopReleaseGroups(
      releaseGroups: (json['release_groups'] as List<dynamic>)
          .map((e) => TopReleaseGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReleaseGroupCount:
          (json['total_release_group_count'] as num).toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt() ??
          ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
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

Map<String, dynamic> _$TopReleaseGroupsToJson(TopReleaseGroups instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  writeNotNull('count', instance.count);
  writeNotNull('range', _$AllowedStatisticsRangeEnumMap[instance.range]);
  val['last_updated'] =
      const DateTimeMillisecondsConverter().toJson(instance.lastUpdated);
  writeNotNull('user_id', instance.userId);
  val['from_ts'] = const DateTimeMillisecondsConverter().toJson(instance.from);
  val['to_ts'] = const DateTimeMillisecondsConverter().toJson(instance.to);
  val['release_groups'] =
      instance.releaseGroups.map((e) => e.toJson()).toList();
  val['total_release_group_count'] = instance.totalReleaseGroupCount;
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

TopReleaseGroup _$TopReleaseGroupFromJson(Map<String, dynamic> json) =>
    TopReleaseGroup(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      artistName: json['artist_name'] as String,
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
      listenCount: (json['listen_count'] as num).toInt(),
      releaseGroupMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_group_mbid'], const UuidConverter().fromJson),
      releaseGroupName: json['release_group_name'] as String,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => TopReleaseArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopReleaseGroupToJson(TopReleaseGroup instance) {
  final val = <String, dynamic>{
    'artist_mbids':
        instance.artistMbids?.map(const UuidConverter().toJson).toList(),
    'artist_name': instance.artistName,
    'caa_id': instance.caaId,
    'caa_release_mbid': _$JsonConverterToJson<String, UuidString>(
        instance.caaReleaseMbid, const UuidConverter().toJson),
    'listen_count': instance.listenCount,
    'release_group_mbid': _$JsonConverterToJson<String, UuidString>(
        instance.releaseGroupMbid, const UuidConverter().toJson),
    'release_group_name': instance.releaseGroupName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('artists', instance.artists?.map((e) => e.toJson()).toList());
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
