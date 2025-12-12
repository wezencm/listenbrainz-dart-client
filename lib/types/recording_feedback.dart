import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/feedback_score.dart';
import 'package:listenbrainz/types/track_metadata.dart';
import 'package:listenbrainz/types/types.dart';

part 'recording_feedback.g.dart';

@UuidConverter()
@DateTimeMillisecondsConverter()
@JsonSerializable()
class RecordingFeedback {
  final FeedbackScore score;
  final UuidString? recordingMbid;
  final UuidString? recordingMsid;
  final String? userId;
  final DateTime? created;
  final TrackMetadata? trackMetadata;

  RecordingFeedback({
    required this.score,
    this.recordingMbid,
    this.recordingMsid,
    this.userId,
    this.created,
    this.trackMetadata,
  });

  factory RecordingFeedback.fromJson(Map<String, dynamic> json) =>
      _$RecordingFeedbackFromJson(json);

  Map<String, dynamic> toJson() => _$RecordingFeedbackToJson(this);
}
