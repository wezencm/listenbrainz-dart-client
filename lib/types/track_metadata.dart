import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/additional_info.dart';
import 'package:listenbrainz/types/types.dart';

part 'track_metadata.g.dart';

@JsonSerializable()
class TrackMetadata {
  final String artistName;
  final String trackName;
  final String? releaseName;
  final AdditionalInfo? additionalInfo;
  final BrainzPlayerMetadata? brainzPlayerMetadata;
  final MbidMapping? mbidMapping;

  TrackMetadata({
    this.additionalInfo,
    required this.artistName,
    required this.trackName,
    this.releaseName,
    this.brainzPlayerMetadata,
    this.mbidMapping,
  });

  factory TrackMetadata.fromJson(Map<String, dynamic> json) =>
      _$TrackMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$TrackMetadataToJson(this);
}

@UuidConverter()
@JsonSerializable()
class MbidMapping {
  final List<UuidString>? artistMbids;
  final List<
      ({
        String artistCreditName,
        UuidString artistMbid,
        String joinPhrase,
      })>? artists;
  final int? caaId;
  final UuidString? caaReleaseMbid;
  final UuidString? recordingMbid;
  final UuidString? releaseMbid;
  final String? recordingName;

  MbidMapping({
    this.artistMbids,
    this.artists,
    this.caaId,
    this.caaReleaseMbid,
    this.recordingMbid,
    this.releaseMbid,
    this.recordingName,
  });

  factory MbidMapping.fromJson(Map<String, dynamic> json) =>
      _$MbidMappingFromJson(json);

  Map<String, dynamic> toJson() => _$MbidMappingToJson(this);
}

@JsonSerializable()
class BrainzPlayerMetadata {
  final String artistName;
  final String trackName;

  BrainzPlayerMetadata({
    required this.artistName,
    required this.trackName,
  });

  factory BrainzPlayerMetadata.fromJson(Map<String, dynamic> json) =>
      _$BrainzPlayerMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$BrainzPlayerMetadataToJson(this);
}
