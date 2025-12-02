// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioArtistResponse _$RadioArtistResponseFromJson(Map<String, dynamic> json) =>
    RadioArtistResponse(
      recordingMbid: json['recording_mbid'] as String,
      similarArtistMbid: json['similar_artist_mbid'] as String,
      similarArtistName: json['similar_artist_name'] as String,
      totalListenCount: (json['total_listen_count'] as num).toInt(),
    );

Map<String, dynamic> _$RadioArtistResponseToJson(
        RadioArtistResponse instance) =>
    <String, dynamic>{
      'recording_mbid': instance.recordingMbid,
      'similar_artist_mbid': instance.similarArtistMbid,
      'similar_artist_name': instance.similarArtistName,
      'total_listen_count': instance.totalListenCount,
    };

RadioTagResponse _$RadioTagResponseFromJson(Map<String, dynamic> json) =>
    RadioTagResponse(
      percent: (json['percent'] as num).toInt(),
      recordingMbid: json['recording_mbid'] as String,
      source: json['source'] as String,
      tagCount: (json['tag_count'] as num).toInt(),
    );

Map<String, dynamic> _$RadioTagResponseToJson(RadioTagResponse instance) =>
    <String, dynamic>{
      'percent': instance.percent,
      'recording_mbid': instance.recordingMbid,
      'source': instance.source,
      'tag_count': instance.tagCount,
    };

ImportedPlaylist _$ImportedPlaylistFromJson(Map<String, dynamic> json) =>
    ImportedPlaylist(
      collaborative: json['collaborative'] as bool,
      description: json['description'] as String,
      externalUrls: Map<String, String>.from(json['external_urls'] as Map),
      href: json['href'] as String,
      id: json['id'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  height: $jsonValue['height'] as String?,
                  url: $jsonValue['url'] as String?,
                  width: $jsonValue['width'] as String?,
                ),
              ))
          .toList(),
      name: json['name'] as String,
      owner: _$recordConvert(
        json['owner'],
        ($jsonValue) => (
          displayName: $jsonValue['displayName'] as String,
          externalUrls:
              Map<String, String>.from($jsonValue['externalUrls'] as Map),
          href: $jsonValue['href'] as String,
          id: $jsonValue['id'] as String,
          type: $jsonValue['type'] as String,
          uri: $jsonValue['uri'] as String,
        ),
      ),
      primaryColor: json['primary_color'] as String?,
      public: json['public'] as bool,
      snapshotId: json['snapshot_id'] as String,
      tracks: _$recordConvert(
        json['tracks'],
        ($jsonValue) => (
          href: $jsonValue['href'] as String,
          total: ($jsonValue['total'] as num).toInt(),
        ),
      ),
      type: json['type'] as String,
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$ImportedPlaylistToJson(ImportedPlaylist instance) {
  final val = <String, dynamic>{
    'collaborative': instance.collaborative,
    'description': instance.description,
    'external_urls': instance.externalUrls,
    'href': instance.href,
    'id': instance.id,
    'images': instance.images
        .map((e) => <String, dynamic>{
              'height': e.height,
              'url': e.url,
              'width': e.width,
            })
        .toList(),
    'name': instance.name,
    'owner': <String, dynamic>{
      'displayName': instance.owner.displayName,
      'externalUrls': instance.owner.externalUrls,
      'href': instance.owner.href,
      'id': instance.owner.id,
      'type': instance.owner.type,
      'uri': instance.owner.uri,
    },
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('primary_color', instance.primaryColor);
  val['public'] = instance.public;
  val['snapshot_id'] = instance.snapshotId;
  val['tracks'] = <String, dynamic>{
    'href': instance.tracks.href,
    'total': instance.tracks.total,
  };
  val['type'] = instance.type;
  val['uri'] = instance.uri;
  return val;
}

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
