// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_releases.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopReleases _$TopReleasesFromJson(Map<String, dynamic> json) => TopReleases(
      releases: (json['releases'] as List<dynamic>)
          .map((e) => TopRelease.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReleaseCount: (json['total_release_count'] as num).toInt(),
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

Map<String, dynamic> _$TopReleasesToJson(TopReleases instance) {
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
  val['releases'] = instance.releases.map((e) => e.toJson()).toList();
  val['total_release_count'] = instance.totalReleaseCount;
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

TopRelease _$TopReleaseFromJson(Map<String, dynamic> json) => TopRelease(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      artistName: json['artist_name'] as String,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => TopReleaseArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
      listenCount: (json['listen_count'] as num).toInt(),
      releaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_mbid'], const UuidConverter().fromJson),
      releaseName: json['release_name'] as String,
    );

Map<String, dynamic> _$TopReleaseToJson(TopRelease instance) {
  final val = <String, dynamic>{
    'artist_mbids':
        instance.artistMbids?.map(const UuidConverter().toJson).toList(),
    'artist_name': instance.artistName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('artists', instance.artists?.map((e) => e.toJson()).toList());
  val['caa_id'] = instance.caaId;
  val['caa_release_mbid'] = _$JsonConverterToJson<String, UuidString>(
      instance.caaReleaseMbid, const UuidConverter().toJson);
  val['listen_count'] = instance.listenCount;
  val['release_mbid'] = _$JsonConverterToJson<String, UuidString>(
      instance.releaseMbid, const UuidConverter().toJson);
  val['release_name'] = instance.releaseName;
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

TopReleaseArtist _$TopReleaseArtistFromJson(Map<String, dynamic> json) =>
    TopReleaseArtist(
      artistCreditName: json['artist_credit_name'] as String,
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      joinPhrase: json['join_phrase'] as String,
    );

Map<String, dynamic> _$TopReleaseArtistToJson(TopReleaseArtist instance) =>
    <String, dynamic>{
      'artist_credit_name': instance.artistCreditName,
      'artist_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.artistMbid, const UuidConverter().toJson),
      'join_phrase': instance.joinPhrase,
    };
