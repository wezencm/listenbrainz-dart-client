import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/additional_info.dart';

part 'submission_listen.g.dart';

@JsonSerializable()
class SubmissionListen {
  /// listenedAt property must be an epoch timestamp from when the track started playing
  late int? listenedAt;
  final TrackMetadata trackMetadata;

  SubmissionListen({
    this.listenedAt,
    required this.trackMetadata,
  });

  factory SubmissionListen.fromJson(Map<String, dynamic> json) => 
    _$SubmissionListenFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionListenToJson(this);
}

@JsonSerializable()
class TrackMetadata {
  final AdditionalInfo? additionalInfo;
  final String artistName;
  final String trackName;
  final String? releaseName;

  TrackMetadata({
    this.additionalInfo,
    required this.artistName,
    required this.trackName,
    this.releaseName,
  });

  factory TrackMetadata.fromJson(Map<String, dynamic> json) => 
    _$TrackMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$TrackMetadataToJson(this);

}
