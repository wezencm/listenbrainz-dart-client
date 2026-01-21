// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_feedbacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchedFeedbacks _$FetchedFeedbacksFromJson(Map<String, dynamic> json) =>
    FetchedFeedbacks(
      count: (json['count'] as num).toInt(),
      totalCount: (json['total_count'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      feedback: (json['feedback'] as List<dynamic>)
          .map((e) => RecordingFeedback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FetchedFeedbacksToJson(FetchedFeedbacks instance) =>
    <String, dynamic>{
      'count': instance.count,
      'offset': instance.offset,
      'total_count': instance.totalCount,
      'feedback': instance.feedback.map((e) => e.toJson()).toList(),
    };
