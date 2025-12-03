// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) =>
    AdditionalInfo(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      releaseGroupMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_group_mbid'], const UuidConverter().fromJson),
      releaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_mbid'], const UuidConverter().fromJson),
      recordingMbid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_mbid'], const UuidConverter().fromJson),
      trackMbid: _$JsonConverterFromJson<String, UuidString>(
          json['track_mbid'], const UuidConverter().fromJson),
      workMbids: (json['work_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      tracknumber: json['tracknumber'] as String?,
      isrc: json['isrc'] as String?,
      spotifyId: json['spotify_id'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mediaPlayer: json['media_player'] as String?,
      mediaPlayerVersion: json['media_player_version'] as String?,
      submissionClient: json['submission_client'] as String?,
      submissionClientVersion: json['submission_client_version'] as String?,
      musicService: json['music_service'] as String?,
      musicServiceName: json['music_service_name'] as String?,
      originUrl: json['origin_url'] as String?,
      durationMs: (json['duration_ms'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
    )..recordingMsid = _$JsonConverterFromJson<String, UuidString>(
        json['recording_msid'], const UuidConverter().fromJson);

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('artist_mbids',
      instance.artistMbids?.map(const UuidConverter().toJson).toList());
  writeNotNull(
      'release_group_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.releaseGroupMbid, const UuidConverter().toJson));
  writeNotNull(
      'release_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.releaseMbid, const UuidConverter().toJson));
  writeNotNull(
      'recording_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMbid, const UuidConverter().toJson));
  writeNotNull(
      'track_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.trackMbid, const UuidConverter().toJson));
  writeNotNull('work_mbids',
      instance.workMbids?.map(const UuidConverter().toJson).toList());
  writeNotNull('tracknumber', instance.tracknumber);
  writeNotNull('isrc', instance.isrc);
  writeNotNull('spotify_id', instance.spotifyId);
  writeNotNull('tags', instance.tags);
  writeNotNull('media_player', instance.mediaPlayer);
  writeNotNull('media_player_version', instance.mediaPlayerVersion);
  writeNotNull('submission_client', instance.submissionClient);
  writeNotNull('submission_client_version', instance.submissionClientVersion);
  writeNotNull('music_service', instance.musicService);
  writeNotNull('music_service_name', instance.musicServiceName);
  writeNotNull('origin_url', instance.originUrl);
  writeNotNull('duration_ms', instance.durationMs);
  writeNotNull('duration', instance.duration);
  writeNotNull(
      'recording_msid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMsid, const UuidConverter().toJson));
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
