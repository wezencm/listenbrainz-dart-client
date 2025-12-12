import 'package:json_annotation/json_annotation.dart';

class DateTimeMillisecondsConverter implements JsonConverter<DateTime, int> {
  const DateTimeMillisecondsConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
