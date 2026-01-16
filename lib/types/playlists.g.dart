// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistApiResponse _$PlaylistApiResponseFromJson(Map<String, dynamic> json) =>
    PlaylistApiResponse(
      count: (json['count'] as num).toInt(),
      playlistCount: (json['playlist_count'] as num).toInt(),
      playlists: (json['playlists'] as List<dynamic>)
          .map((e) => PlaylistPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistApiResponseToJson(
        PlaylistApiResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'playlist_count': instance.playlistCount,
      'playlists': instance.playlists.map((e) => e.toJson()).toList(),
    };

PlaylistPayload _$PlaylistPayloadFromJson(Map<String, dynamic> json) =>
    PlaylistPayload(
      playlist: Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistPayloadToJson(PlaylistPayload instance) =>
    <String, dynamic>{
      'playlist': instance.playlist.toJson(),
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      annotation: json['annotation'] as String?,
      creator: json['creator'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      identifier: Playlist._idFromJson(json['identifier'] as String),
      title: json['title'] as String?,
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => PlaylistTrack.fromJson(e as Map<String, dynamic>))
          .toList(),
      extension: json['extension'] == null
          ? null
          : PlaylistExtension.fromJson(
              json['extension'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('annotation', instance.annotation);
  writeNotNull('creator', instance.creator);
  writeNotNull('date', instance.date?.toIso8601String());
  val['identifier'] = Playlist._idToJson(instance.identifier);
  writeNotNull('title', instance.title);
  writeNotNull('track', instance.track?.map((e) => e.toJson()).toList());
  writeNotNull('extension', instance.extension?.toJson());
  return val;
}

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) =>
    PlaylistTrack(
      title: json['title'] as String?,
      identifier: PlaylistTrack._idFromJson(json['identifier'] as List),
      creator: json['creator'] as String?,
      album: json['album'] as String?,
      extension: json['extension'] == null
          ? null
          : TrackExtension.fromJson(json['extension'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  val['identifier'] = PlaylistTrack._idToJson(instance.identifier);
  writeNotNull('creator', instance.creator);
  writeNotNull('album', instance.album);
  writeNotNull('extension', instance.extension?.toJson());
  return val;
}

TrackExtension _$TrackExtensionFromJson(Map<String, dynamic> json) =>
    TrackExtension(
      musicBrainzTrackExtension:
          json['https://musicbrainz.org/doc/jspf#track'] == null
              ? null
              : MusicBrainzTrackExtension.fromJson(
                  json['https://musicbrainz.org/doc/jspf#track']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackExtensionToJson(TrackExtension instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('https://musicbrainz.org/doc/jspf#track',
      instance.musicBrainzTrackExtension?.toJson());
  return val;
}

MusicBrainzTrackExtension _$MusicBrainzTrackExtensionFromJson(
        Map<String, dynamic> json) =>
    MusicBrainzTrackExtension(
      addedBy: json['added_by'] as String?,
      addedAt: json['added_at'] == null
          ? null
          : DateTime.parse(json['added_at'] as String),
      releaseIdentifier: MusicBrainzTrackExtension._releaseIdentifierIdFromJson(
          json['release_identifier'] as String?),
      artistIdentifiers: MusicBrainzTrackExtension._artistIdentifierIdFromJson(
          json['artist_identifiers'] as List),
      additionalMetadata: json['additional_metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MusicBrainzTrackExtensionToJson(
    MusicBrainzTrackExtension instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('added_by', instance.addedBy);
  writeNotNull('added_at', instance.addedAt?.toIso8601String());
  writeNotNull('additional_metadata', instance.additionalMetadata);
  val['release_identifier'] =
      MusicBrainzTrackExtension._releaseIdentifierIdToJson(
          instance.releaseIdentifier);
  val['artist_identifiers'] =
      MusicBrainzTrackExtension._artistIdentifierIdToJson(
          instance.artistIdentifiers);
  return val;
}

PlaylistExtension _$PlaylistExtensionFromJson(Map<String, dynamic> json) =>
    PlaylistExtension(
      musicBrainzPlaylistExtension:
          json['https://musicbrainz.org/doc/jspf#playlist'] == null
              ? null
              : MusicBrainzPlaylistExtension.fromJson(
                  json['https://musicbrainz.org/doc/jspf#playlist']
                      as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistExtensionToJson(PlaylistExtension instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('https://musicbrainz.org/doc/jspf#playlist',
      instance.musicBrainzPlaylistExtension?.toJson());
  return val;
}

MusicBrainzPlaylistExtension _$MusicBrainzPlaylistExtensionFromJson(
        Map<String, dynamic> json) =>
    MusicBrainzPlaylistExtension(
      collaborators: (json['collaborators'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      additionalMetadata: json['additional_metadata'] as Map<String, dynamic>?,
      createdFor: json['created_for'] as String?,
      copiedFrom: json['copied_from'] as String?,
      copiedFromDeleted: json['copied_from_deleted'] as bool?,
      creator: json['creator'] as String?,
      lastModifiedAt: json['last_modified_at'] == null
          ? null
          : DateTime.parse(json['last_modified_at'] as String),
      public: json['public'] as bool?,
    );

Map<String, dynamic> _$MusicBrainzPlaylistExtensionToJson(
    MusicBrainzPlaylistExtension instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('collaborators', instance.collaborators);
  writeNotNull('additional_metadata', instance.additionalMetadata);
  writeNotNull('created_for', instance.createdFor);
  writeNotNull('creator', instance.creator);
  writeNotNull('last_modified_at', instance.lastModifiedAt?.toIso8601String());
  writeNotNull('public', instance.public);
  writeNotNull('copied_from', instance.copiedFrom);
  writeNotNull('copied_from_deleted', instance.copiedFromDeleted);
  return val;
}
