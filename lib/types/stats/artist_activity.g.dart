// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistActivityPayload _$ArtistActivityPayloadFromJson(
        Map<String, dynamic> json) =>
    ArtistActivityPayload(
      artistActivity: (json['artist_activity'] as List<dynamic>)
          .map((e) => ArtistActivity.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$ArtistActivityPayloadToJson(
    ArtistActivityPayload instance) {
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
  val['artist_activity'] =
      instance.artistActivity.map((e) => e.toJson()).toList();
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

ArtistActivity _$ArtistActivityFromJson(Map<String, dynamic> json) =>
    ArtistActivity(
      name: json['name'] as String,
      artistName: json['artist_name'] as String?,
      artistMbid: _$JsonConverterFromJson<String, UuidString>(
          json['artist_mbid'], const UuidConverter().fromJson),
      listenCount: (json['listen_count'] as num).toInt(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => ArtistActivityAlbum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArtistActivityToJson(ArtistActivity instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('artist_name', instance.artistName);
  val['artist_mbid'] = _$JsonConverterToJson<String, UuidString>(
      instance.artistMbid, const UuidConverter().toJson);
  val['listen_count'] = instance.listenCount;
  val['albums'] = instance.albums?.map((e) => e.toJson()).toList();
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

ArtistActivityAlbum _$ArtistActivityAlbumFromJson(Map<String, dynamic> json) =>
    ArtistActivityAlbum(
      name: json['name'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
      releaseGroupMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_group_mbid'], const UuidConverter().fromJson),
    );

Map<String, dynamic> _$ArtistActivityAlbumToJson(
        ArtistActivityAlbum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'listen_count': instance.listenCount,
      'release_group_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.releaseGroupMbid, const UuidConverter().toJson),
    };
