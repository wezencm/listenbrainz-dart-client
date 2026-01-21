import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/src/utils/date_time_converter.dart';
import 'package:listenbrainz/types/stats/stats.dart';

part 'artist_listeners.g.dart';

@JsonSerializable()
@UuidConverter()
@DateTimeMillisecondsConverter()
class ArtistListeners extends StatsListenersBase {
  final UuidString? artistMbid;

  ArtistListeners({
    this.artistMbid,
    required super.artistName,
    required super.from,
    required super.to,
    required super.lastUpdated,
    required super.statsRange,
    required super.listeners,
    required super.totalListenCount,
    required super.totalUserCount,
  });

  factory ArtistListeners.fromJson(Map<String, dynamic> json) => 
    _$ArtistListenersFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistListenersToJson(this);
}