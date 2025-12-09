import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/additional_info.dart';
import 'package:listenbrainz/types/track_metadata.dart';
import 'package:listenbrainz/types/types.dart';

part 'response_listen.g.dart';

@UuidConverter()
@JsonSerializable()
class ResponseListen {
  final bool? playingNow;
  final int? insertedAt;
  final int? listenedAt;
  final UuidString? recordingMsid;
  final String? userId;
  final ResponseTrackMetadata trackMetadata;

  ResponseListen({
    this.playingNow,
    this.insertedAt,
    this.listenedAt,
    this.recordingMsid,
    this.userId,
    required this.trackMetadata,
  });

  factory ResponseListen.fromJson(Map<String, dynamic> json) =>
      _$ResponseListenFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseListenToJson(this);
}

@JsonSerializable()
class ResponseTrackMetadata {
  final String artistName;
  final String releaseName;
  final String trackName;
  final AdditionalInfo additionalInfo;
  final BrainzPlayerMetadata? brainzPlayerMetadata;
  final MbidMapping? mbidMapping;

  ResponseTrackMetadata(this.artistName, this.releaseName, this.trackName,
      this.additionalInfo, this.brainzPlayerMetadata, this.mbidMapping);

  factory ResponseTrackMetadata.fromJson(Map<String, dynamic> json) =>
      _$ResponseTrackMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTrackMetadataToJson(this);
}
