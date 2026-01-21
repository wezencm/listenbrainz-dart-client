// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopArtists _$TopArtistsFromJson(Map<String, dynamic> json) => TopArtists(
      artists: (json['artists'] as List<dynamic>)
          .map((e) => TopArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalArtistCount: (json['total_artist_count'] as num).toInt(),
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

Map<String, dynamic> _$TopArtistsToJson(TopArtists instance) {
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
  val['artists'] = instance.artists.map((e) => e.toJson()).toList();
  val['total_artist_count'] = instance.totalArtistCount;
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

TopArtist _$TopArtistFromJson(Map<String, dynamic> json) => TopArtist(
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      artistName: json['artist_name'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$TopArtistToJson(TopArtist instance) => <String, dynamic>{
      'artist_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.artistMbid, const UuidConverter().toJson),
      'artist_name': instance.artistName,
      'listen_count': instance.listenCount,
    };

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
