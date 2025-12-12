import 'package:json_annotation/json_annotation.dart';

enum FeedbackScore {
  @JsonValue(1)
  love(1),

  @JsonValue(-1)
  hate(-1),
  
  @JsonValue(0)
  neutral(0);

  final int value;

  const FeedbackScore(this.value);
}