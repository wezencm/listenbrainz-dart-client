// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_recordings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopRecordings _$TopRecordingsFromJson(Map<String, dynamic> json) =>
    TopRecordings(
      recordings: (json['recordings'] as List<dynamic>)
          .map((e) => TopRecording.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordingCount: (json['total_recording_count'] as num).toInt(),
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

Map<String, dynamic> _$TopRecordingsToJson(TopRecordings instance) {
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
  val['recordings'] = instance.recordings.map((e) => e.toJson()).toList();
  val['total_recording_count'] = instance.totalRecordingCount;
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

TopRecording _$TopRecordingFromJson(Map<String, dynamic> json) => TopRecording(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      artistName: json['artist_name'] as String,
      listenCount: (json['listen_count'] as num).toInt(),
      recordingMbid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_mbid'], const UuidConverter().fromJson),
      releaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_mbid'], const UuidConverter().fromJson),
      releaseName: json['release_name'] as String?,
      trackName: json['track_name'] as String,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => TopReleaseArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
    );

Map<String, dynamic> _$TopRecordingToJson(TopRecording instance) {
  final val = <String, dynamic>{
    'artist_mbids':
        instance.artistMbids?.map(const UuidConverter().toJson).toList(),
    'artist_name': instance.artistName,
    'listen_count': instance.listenCount,
    'recording_mbid': _$JsonConverterToJson<String, UuidString>(
        instance.recordingMbid, const UuidConverter().toJson),
    'release_mbid': _$JsonConverterToJson<String, UuidString>(
        instance.releaseMbid, const UuidConverter().toJson),
    'release_name': instance.releaseName,
    'track_name': instance.trackName,
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
