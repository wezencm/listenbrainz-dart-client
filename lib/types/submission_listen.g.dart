// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_listen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionListen _$SubmissionListenFromJson(Map<String, dynamic> json) =>
    SubmissionListen(
      listenedAt: (json['listened_at'] as num?)?.toInt(),
      trackMetadata: TrackMetadata.fromJson(
          json['track_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmissionListenToJson(SubmissionListen instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('listened_at', instance.listenedAt);
  val['track_metadata'] = instance.trackMetadata;
  return val;
}
