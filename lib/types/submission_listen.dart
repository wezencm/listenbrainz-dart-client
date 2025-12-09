import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/track_metadata.dart';

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
