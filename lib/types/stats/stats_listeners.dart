import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';

part 'stats_listeners.g.dart';

@JsonSerializable()
class StatsListeners {
  final int listenCount;
  final String userName;

  StatsListeners({
    required this.listenCount,
    required this.userName,
  });

  factory StatsListeners.fromJson(Map<String, dynamic> json) => 
    _$StatsListenersFromJson(json);

  Map<String, dynamic> toJson() => _$StatsListenersToJson(this);
}

class StatsListenersBase {
  final String artistName;
  @JsonKey(name: "from_ts")
  final DateTime from;
  @JsonKey(name: "to_ts")
  final DateTime to;
  final DateTime lastUpdated;
  final AllowedStatisticsRange statsRange;
  final List<StatsListeners> listeners;
  final int totalListenCount;
  final int totalUserCount;

  StatsListenersBase({
    required this.artistName,
    required this.from,
    required this.to,
    required this.lastUpdated,
    required this.statsRange,
    required this.listeners,
    required this.totalListenCount,
    required this.totalUserCount,
  });
}