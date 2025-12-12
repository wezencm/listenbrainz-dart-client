import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/recording_feedback.dart';

part 'fetched_feedbacks.g.dart';

@JsonSerializable()
class FetchedFeedbacks {
  final int count;
  final int offset;
  final int totalCount;
  final List<RecordingFeedback> feedback;

  FetchedFeedbacks({
    required this.count,
    required this.totalCount,
    required this.offset,
    required this.feedback,
  }); 

    factory FetchedFeedbacks.fromJson(Map<String, dynamic> json) => 
    _$FetchedFeedbacksFromJson(json);

  Map<String, dynamic> toJson() => _$FetchedFeedbacksToJson(this);
}