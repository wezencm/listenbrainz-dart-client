// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_in_music.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearInMusic _$YearInMusicFromJson(Map<String, dynamic> json) => YearInMusic(
      artistEvolutionActivity:
          (json['artist_evolution_activity'] as List<dynamic>)
              .map((e) =>
                  ArtistEvolutionActivity.fromJson(e as Map<String, dynamic>))
              .toList(),
      artistMap: (json['artist_map'] as List<dynamic>)
          .map((e) => ArtistMap.fromJson(e as Map<String, dynamic>))
          .toList(),
      dayOfWeek: json['day_of_week'] as String,
      genreActivity: (json['genre_activity'] as List<dynamic>)
          .map((e) => GenreActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      listensPerDay: (json['listens_per_day'] as List<dynamic>)
          .map((e) => ListeningActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostListenedYear:
          (json['most_listened_year'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
      newReleasesOfTopArtists:
          (json['new_releases_of_top_artists'] as List<dynamic>)
              .map((e) =>
                  NewReleasesOfTopArtists.fromJson(e as Map<String, dynamic>))
              .toList(),
      playlistTopDiscoveriesForYear: Playlist.fromJson(
          json['playlist-top-discoveries-for-year'] as Map<String, dynamic>),
      playlistTopMissedRecordingsForYear: Playlist.fromJson(
          json['playlist-top-missed-recordings-for-year']
              as Map<String, dynamic>),
      similarUsers: (json['similar_users'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      topArtists: (json['top_artists'] as List<dynamic>)
          .map((e) => TopArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      topGenres: (json['top_genres'] as List<dynamic>)
          .map((e) => TopGenre.fromJson(e as Map<String, dynamic>))
          .toList(),
      topRecordings: (json['top_recordings'] as List<dynamic>)
          .map((e) => TopRecording.fromJson(e as Map<String, dynamic>))
          .toList(),
      topReleaseGroups: (json['top_release_groups'] as List<dynamic>)
          .map((e) => TopReleaseGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalArtistsCount: (json['total_artists_count'] as num).toInt(),
      totalListenCount: (json['total_listen_count'] as num).toInt(),
      totalListeningTime:
          YearInMusic._durationFromJson(json['total_listening_time'] as num),
      totalNewArtistsDiscovered:
          (json['total_new_artists_discovered'] as num).toInt(),
      totalRecordingsCount: (json['total_recordings_count'] as num).toInt(),
      totalReleaseGroupsCount:
          (json['total_release_groups_count'] as num).toInt(),
    );

Map<String, dynamic> _$YearInMusicToJson(YearInMusic instance) =>
    <String, dynamic>{
      'artist_evolution_activity':
          instance.artistEvolutionActivity.map((e) => e.toJson()).toList(),
      'artist_map': instance.artistMap.map((e) => e.toJson()).toList(),
      'day_of_week': instance.dayOfWeek,
      'genre_activity': instance.genreActivity.map((e) => e.toJson()).toList(),
      'listens_per_day': instance.listensPerDay.map((e) => e.toJson()).toList(),
      'most_listened_year':
          instance.mostListenedYear.map((k, e) => MapEntry(k.toString(), e)),
      'new_releases_of_top_artists':
          instance.newReleasesOfTopArtists.map((e) => e.toJson()).toList(),
      'playlist-top-discoveries-for-year':
          instance.playlistTopDiscoveriesForYear.toJson(),
      'playlist-top-missed-recordings-for-year':
          instance.playlistTopMissedRecordingsForYear.toJson(),
      'similar_users': instance.similarUsers,
      'top_artists': instance.topArtists.map((e) => e.toJson()).toList(),
      'top_genres': instance.topGenres.map((e) => e.toJson()).toList(),
      'top_recordings': instance.topRecordings.map((e) => e.toJson()).toList(),
      'top_release_groups':
          instance.topReleaseGroups.map((e) => e.toJson()).toList(),
      'total_artists_count': instance.totalArtistsCount,
      'total_listen_count': instance.totalListenCount,
      'total_listening_time':
          YearInMusic._durationToJson(instance.totalListeningTime),
      'total_new_artists_discovered': instance.totalNewArtistsDiscovered,
      'total_recordings_count': instance.totalRecordingsCount,
      'total_release_groups_count': instance.totalReleaseGroupsCount,
    };

TopGenre _$TopGenreFromJson(Map<String, dynamic> json) => TopGenre(
      genre: json['genre'] as String,
      genreCount: (json['genre_count'] as num).toInt(),
      genreCountPercent: (json['genre_count_percent'] as num).toDouble(),
    );

Map<String, dynamic> _$TopGenreToJson(TopGenre instance) => <String, dynamic>{
      'genre': instance.genre,
      'genre_count': instance.genreCount,
      'genre_count_percent': instance.genreCountPercent,
    };

NewReleasesOfTopArtists _$NewReleasesOfTopArtistsFromJson(
        Map<String, dynamic> json) =>
    NewReleasesOfTopArtists(
      artistCreditMbids: (json['artist_credit_mbids'] as List<dynamic>)
          .map((e) => const UuidConverter().fromJson(e as String))
          .toList(),
      artistCreditName: json['artist_credit_name'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => TopReleaseArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      caaId: (json['caa_id'] as num?)?.toInt(),
      caaReleaseMbid: _$JsonConverterFromJson<String, UuidString>(
          json['caa_release_mbid'], const UuidConverter().fromJson),
      releaseGroupMbid: _$JsonConverterFromJson<String, UuidString>(
          json['release_group_mbid'], const UuidConverter().fromJson),
      title: json['title'] as String,
    );

Map<String, dynamic> _$NewReleasesOfTopArtistsToJson(
        NewReleasesOfTopArtists instance) =>
    <String, dynamic>{
      'artist_credit_mbids':
          instance.artistCreditMbids.map(const UuidConverter().toJson).toList(),
      'artist_credit_name': instance.artistCreditName,
      'artists': instance.artists.map((e) => e.toJson()).toList(),
      'caa_id': instance.caaId,
      'caa_release_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.caaReleaseMbid, const UuidConverter().toJson),
      'release_group_mbid': _$JsonConverterToJson<String, UuidString>(
          instance.releaseGroupMbid, const UuidConverter().toJson),
      'title': instance.title,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
