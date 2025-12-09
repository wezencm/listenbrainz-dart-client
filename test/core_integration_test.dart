/*
╔═══════════════════════════════════════════════════════════════════════════╗ 
║                     ____            _   _                                 ║ 
║                    / ___|__ _ _   _| |_(_) ___  _ __                      ║ 
║                   | |   / _` | | | | __| |/ _ \| '_ \                     ║ 
║                   | |__| (_| | |_| | |_| | (_) | | | |                    ║ 
║                    \____\__,_|\__,_|\__|_|\___/|_| |_|                    ║
║                                                                           ║
╟───────────────────────────────────────────────────────────────────────────╢
║      DO NOT RUN THESE TESTS AGAINST THE OFFICIAL LISTENBRAINZ SERVER      ║
║                    PLEASE BUILD YOUR OWN LOCAL SERVER                     ║
║  https://listenbrainz.readthedocs.io/en/latest/developers/devel-env.html  ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
*/

import 'dart:io';

import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/src/listenbrainz.dart';
import 'package:listenbrainz/types/additional_info.dart';
import 'package:listenbrainz/types/submission_listen.dart';
import 'package:listenbrainz/types/track_metadata.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:test/test.dart';

void main() {
  final token = Platform.environment['LISTENBRAINZ_TEST_TOKEN'] ?? '';
  final listenbrainzUrl = Platform.environment['LISTENBRAINZ_TEST_URL'] ?? '';
  if (token.isEmpty) {
    Skip('LISTENBRAINZ_TEST_TOKEN not set');
  }
  if (listenbrainzUrl.isEmpty) {
    Skip('LISTENBRAINZ_TEST_URL not set');
  }

  final singleListen = SubmissionListen(
    listenedAt: null,
    trackMetadata: TrackMetadata(
      artistName: 'BROODS', 
      trackName: 'Honest (Lunice remix)',
      releaseName: 'Honest (remixes)',
      additionalInfo: AdditionalInfo(
        artistMbids: [
          UuidString('68205c8f-9518-4b49-8df7-bd297da67599'),
          UuidString('23101701-cecf-4c9b-9b4c-d6a249eac118'),
        ],
        releaseMbid: UuidString('82422e49-bf77-48c9-98fd-f09f8aa9cb04'),
        recordingMbid: UuidString('aa534844-00f1-46d5-a0ae-15917cdefbab'),
      ),
    ),
  );

  final listenbrainz = ListenBrainz(( 
    listenBrainzServerUrl: listenbrainzUrl,
    token: token,
    musicBrainzServerUrl: 'https://musicbrainz.org',
    appClientName: 'ListenBrainz Dart Client',
    appClientVersion: '0.0.1',
    appDeveloperContact: 'https://github.com/wezencm/listenbrainz-dart-client',
    client: null,
    rateLimiter: null,
  ));
  group('Core', () {

    test('User search', () async {
      final res = await listenbrainz.core.searchUser('wezencm');
      //expect(jsonDecode(res.body)['users'][0]['user_name'], 'wezenCM');
      expect(res[0], 'wezenCM');
    });

    test('Similar users', () async {
      final similar = await listenbrainz.core.similarUsers('wezenCM');
      expect(similar[0].userName, 'friedhardware');

      final similarTo = await listenbrainz.core.similarTo('wezenCM', 'friedhardware');
      expect(similarTo.userName, 'friedhardware');

    });

    test('Playing now', () async {
      final listen = singleListen;

      final setResult = await listenbrainz.core.setPlayingNow(listen);
      expect(setResult, true);

      // wait the server updates the listen
      await Future.delayed(Duration(seconds: 1));

      final getResult = await listenbrainz.core.getPlayingNow('wezenCM');

      final artistName = getResult.listens[0].trackMetadata.artistName;
      final trackName = getResult.listens[0].trackMetadata.trackName;
      final isPlayingNow = getResult.listens[0].playingNow;
      expect(artistName, listen.trackMetadata.artistName);
      expect(trackName, listen.trackMetadata.trackName);
      expect(isPlayingNow, true);
    });
    
    test('should throw error in submit single listen without listenedAt', () async {
      expect(
        () => listenbrainz.core.submitSingleListen(singleListen),
        throwsException,
      );
    });

    test('Submit single listen', () async {
      singleListen.listenedAt = ((DateTime.now().millisecondsSinceEpoch - 5000) / 1000).round();
      final res = await listenbrainz.core.submitSingleListen(singleListen);
      expect(res, true);
    });

    test('List listens', () async {

      // wait the server updates the listen from the previous test
      await Future.delayed(Duration(seconds: 1));

      final res = await listenbrainz.core.userListens(
        'wezenCM',
        ListenBrainzConstants.DEFAULT_ITEMS_PER_GET,
      );

      final artistName = res.listens[0].trackMetadata.artistName;
      final trackName = res.listens[0].trackMetadata.trackName;

      expect(artistName, singleListen.trackMetadata.artistName);
      expect(trackName, singleListen.trackMetadata.trackName);
    },);

    test('should list listens throw error', () async {
      expect(
        () => listenbrainz.core.userListens('user', 0),
        throwsException
      );
      expect(
        () => listenbrainz
          .core
          .userListens(
            'user', 
            ListenBrainzConstants.MAX_ITEMS_PER_GET + 1
        ),
        throwsException
      );
    });
    test('Delete listen', () async {
      final listens = await listenbrainz.core.userListens('wezenCM', 1);
      final listenedAt = listens.listens[0].listenedAt!;
      final recordingMsid = listens.listens[0].recordingMsid!;

      final res = await listenbrainz.core.deleteListen(listenedAt, recordingMsid);
      expect(res, true);
    });

    test('Services', () async {
      final res = await listenbrainz.core.services('wezenCM');
      expect(res.userName, 'wezenCM');
      expect(res.services.contains(
        ConnectedServices.fromString('musicbrainz-prod')
      ), true);
    });

    test('Radio tags', () async {
      final res = await listenbrainz.core.lbRadioTags(
        tag: ['folk', 'punk', 'indie'],
        operator: LbRadioOperators.or,
        popBegin: 0,
        popEnd: 100,
        count: 5,
      );

      // on a custom server is likely that the server responds with a empty list of recordings.
      expect(res.isEmpty, true);
    });

/*     test('Radio Artists', () async {
      final res = await listenbrainz.core.lbRadioArtist(
        seedArtistMbid: singleListen.trackMetadata.additionalInfo!.artistMbids![0],
        mode: RadioModes.easy,
        maxRecordingsPerArtist: 5,
        maxSimilarArtists: 2,
        popBegin: 0,
        popEnd: 100,
      );
    }); */

    test('Set Latest Import', () async {
      final res = await listenbrainz.core.setLatestImport(150);
      
      expect(res, true);
    });

    test('Get Latest Import', () async {
      // wait the server updates the listen from the previous test
      await Future.delayed(Duration(seconds: 1));

      final res = await listenbrainz.core.getLatestImport('wezenCM');

      expect(res.latestImport, 150);
      expect(res.musicbrainzId, 'wezenCM');
    });


/*     test('Similar users', () async {
      final res = await listenbrainz.core.similarUsers;
    }); */
  }, skip: token.isEmpty || listenbrainzUrl.isEmpty);
}
