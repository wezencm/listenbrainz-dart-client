import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:listenbrainz/listenbrainz.dart';
import 'package:test/test.dart';

import 'contracts/compare_structure.dart';

void main() {
  ListenBrainz buildListenBrainz(http.Client client) {
    final params = (
      token: 'token',
      listenBrainzServerUrl: 'https://listenbrainz.test',
      musicBrainzServerUrl: 'https://musicbrainz.org',
      appClientName: 'listenbrainz-dart-client',
      appClientVersion: '0.0.1',
      appDeveloperContact: 'test-suite@listenbrainz',
      client: client,
      rateLimiter: null,
    );

    return ListenBrainz(params);
  }

  group("user", () {
    test("artists", () async {
      final exampleJson = File('test/contracts/stats/user_artists.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .artists();
      
      expect(result!.toJson(), equals(example));
    });

    test("releases", () async {
      final exampleJson = File('test/contracts/stats/user_releases.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .releases();

      final compare = compareJsonStructure(
        result!.toJson(), 
        example,
        optionalPaths: {"root.releases[5].artists"}
      );
      expect(compare, []);

      /* (example['releases'] as List).removeWhere((element) => element['artists'] == null);
      result!.releases.removeWhere((element) => element.artists == null);
      expect(result!.toJson(), equals(example)); */
    });

    test("release groups", () async {
      final exampleJson = File('test/contracts/stats/user_release-groups.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .releaseGroups();
      
      final compare = compareJsonStructure(
        result!.toJson(), 
        example,
        optionalPaths: {"root.release_groups[6].artists"}
      );
      expect(compare, []);
      /* (example['release_groups'] as List).removeWhere((element) => element['artists'] == null);
      result!.releaseGroups.removeWhere((element) => element.artists == null);
      expect(result!.toJson(), equals(example)); */
    });

    test("recordings", () async {
      final exampleJson = File('test/contracts/stats/user_recordings.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .recordings();

      final compare = compareJsonStructure(
        result!.toJson(), 
        example,
        optionalPaths: {"root.recordings[*].artists"}
      );
      expect(compare, []);
      /* (example['recordings'] as List).removeWhere((element) => element['artists'] == null);
      result!.recordings.removeWhere((element) => element.artists == null);
      expect(result!.toJson(), equals(example)); */
    });

    test("listening-activity", () async {
      final exampleJson = File('test/contracts/stats/user_listening-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .listeningActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("artist-activity", () async {
      final exampleJson = File('test/contracts/stats/user_artist-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .artistActivity();

      final compare = compareJsonStructure(
        result!.toJson(), 
        example,
        optionalPaths: {"root.artist_activity[11].artist_name"}
      );
      expect(compare, []);
      /* (example['artist_activity'] as List).removeWhere((element) => element['artist_name'] == null);
      result!.artistActivity.removeWhere((element) => element.artistName == null);
      expect(result!.toJson(), equals(example)); */
    });

    test("era-activity", () async {
      final exampleJson = File('test/contracts/stats/user_era-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .eraActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("genre-activity", () async {
      final exampleJson = File('test/contracts/stats/user_genre-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .genreActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("artist-evolution-activity", () async {
      final exampleJson = File('test/contracts/stats/user_artist-evolution-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .artistEvolutionActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("daily-activity", () async {
      final exampleJson = File('test/contracts/stats/user_daily-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .dailyActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("artist-map", () async {
      final exampleJson = File('test/contracts/stats/user_artist-map.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .artistMap();
      
      expect(result!.toJson(), equals(example));
    });

    test("year-in-music", () async {
      final exampleJson = File('test/contracts/stats/user_year-in-music.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload']['data'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .user('wezenCM')
            .yearInMusic();

      final compare = compareJsonStructure(
        result!.toJson(), 
        example,
        optionalPaths: {
          "root.top_recordings[*].artists",
          "root.top_release_groups[*].artists"
        }
      );
      expect(compare, []);

      /* expect(result!.playlistTopDiscoveriesForYear.date, DateTime.parse(example['playlist-top-discoveries-for-year']['date'] ));
      expect(result!.playlistTopMissedRecordingsForYear.date, DateTime.parse(example['playlist-top-missed-recordings-for-year']['date'] ));

      example['playlist-top-discoveries-for-year']['date'] = result!.playlistTopDiscoveriesForYear.date?.toIso8601String();
      example['playlist-top-missed-recordings-for-year']['date'] = result!.playlistTopMissedRecordingsForYear.date?.toIso8601String();

      expect(result!.toJson(), equals(example)); */
    });
  });

  group("artist", () {
    test("listeners", () async {
      final exampleJson = File('test/contracts/stats/artist_listeners.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .artist(UuidString("650726c6-cda9-4fc6-aac5-291e8628dfdf"))
            .listeners();
      
      expect(result!.toJson(), equals(example));
    });
  });

  group("release-group", () {
    test("listeners", () async {
      final exampleJson = File('test/contracts/stats/release-group_listeners.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .releaseGroup(UuidString("8042c203-e000-4690-94dd-2e2b46a4e538"))
            .listeners();
      
      expect(result!.toJson(), equals(example));
    });
  });

  group("sitewide", () {
    test("artists", () async {
      final exampleJson = File('test/contracts/stats/sitewide_artists.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .artists();
      
      expect(result!.toJson(), equals(example));
    });

    test("releases", () async {
      final exampleJson = File('test/contracts/stats/sitewide_releases.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .releases();
      
      expect(result!.toJson(), equals(example));
    });

    test("release-groups", () async {
      final exampleJson = File('test/contracts/stats/sitewide_release-groups.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .releaseGroups();
      
      expect(result!.toJson(), equals(example));
    });

    test("recordings", () async {
      final exampleJson = File('test/contracts/stats/sitewide_recordings.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .recordings();
      
      expect(result!.toJson(), equals(example));
    });

    test("listening-activity", () async {
      final exampleJson = File('test/contracts/stats/sitewide_listening-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .listeningActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("artist-activity", () async {
      final exampleJson = File('test/contracts/stats/sitewide_artist-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .artistActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("era-activity", () async {
      final exampleJson = File('test/contracts/stats/sitewide_era-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .eraActivity();
      
      expect(result!.toJson(), equals(example));
    });

    test("artist-evolution-activity", () async {
      /** endpoint returning http 301 without a valid location header */
      /* final exampleJson = File('test/contracts/stats/sitewide_artist-evolution-activity.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .artistEvolutionActivity();
      
      expect(result!.toJson(), equals(example)); */
      expect(false, true);
    });
  
    test("artist-map", () async {
      final exampleJson = File('test/contracts/stats/sitewide_artist-map.json').readAsStringSync();
      final example = jsonDecode(exampleJson)['payload'];

      final mockClient = MockClient((request) async {
        final body = exampleJson;
        return http.Response(body, 200);
      });

      final result = 
          await buildListenBrainz(mockClient)
            .stats
            .siteWide
            .artistMap();
      
      expect(result!.toJson(), equals(example));
    });
  });
}
