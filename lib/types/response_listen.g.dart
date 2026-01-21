// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_listen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseListen _$ResponseListenFromJson(Map<String, dynamic> json) =>
    ResponseListen(
      playingNow: json['playing_now'] as bool?,
      insertedAt: (json['inserted_at'] as num?)?.toInt(),
      listenedAt: (json['listened_at'] as num?)?.toInt(),
      recordingMsid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_msid'], const UuidConverter().fromJson),
      userId: json['user_id'] as String?,
      trackMetadata: ResponseTrackMetadata.fromJson(
          json['track_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseListenToJson(ResponseListen instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('playing_now', instance.playingNow);
  writeNotNull('inserted_at', instance.insertedAt);
  writeNotNull('listened_at', instance.listenedAt);
  writeNotNull(
      'recording_msid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMsid, const UuidConverter().toJson));
  writeNotNull('user_id', instance.userId);
  val['track_metadata'] = instance.trackMetadata.toJson();
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

ResponseTrackMetadata _$ResponseTrackMetadataFromJson(
        Map<String, dynamic> json) =>
    ResponseTrackMetadata(
      json['artist_name'] as String,
      json['release_name'] as String,
      json['track_name'] as String,
      AdditionalInfo.fromJson(json['additional_info'] as Map<String, dynamic>),
      json['brainz_player_metadata'] == null
          ? null
          : BrainzPlayerMetadata.fromJson(
              json['brainz_player_metadata'] as Map<String, dynamic>),
      json['mbid_mapping'] == null
          ? null
          : MbidMapping.fromJson(json['mbid_mapping'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseTrackMetadataToJson(
    ResponseTrackMetadata instance) {
  final val = <String, dynamic>{
    'artist_name': instance.artistName,
    'release_name': instance.releaseName,
    'track_name': instance.trackName,
    'additional_info': instance.additionalInfo.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'brainz_player_metadata', instance.brainzPlayerMetadata?.toJson());
  writeNotNull('mbid_mapping', instance.mbidMapping?.toJson());
  return val;
}
