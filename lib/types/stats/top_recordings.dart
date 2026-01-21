import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/fields.dart';
import 'package:listenbrainz/types/stats/stats.dart';

part 'top_recordings.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class TopRecordings extends StatsFields {
  final List<TopRecording> recordings;
  final int totalRecordingCount;
  
  TopRecordings({
    required this.recordings,
    required this.totalRecordingCount,
    super.offset,
    super.count,
    super.range,
    required super.lastUpdated, 
    required super.userId, 
    required super.from, 
    required super.to,
  });

  factory TopRecordings.fromJson(Map<String, dynamic> json) => 
    _$TopRecordingsFromJson(json);

  Map<String, dynamic> toJson() => _$TopRecordingsToJson(this);
}

@UuidConverter()
@JsonSerializable(includeIfNull: true)
class TopRecording {
    final List<UuidString>? artistMbids;
    final String artistName;
    final int listenCount;
    final UuidString? recordingMbid;
    final UuidString? releaseMbid;
    final String? releaseName;
    final String trackName;
    @JsonKey(includeIfNull: false)
    final List<TopReleaseArtist>? artists;
    final int? caaId;
    final UuidString? caaReleaseMbid;

  TopRecording({
    this.artistMbids,
    required this.artistName,
    required this.listenCount,
    this.recordingMbid,
    this.releaseMbid,
    this.releaseName,
    required this.trackName,
    this.artists,
    this.caaId,
    this.caaReleaseMbid,
  });

  factory TopRecording.fromJson(Map<String, dynamic> json) => 
    _$TopRecordingFromJson(json);

  Map<String, dynamic> toJson() => _$TopRecordingToJson(this);
}
