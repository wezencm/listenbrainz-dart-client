// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingPin _$RecordingPinFromJson(Map<String, dynamic> json) => RecordingPin(
      recordingMbid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_mbid'], const UuidConverter().fromJson),
      recordingMsid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_msid'], const UuidConverter().fromJson),
      blurbContent: json['blurb_content'] as String,
      pinnedUntil: const DateTimeMillisecondsConverter()
          .fromJson((json['pinned_until'] as num).toInt()),
      trackMetadata: json['track_metadata'] == null
          ? null
          : TrackMetadata.fromJson(
              json['track_metadata'] as Map<String, dynamic>),
      created: _$JsonConverterFromJson<int, DateTime>(
          json['created'], const DateTimeMillisecondsConverter().fromJson),
      rowId: (json['row_id'] as num?)?.toInt(),
      userName: json['user_name'] as String?,
    );

Map<String, dynamic> _$RecordingPinToJson(RecordingPin instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'recording_msid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMsid, const UuidConverter().toJson));
  writeNotNull(
      'recording_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMbid, const UuidConverter().toJson));
  val['blurb_content'] = instance.blurbContent;
  val['pinned_until'] =
      const DateTimeMillisecondsConverter().toJson(instance.pinnedUntil);
  writeNotNull('track_metadata', instance.trackMetadata);
  writeNotNull(
      'created',
      _$JsonConverterToJson<int, DateTime>(
          instance.created, const DateTimeMillisecondsConverter().toJson));
  writeNotNull('row_id', instance.rowId);
  writeNotNull('user_name', instance.userName);
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

FetchedPins _$FetchedPinsFromJson(Map<String, dynamic> json) => FetchedPins(
      count: (json['count'] as num).toInt(),
      totalCount: (json['total_count'] as num?)?.toInt(),
      offset: (json['offset'] as num).toInt(),
      pinnedRecordings: (json['pinned_recordings'] as List<dynamic>)
          .map((e) => RecordingPin.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['user_name'] as String,
    );

Map<String, dynamic> _$FetchedPinsToJson(FetchedPins instance) {
  final val = <String, dynamic>{
    'count': instance.count,
    'offset': instance.offset,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('total_count', instance.totalCount);
  val['pinned_recordings'] = instance.pinnedRecordings;
  val['user_name'] = instance.userName;
  return val;
}
