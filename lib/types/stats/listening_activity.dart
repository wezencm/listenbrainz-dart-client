import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/fields.dart';
import 'package:listenbrainz/types/stats/stats.dart';

part 'listening_activity.g.dart';

@JsonSerializable()
@DateTimeMillisecondsConverter()
class ListeningActivityPayload extends StatsFields{
/*   @JsonKey(name: "from_ts")
  final DateTime from;
  @JsonKey(name: "to_ts")
  final DateTime to;
  final DateTime lastUpdated;
  final String? userId;
  final AllowedStatisticsRange range; */
  final List<ListeningActivity> listeningActivity;

  ListeningActivityPayload({
    required super.from,
    required super.to,
    required super.lastUpdated,
    super.userId,
    required super.range,
    required this.listeningActivity,
  });

  factory ListeningActivityPayload.fromJson(Map<String, dynamic> json) => 
    _$ListeningActivityPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningActivityPayloadToJson(this);
}

@JsonSerializable()
@DateTimeMillisecondsConverter()
class ListeningActivity {
  @JsonKey(name: "from_ts")
  final DateTime from;
  @JsonKey(name: "to_ts")
  final DateTime to;
  final int listenCount;
  final String timeRange;

  ListeningActivity({
    required this.from,
    required this.to,
    required this.listenCount,
    required this.timeRange,
  });

  factory ListeningActivity.fromJson(Map<String, dynamic> json) => 
    _$ListeningActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ListeningActivityToJson(this);
}