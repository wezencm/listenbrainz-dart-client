// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordingFeedback _$RecordingFeedbackFromJson(Map<String, dynamic> json) =>
    RecordingFeedback(
      score: $enumDecode(_$FeedbackScoreEnumMap, json['score']),
      recordingMbid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_mbid'], const UuidConverter().fromJson),
      recordingMsid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_msid'], const UuidConverter().fromJson),
      userId: json['user_id'] as String?,
      created: _$JsonConverterFromJson<int, DateTime>(
          json['created'], const DateTimeMillisecondsConverter().fromJson),
      trackMetadata: json['track_metadata'] == null
          ? null
          : TrackMetadata.fromJson(
              json['track_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecordingFeedbackToJson(RecordingFeedback instance) {
  final val = <String, dynamic>{
    'score': _$FeedbackScoreEnumMap[instance.score]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'recording_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMbid, const UuidConverter().toJson));
  writeNotNull(
      'recording_msid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMsid, const UuidConverter().toJson));
  writeNotNull('user_id', instance.userId);
  writeNotNull(
      'created',
      _$JsonConverterToJson<int, DateTime>(
          instance.created, const DateTimeMillisecondsConverter().toJson));
  writeNotNull('track_metadata', instance.trackMetadata);
  return val;
}

const _$FeedbackScoreEnumMap = {
  FeedbackScore.love: 1,
  FeedbackScore.hate: -1,
  FeedbackScore.neutral: 0,
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
