import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:listenbrainz/components/core.dart';
import 'package:listenbrainz/api_exception.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/types/track_metadata.dart';
import 'package:listenbrainz/utils/rate_limiter.dart';
import 'package:listenbrainz/types/additional_info.dart';
import 'package:listenbrainz/types/response_listen.dart';
import 'package:listenbrainz/types/submission_listen.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:test/test.dart';

void main() {
  Core buildCore(http.Client client) {
    final params = (
      token: 'token',
      listenBrainzServerUrl: 'https://listenbrainz.test',
      musicBrainzServerUrl: 'https://musicbrainz.org',
      appClientName: 'listenbrainz-dart-client',
      appClientVersion: '0.0.1',
      appDeveloperContact: 'test-suite@listenbrainz',
      client: null,
      rateLimiter: null,
    );

    return Core(params, RateLimiter(), client);
  }

  SubmissionListen buildListen({int? listenedAt}) {
    return SubmissionListen(
      listenedAt: listenedAt,
      trackMetadata: TrackMetadata(
        artistName: 'Artist',
        trackName: 'Track',
        releaseName: 'Release',
        additionalInfo: AdditionalInfo(),
      ),
    );
  }

  group('Core.searchUser', () {
    test('sends search term query and parses usernames', () async {
      late Uri capturedUri;
      final mockClient = MockClient((request) async {
        capturedUri = request.url;
        final body = {
          'users': [
            {'user_name': 'wezenCM'},
            {'user_name': 'friedhardware'},
          ],
        };
        return http.Response(jsonEncode(body), 200);
      });

      final result = await buildCore(mockClient).searchUser('wez');

      expect(result, ['wezenCM', 'friedhardware']);
      expect(capturedUri.path, '/1/search/users/');
      expect(capturedUri.queryParameters['search_term'], 'wez');
    });
  });

  group('Core.submitSingleListen', () {
    test('returns true when API responds with ok status', () async {
      Map<String, dynamic>? capturedBody;
      final mockClient = MockClient((request) async {
        capturedBody = jsonDecode(request.body) as Map<String, dynamic>;
        return http.Response(jsonEncode({'status': 'ok'}), 200);
      });

      final result =
          await buildCore(mockClient).submitSingleListen(buildListen(listenedAt: 123));

      expect(result, isTrue);
      expect(capturedBody?['listen_type'], 'single');
      expect((capturedBody?['payload'] as List).length, 1);
    });

    test('surface API errors returned by backend', () async {
      final mockClient = MockClient((request) async {
        final errorBody = {'code': 400, 'error': 'missing listened_at'};
        return http.Response(jsonEncode(errorBody), 400);
      });

      expect(
        () => buildCore(mockClient).submitSingleListen(buildListen()),
        throwsA(isA<ApiException>().having((e) => e.code, 'code', 400)),
      );
    });
  });

  group('Core.userListens', () {
    test('parses payload into strongly typed response', () async {
      final listenJson = ResponseListen(
        playingNow: true,
        insertedAt: 111,
        listenedAt: 111,
        recordingMsid: UuidString('11111111-1111-1111-1111-111111111111'),
        userId: 'test-user',
        trackMetadata: ResponseTrackMetadata(
          'Artist',
          'Release',
          'Track',
          AdditionalInfo(),
          null,
          null,
        ),
      ).toJson();

      final payload = {
        'count': 1,
        'latest_listen_ts': 111,
        'listens': [listenJson],
        'oldest_listen_ts': 111,
        'user_id': 'test-user',
      };

      final mockClient = MockClient((request) async {
        expect(request.url.path, '/1/user/test-user/listens');
        expect(request.url.queryParameters['count'], '1');
        return http.Response(jsonEncode({'payload': payload}), 200);
      });

      final response = await buildCore(mockClient).userListens('test-user', 1);

      expect(response.count, 1);
      expect(response.latestListenTs, 111);
      expect(response.oldestListenTs, 111);
      expect(response.userId, 'test-user');
      expect(response.listens.single.trackMetadata.artistName, 'Artist');
    });

    test('throws when count is zero or negative', () async {
      final core = buildCore(MockClient((_) async => throw UnimplementedError()));

      expect(
        () => core.userListens('user', 0),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => core.userListens('user', -1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws when count exceeds ListenBrainz limit', () async {
      final core = buildCore(MockClient((_) async => throw UnimplementedError()));

      expect(
        () => core.userListens('user', ListenBrainzConstants.MAX_ITEMS_PER_GET + 1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Core.similar users', () {
    test('parses list payload from API', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/1/user/alex/similar-users');
        return http.Response(
          jsonEncode({
            'payload': [
              {'similarity': 0.87, 'user_name': 'pat'},
            ],
          }),
          200,
        );
      });

      final result = await buildCore(mockClient).similarUsers('alex');

      expect(result.single.userName, 'pat');
      expect(result.single.similarity, closeTo(0.87, 0.0001));
    });

    test('parses tuple payload for similarTo', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/1/user/alex/similar-to/jamie');
        return http.Response(
          jsonEncode({
            'payload': {'similarity': 0.42, 'user_name': 'jamie'}
          }),
          200,
        );
      });

      final result = await buildCore(mockClient).similarTo('alex', 'jamie');

      expect(result.userName, 'jamie');
      expect(result.similarity, closeTo(0.42, 0.0001));
    });
  });

  group('Core.lbRadioTags', () {
    test('requires operator when more than one tag provided', () {
      final core = buildCore(MockClient((_) async => throw UnimplementedError()));

      expect(
        () => core.lbRadioTags(
          tag: ['rock', 'pop'],
          operator: null,
          popBegin: 0,
          popEnd: 10,
          count: 5,
        ),
        throwsA(isA<ApiException>()),
      );
    });

    test('validates popularity ranges', () {
      final core = buildCore(MockClient((_) async => throw UnimplementedError()));

      expect(
        () => core.lbRadioTags(
          tag: ['rock'],
          operator: null,
          popBegin: -1,
          popEnd: 10,
          count: 5,
        ),
        throwsA(isA<RangeError>()),
      );

      expect(
        () => core.lbRadioTags(
          tag: ['rock'],
          operator: null,
          popBegin: 0,
          popEnd: 101,
          count: 5,
        ),
        throwsA(isA<RangeError>()),
      );
    });
  });
}

