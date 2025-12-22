import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listenbrainz/utils/rate_limiter.dart';
import 'package:listenbrainz/types/instance_init.dart';
import 'package:listenbrainz/src/utils/jaro_winkler_distance.dart';


/// Some auxiliary functions to help.
class Aux {
  final RateLimiter limiter;
  final InitParams params;
  final http.Client _client;
  
  const Aux(this.params, this.limiter, this._client);

  /// Tries to associate a track info to a MusicBrainz recording
  Future<Map<String, dynamic>?> matchSongMusicBrainz({
    required String name,
    required List<String> artists,
    String? album,
    int? durationInSeconds,
  }) async {
    try {
      final query = 'recording:$name${artists.map((a) => ' AND artist:$a').join()}';
      final url = '${params.musicBrainzServerUrl}/ws/2/recording?query=$query&fmt=json&limit=100';

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              '${params.appClientName}/${params.appClientVersion} (${params.appDeveloperContact})',
        },
      );

      final searchResult = jsonDecode(utf8.decode(response.bodyBytes));
      final recordings = searchResult['recordings'] as List<dynamic>? ?? [];

      for (final recording in recordings) {
        final title = recording['title'] as String?;
        if (title == null) continue;

        // Normalize artist names
        final resultArtists = (recording['artist-credit'] as List<dynamic>)
            .map((artist) => (artist['name'] as String).toLowerCase())
            .toList();

        final matchedArtists = artists.where((artist) =>
            resultArtists.contains(artist.toLowerCase()));

        const double minJaroWinklerSimilarity = 0.80;
        final matchSongName =
            jaroWinklerDistance(name.toLowerCase(), title.toLowerCase()) >
                minJaroWinklerSimilarity;

        // Optional duration check (allow a tolerance of 5 seconds)
        final lengthMs = recording['length'] as int?;
        final lengthSec = lengthMs != null ? (lengthMs / 1000).round() : null;
        final durationMatches = durationInSeconds == null ||
            (lengthSec != null &&
                (lengthSec - durationInSeconds).abs() <= 5);

        // Optional album check
        final releases = recording['releases'] as List<dynamic>? ?? [];
        final release = releases.isNotEmpty ? releases.first : null;
        final albumMatches = album == null ||
            (release != null &&
                (release['title'] as String?)?.toLowerCase() ==
                    album.toLowerCase());

        if (matchSongName &&
            matchedArtists.isNotEmpty &&
            durationMatches &&
            albumMatches) {
          return {
            'track': {
              'name': title,
              'mbid': recording['id'],
            },
            'durationInSeconds': lengthSec,
            'album': release != null
                ? {
                    'name': release['title'],
                    'mbid': release['id'],
                  }
                : null,
            'artists': (recording['artist-credit'] as List<dynamic>).map((artist) {
              return {
                'name': artist['name'],
                'mbid': artist['artist']?['id'],
              };
            }).toList(),
          };
        }
      }

      return null;
    } catch (e) {
      // Log error if needed
      return null;
    }
  }

}