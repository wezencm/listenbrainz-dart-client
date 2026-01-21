import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:listenbrainz/types/stats/artist_evolution_activity.dart';
import 'package:listenbrainz/types/stats/artist_map.dart';
import 'package:listenbrainz/types/stats/genre_activity.dart';
import 'package:listenbrainz/types/stats/listening_activity.dart';
import 'package:listenbrainz/types/stats/top_artists.dart';
import 'package:listenbrainz/types/stats/top_recordings.dart';
import 'package:listenbrainz/types/stats/top_release_groups.dart';
import 'package:listenbrainz/types/stats/top_releases.dart';

part 'year_in_music.g.dart';

@JsonSerializable()
class YearInMusic {
  final List<ArtistEvolutionActivity> artistEvolutionActivity;
  final List<ArtistMap> artistMap;
  final String dayOfWeek;
  final List<GenreActivity> genreActivity;
  final List<ListeningActivity> listensPerDay;
  final Map<int, int> mostListenedYear;
  final List<NewReleasesOfTopArtists> newReleasesOfTopArtists;
  @JsonKey(name: "playlist-top-discoveries-for-year")
  final Playlist playlistTopDiscoveriesForYear;
  @JsonKey(name: "playlist-top-missed-recordings-for-year")
  final Playlist playlistTopMissedRecordingsForYear;
  final Map<String, double> similarUsers;
  final List<TopArtist> topArtists;
  final List<TopGenre> topGenres;
  final List<TopRecording> topRecordings;
  final List<TopReleaseGroup> topReleaseGroups;
  final int totalArtistsCount;
  final int totalListenCount;
  @JsonKey(
    fromJson: _durationFromJson,
    toJson: _durationToJson,
  )
  final Duration totalListeningTime;
  final int totalNewArtistsDiscovered;
  final int totalRecordingsCount;
  final int totalReleaseGroupsCount;

  YearInMusic({
    required this.artistEvolutionActivity,
    required this.artistMap,
    required this.dayOfWeek,
    required this.genreActivity,
    required this.listensPerDay,
    required this.mostListenedYear,
    required this.newReleasesOfTopArtists,
    required this.playlistTopDiscoveriesForYear,
    required this.playlistTopMissedRecordingsForYear,
    required this.similarUsers,
    required this.topArtists,
    required this.topGenres,
    required this.topRecordings,
    required this.topReleaseGroups,
    required this.totalArtistsCount,
    required this.totalListenCount,
    required this.totalListeningTime,
    required this.totalNewArtistsDiscovered,
    required this.totalRecordingsCount,
    required this.totalReleaseGroupsCount,
  });

  factory YearInMusic.fromJson(Map<String, dynamic> json) => 
    _$YearInMusicFromJson(json);

  Map<String, dynamic> toJson() => _$YearInMusicToJson(this);

  static Duration _durationFromJson(num json) => 
      Duration(microseconds: (json * 1e6).round());

  static num _durationToJson(Duration duration) => 
      duration.inMicroseconds / 1e6;
}

@JsonSerializable()
class TopGenre {
  final String genre;
  final int genreCount;
  final double genreCountPercent;

  TopGenre({
    required this.genre,
    required this.genreCount,
    required this.genreCountPercent,
  });

  factory TopGenre.fromJson(Map<String, dynamic> json) => 
    _$TopGenreFromJson(json);

  Map<String, dynamic> toJson() => _$TopGenreToJson(this);
}

@JsonSerializable(includeIfNull: true)
@UuidConverter()
class NewReleasesOfTopArtists {
  final List<UuidString> artistCreditMbids;
  final String artistCreditName;
  final List<TopReleaseArtist> artists;
  final int? caaId;
  final UuidString? caaReleaseMbid;
  final UuidString? releaseGroupMbid;
  final String title;

  NewReleasesOfTopArtists({
    required this.artistCreditMbids,
    required this.artistCreditName,
    required this.artists,
    this.caaId,
    this.caaReleaseMbid,
    this.releaseGroupMbid,
    required this.title,
  });

  factory NewReleasesOfTopArtists.fromJson(Map<String, dynamic> json) => 
    _$NewReleasesOfTopArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$NewReleasesOfTopArtistsToJson(this);
}