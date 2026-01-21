import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/types/stats/allowed_statistics_range.dart';

class StatsFields {

  /// Number of items to skip from the beginning, for pagination.
  final int? offset;

  /// Total number of items returned.
  final int? count;

  /// Time interval for which statistics should be returned, 
  /// possible values are [AllowedStatisticsRange], defaults to [AllowedStatisticsRange.allTime].
  @JsonKey(includeIfNull: false)
  final AllowedStatisticsRange? range;

  /// When the statistics was last calculated.
  final DateTime lastUpdated;

  /// The user who holds the stats fetched.
  final String? userId;

  /// Starting period from the returned statistics
  @JsonKey(name: "from_ts")
  final DateTime from;

  /// Ending period from the returned statistics
  @JsonKey(name: "to_ts")
  final DateTime to;

  StatsFields({
    this.offset,
    this.count = ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
    this.range /* = AllowedStatisticsRange.allTime */,
    required this.lastUpdated,
    this.userId,
    required this.from,
    required this.to,
  });
}