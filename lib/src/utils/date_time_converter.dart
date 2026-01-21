import 'package:json_annotation/json_annotation.dart';

class DateTimeMillisecondsConverter implements JsonConverter<DateTime, int> {
  const DateTimeMillisecondsConverter();

  @override
  DateTime fromJson(int json) {
    var timestamp = json;
    if (isInSeconds(json)) {
      timestamp = json * 1000;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  int toJson(DateTime object) => (object.millisecondsSinceEpoch / 1000).floor(); // listenbrainz uses seconds anyway 
}

bool isInMilliseconds(int timestamp) {
  return timestamp > (100000000000); 
}

bool isInSeconds(int timestamp) {
  return !isInMilliseconds(timestamp);
}
