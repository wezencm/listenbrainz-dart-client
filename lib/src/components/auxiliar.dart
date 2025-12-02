import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listenbrainz/src/utils/rate_limiter.dart';
import 'package:listenbrainz/src/types/instance_init.dart';
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
      final url = '${params.musicBrainzServerUrl}/ws/2/recording?query=$query&fmt=json';

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'User-Agent': '${params.appClientName}/${params.appClientVersion} (${params.appDeveloperContact})',
        },
      );

      final searchResult = jsonDecode(utf8.decode(response.bodyBytes));
      final recordings = searchResult['recordings'];
      //final recording = searchResult['recordings'][0];
      for (var recording in recordings) {
        final resultArtists = (recording['artist-credit'] as List)
          .map((artist) => artist['name'])
          .toList();
        
        final matchedArtists = 
          artists.where(
            (artist) => resultArtists.any(
              (resultArtist) => artist == resultArtist
            )
          );

        const double minJaroWinklerSimilarity = 80.0;
        final matchSongName = 
            jaroWinklerDistance(name, recording['title']) > minJaroWinklerSimilarity;

        if (matchSongName && matchedArtists.isNotEmpty) {
          return {
            'track': {
              'name': recording['title'],
              'mbid': recording['id'],
            },
            'durationInSeconds': recording['length'],
            'album': {
              'name': recording['releases'][0]['title'],
              'mbid': recording['releases'][0]['id'],
            },
            'artists': (recording['artist-credit'] as List).map((artist) {
              return {
                'name': artist['name'],
                'mbid': artist['artist']['id'],
              };
            }).toList(),
          };
        }
      }

      return null;

    } catch (_) {
      return null;
    }
  }
}