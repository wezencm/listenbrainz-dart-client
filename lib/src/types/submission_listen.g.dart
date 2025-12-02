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

TrackMetadata _$TrackMetadataFromJson(Map<String, dynamic> json) =>
    TrackMetadata(
      additionalInfo: json['additional_info'] == null
          ? null
          : AdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
      artistName: json['artist_name'] as String,
      trackName: json['track_name'] as String,
      releaseName: json['release_name'] as String?,
    );

Map<String, dynamic> _$TrackMetadataToJson(TrackMetadata instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('additional_info', instance.additionalInfo);
  val['artist_name'] = instance.artistName;
  val['track_name'] = instance.trackName;
  writeNotNull('release_name', instance.releaseName);
  return val;
}
