// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistMapPayload _$ArtistMapPayloadFromJson(Map<String, dynamic> json) =>
    ArtistMapPayload(
      artistMap: (json['artist_map'] as List<dynamic>)
          .map((e) => ArtistMap.fromJson(e as Map<String, dynamic>))
          .toList(),
      statsRange: $enumDecodeNullable(
          _$AllowedStatisticsRangeEnumMap, json['stats_range']),
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

Map<String, dynamic> _$ArtistMapPayloadToJson(ArtistMapPayload instance) {
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
  val['artist_map'] = instance.artistMap.map((e) => e.toJson()).toList();
  writeNotNull(
      'stats_range', _$AllowedStatisticsRangeEnumMap[instance.statsRange]);
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

ArtistMap _$ArtistMapFromJson(Map<String, dynamic> json) => ArtistMap(
      artistCount: (json['artist_count'] as num).toInt(),
      country: json['country'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistMapArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistMapToJson(ArtistMap instance) => <String, dynamic>{
      'artist_count': instance.artistCount,
      'country': instance.country,
      'listen_count': instance.listenCount,
      'artists': instance.artists.map((e) => e.toJson()).toList(),
    };

ArtistMapArtist _$ArtistMapArtistFromJson(Map<String, dynamic> json) =>
    ArtistMapArtist(
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      artistName: json['artist_name'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$ArtistMapArtistToJson(ArtistMapArtist instance) {
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
