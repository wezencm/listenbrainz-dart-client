import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/types.dart';

part 'playlists.g.dart';

@JsonSerializable()
class PlaylistApiResponse {
    int count;
    int playlistCount;
    List<PlaylistPayload> playlists;

    PlaylistApiResponse({
      required this.count,
      required this.playlistCount,
      required this.playlists,
    });

  factory PlaylistApiResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaylistApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistApiResponseToJson(this);
}

/// All fields are optional because there is no documentation on Listenbrainz
/// and endpoints returns different values.
@JsonSerializable()
class PlaylistPayload {
  final Playlist playlist;
  
  PlaylistPayload({required this.playlist});
  
  factory PlaylistPayload.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistPayloadToJson(this);
}

@JsonSerializable()
class Playlist {
  final String? annotation;
  final String? creator;
  final DateTime? date;
  
  @JsonKey(
    fromJson: _idFromJson,
    toJson: _idToJson,
  )
  final UuidString? identifier;

  final String? title;
  final List<PlaylistTrack>? track;
  final PlaylistExtension? extension;

  Playlist({
    this.annotation, 
    this.creator, 
    this.date, 
    this.identifier, 
    this.title, 
    this.track, 
    this.extension,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  static UuidString _idFromJson(String uuid) {
    return UuidString(uuid.replaceFirst('https://listenbrainz.org/playlist/', ''));
  }

  static String _idToJson(UuidString? uuid) {
    return 'https://listenbrainz.org/playlist/${uuid.toString()}';
  }
}

@JsonSerializable()
class PlaylistTrack {
  final String? title;

  @JsonKey(
    fromJson: _idFromJson,
    toJson: _idToJson,
  )
  final List<UuidString>? identifier;
  
  @JsonKey(
    fromJson: _durationFromJson,
    toJson: _durationToJson,
  )
  final Duration? duration;

  final String? creator;
  final String? album;
  final TrackExtension? extension;

  PlaylistTrack({
    this.title, 
    this.identifier, 
    this.duration,
    this.creator, 
    this.album, 
    this.extension
  });

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistTrackToJson(this);

  static List<UuidString> _idFromJson(List<dynamic> uuids) {
    return uuids
        .map((uuid) => UuidString(uuid.toString().replaceFirst('https://musicbrainz.org/recording/', '')))
        .toList();
    //return UuidString(uuid.replaceFirst('https://musicbrainz.org/artist/', ''));
  }

  static List<String> _idToJson(List<UuidString>? uuids) {
    return uuids!
        .map((uuid) => 'https://musicbrainz.org/recording/${uuid.toString()}')
        .toList();
    //return 'https://musicbrainz.org/artist/${uuid.toString()}';
  }

  static Duration? _durationFromJson(int? milliseconds) =>
      milliseconds == null ? null : Duration(milliseconds: milliseconds);

  static int? _durationToJson(Duration? duration) =>
      duration?.inMilliseconds;
/*   static UuidString _idFromJson(String uuid) {
    return UuidString(uuid.replaceFirst('https://musicbrainz.org/recording/', ''));
  }

  static String _idToJson(UuidString uuid) {
    return 'https://musicbrainz.org/recording/${uuid.toString()}';
  } */
}

@JsonSerializable()
class TrackExtension {
  @JsonKey(name: 'https://musicbrainz.org/doc/jspf#track')
  final MusicBrainzTrackExtension? musicBrainzTrackExtension;

  TrackExtension({
    this.musicBrainzTrackExtension,
  });

  factory TrackExtension.fromJson(Map<String, dynamic> json) =>
      _$TrackExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$TrackExtensionToJson(this);
}

@JsonSerializable()
class MusicBrainzTrackExtension {
  final String? addedBy;
  final DateTime? addedAt;
  final Map<String, dynamic>? additionalMetadata;
  
  @JsonKey(
    fromJson: _releaseIdentifierIdFromJson,
    toJson: _releaseIdentifierIdToJson,
  )
  final UuidString? releaseIdentifier;

  @JsonKey(
    fromJson: _artistIdentifierIdFromJson,
    toJson: _artistIdentifierIdToJson,
  )
  final List<UuidString>? artistIdentifiers;

  MusicBrainzTrackExtension({
    this.addedBy, 
    this.addedAt, 
    this.releaseIdentifier, 
    this.artistIdentifiers, 
    this.additionalMetadata
  });

  factory MusicBrainzTrackExtension.fromJson(Map<String, dynamic> json) =>
      _$MusicBrainzTrackExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$MusicBrainzTrackExtensionToJson(this);

  static UuidString? _releaseIdentifierIdFromJson(String? uuid) {
    if (uuid == null) return null;
    return UuidString(uuid.replaceFirst('https://musicbrainz.org/release/', ''));
  }

  static String? _releaseIdentifierIdToJson(UuidString? uuid) {
    if (uuid == null) return null;
    return 'https://musicbrainz.org/release/${uuid.toString()}';
  }

  static List<UuidString> _artistIdentifierIdFromJson(List<dynamic> uuids) {
    return uuids
        .map((uuid) => UuidString(uuid.toString().replaceFirst('https://musicbrainz.org/artist/', '')))
        .toList();
    //return UuidString(uuid.replaceFirst('https://musicbrainz.org/artist/', ''));
  }

  static List<String> _artistIdentifierIdToJson(List<UuidString>? uuids) {
    return uuids!
        .map((uuid) => 'https://musicbrainz.org/artist/${uuid.toString()}')
        .toList();
    //return 'https://musicbrainz.org/artist/${uuid.toString()}';
  }
}

@JsonSerializable()
class PlaylistExtension {
  @JsonKey(name: 'https://musicbrainz.org/doc/jspf#playlist')
  final MusicBrainzPlaylistExtension? musicBrainzPlaylistExtension;

  PlaylistExtension({
    this.musicBrainzPlaylistExtension,
  });

  factory PlaylistExtension.fromJson(Map<String, dynamic> json) =>
      _$PlaylistExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistExtensionToJson(this);
}

@JsonSerializable()
class MusicBrainzPlaylistExtension {
  final List<String>? collaborators;
  
  // bad docs at Listenbrainz
  final Map<String, dynamic>? additionalMetadata;
  
  final String? createdFor;
  final String? creator;
  final DateTime? lastModifiedAt;
  final bool? public;
  final String? copiedFrom;
  final bool? copiedFromDeleted;
  

  MusicBrainzPlaylistExtension({
    this.collaborators, 
    this.additionalMetadata, 
    this.createdFor, 
    this.copiedFrom,
    this.copiedFromDeleted,
    this.creator, 
    this.lastModifiedAt, 
    this.public,  
  });

  factory MusicBrainzPlaylistExtension.fromJson(Map<String, dynamic> json) =>
      _$MusicBrainzPlaylistExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$MusicBrainzPlaylistExtensionToJson(this);
}

/* class AdditionalMetadata {

} */