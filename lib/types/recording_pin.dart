import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/track_metadata.dart';
import 'package:listenbrainz/types/types.dart';

part 'recording_pin.g.dart';

@UuidConverter()
@DateTimeMillisecondsConverter()
@JsonSerializable()
class RecordingPin {
  final UuidString? recordingMsid;
  final UuidString? recordingMbid;
  final String blurbContent;
  final DateTime pinnedUntil;
  final TrackMetadata? trackMetadata;
  final DateTime? created;
  final int? rowId;
  final String? userName;

  RecordingPin({
    this.recordingMbid,
    this.recordingMsid,
    required this.blurbContent,
    required this.pinnedUntil,
    this.trackMetadata,
    this.created,
    this.rowId,
    this.userName,
  });

  factory RecordingPin.fromJson(Map<String, dynamic> json) => 
    _$RecordingPinFromJson(json);

  Map<String, dynamic> toJson() => _$RecordingPinToJson(this);
}

@JsonSerializable()
class FetchedPins {
  final int count;
  final int offset;
  final int? totalCount;
  final List<RecordingPin> pinnedRecordings;
  final String userName;

  FetchedPins({
    required this.count,
    required this.totalCount,
    required this.offset,
    required this.pinnedRecordings,
    required this.userName,
  });

    factory FetchedPins.fromJson(Map<String, dynamic> json) => 
    _$FetchedPinsFromJson(json);

  Map<String, dynamic> toJson() => _$FetchedPinsToJson(this);
}