import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

enum ConnectedServices {
  musicbrainzProd('musicbrainz-prod'),
  spotify('spotify'), 
  soundcloud('soundcloud'), 
  appleMusic('apple_music');

  final String value;

  const ConnectedServices(this.value);

  static ConnectedServices fromString(String value) {
    return ConnectedServices.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Invalid service: $value'),
    );
  }
}

enum RadioModes {
  easy('easy'),
  madium('medium'),
  hard('hard');

  final String value;

  const RadioModes(this.value);
}

@JsonSerializable()
class RadioArtistResponse {
  final String recordingMbid;
  final String similarArtistMbid;
  final String similarArtistName;
  final int totalListenCount;

  RadioArtistResponse({
    required this.recordingMbid, 
    required this.similarArtistMbid, 
    required this.similarArtistName, 
    required this.totalListenCount
  });

  factory RadioArtistResponse.fromJson(Map<String, dynamic> json) => 
    _$RadioArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RadioArtistResponseToJson(this);
}

enum SubmissionListenTypes {
  single('single'),
  playingNow('playing_now'),
  import('import');

  final String value;

  const SubmissionListenTypes(this.value);
}

enum LbRadioOperators {
  and('AND'),
  or('OR');

  final String value;

  const LbRadioOperators(this.value);
}

@JsonSerializable()
class RadioTagResponse {
  final int percent;
  final String recordingMbid;
  final String source;
  final int tagCount;

  RadioTagResponse({
    required this.percent,
    required this.recordingMbid,
    required this.source,
    required this.tagCount
  });

  factory RadioTagResponse.fromJson(Map<String, dynamic> json) => 
    _$RadioTagResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RadioTagResponseToJson(this);

}

class TokenValidationResponse {
  final int code;
  final String message;
  final String? userName;
  final bool valid;

  TokenValidationResponse({
    required this.code,
    required this.message,
    this.userName,
    required this.valid,
  });

  factory TokenValidationResponse.fromJson(Map<String, dynamic> json) {
    return TokenValidationResponse(
      code: json['code'],
      message: json['message'],
      userName: json['user_name'],
      valid: json['valid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      if (userName != null) 'user_name': userName,
      'valid': valid,
    };
  }
}

class UuidString {
  final String value;

  static final _uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}-'
    r'[0-9a-fA-F]{4}-'
    r'[0-9a-fA-F]{4}-'
    r'[0-9a-fA-F]{4}-'
    r'[0-9a-fA-F]{12}$',
  );

  UuidString._(this.value);

  factory UuidString(String input) {
    if (!_uuidRegex.hasMatch(input)) {
      throw FormatException('Invalid UUID string: $input');
    }
    return UuidString._(input);
  }

  @override
  String toString() => value;
}

class UuidConverter extends JsonConverter<UuidString, String> {
  const UuidConverter();

  @override
  UuidString fromJson(String json) => UuidString(json);

  @override
  String toJson(UuidString object) => object.value;
}

@JsonSerializable()
class ImportedPlaylist {
  final bool collaborative;
  final String description;
  final Map<String, String> externalUrls;
  final String href;
  final String id;
  final List<({
    String? height,
    String? url,
    String? width,
  })> images;
  final String name;
  final ({
    String displayName,
    Map<String, String> externalUrls,
    String href,
    String id,
    String type,
    String uri,
  }) owner;
  final String? primaryColor;
  final bool public;
  final String snapshotId;
  final ({
    String href,
    int total,
  }) tracks;
  final String type;
  final String uri;

  ImportedPlaylist({
    required this.collaborative, 
    required this.description, 
    required this.externalUrls, 
    required this.href, 
    required this.id, 
    required this.images, 
    required this.name, 
    required this.owner, 
    this.primaryColor, 
    required this.public, 
    required this.snapshotId, 
    required this.tracks, 
    required this.type, 
    required this.uri
  });

  
  factory ImportedPlaylist.fromJson(Map<String, dynamic> json) => 
    _$ImportedPlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$ImportedPlaylistToJson(this);
}
