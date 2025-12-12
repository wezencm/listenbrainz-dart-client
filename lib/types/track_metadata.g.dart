// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackMetadata _$TrackMetadataFromJson(Map<String, dynamic> json) =>
    TrackMetadata(
      additionalInfo: json['additional_info'] == null
          ? null
          : AdditionalInfo.fromJson(
              json['additional_info'] as Map<String, dynamic>),
      artistName: json['artist_name'] as String,
      trackName: json['track_name'] as String,
      releaseName: json['release_name'] as String?,
      brainzPlayerMetadata: json['brainz_player_metadata'] == null
          ? null
          : BrainzPlayerMetadata.fromJson(
              json['brainz_player_metadata'] as Map<String, dynamic>),
      mbidMapping: json['mbid_mapping'] == null
          ? null
          : MbidMapping.fromJson(json['mbid_mapping'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackMetadataToJson(TrackMetadata instance) {
  final val = <String, dynamic>{
    'artist_name': instance.artistName,
    'track_name': instance.trackName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('release_name', instance.releaseName);
  writeNotNull('additional_info', instance.additionalInfo);
  writeNotNull('brainz_player_metadata', instance.brainzPlayerMetadata);
  writeNotNull('mbid_mapping', instance.mbidMapping);
  return val;
}

MbidMapping _$MbidMappingFromJson(Map<String, dynamic> json) => MbidMapping(
      artistMbids: (json['artist_mbids'] as List<dynamic>?)
          ?.map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  artistCreditName: $jsonValue['artistCreditName'] as String,
                  artistMbid: const UuidConverter()
                      .fromJson($jsonValue['artistMbid'] as String),
                  joinPhrase: $jsonValue['joinPhrase'] as String,
                ),
              ))
          .toList(),
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
      recordingMbid: _$JsonConverterFromJson<String, UuidString>(
          json['recording_mbid'], const UuidConverter().fromJson),
      releaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_mbid'], const UuidConverter().fromJson),
      recordingName: json['recording_name'] as String?,
    );

Map<String, dynamic> _$MbidMappingToJson(MbidMapping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('artist_mbids',
      instance.artistMbids?.map(const UuidConverter().toJson).toList());
  writeNotNull(
      'artists',
      instance.artists
          ?.map((e) => <String, dynamic>{
                'artistCreditName': e.artistCreditName,
                'artistMbid': const UuidConverter().toJson(e.artistMbid),
                'joinPhrase': e.joinPhrase,
              })
          .toList());
  writeNotNull('caa_id', instance.caaId);
  writeNotNull(
      'caa_release_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.caaReleaseMbid, const UuidConverter().toJson));
  writeNotNull(
      'recording_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.recordingMbid, const UuidConverter().toJson));
  writeNotNull(
      'release_mbid',
      _$JsonConverterToJson<String, UuidString>(
          instance.releaseMbid, const UuidConverter().toJson));
  writeNotNull('recording_name', instance.recordingName);
  return val;
}

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

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

BrainzPlayerMetadata _$BrainzPlayerMetadataFromJson(
        Map<String, dynamic> json) =>
    BrainzPlayerMetadata(
      artistName: json['artist_name'] as String,
      trackName: json['track_name'] as String,
    );

Map<String, dynamic> _$BrainzPlayerMetadataToJson(
        BrainzPlayerMetadata instance) =>
    <String, dynamic>{
      'artist_name': instance.artistName,
      'track_name': instance.trackName,
    };
