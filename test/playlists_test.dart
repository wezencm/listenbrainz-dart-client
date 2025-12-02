import 'dart:io';

import 'package:listenbrainz/listenbrainz.dart';
import 'package:test/test.dart';

void main() {
  final token = Platform.environment['LISTENBRAINZ_TEST_TOKEN'] ?? '';
  final listenbrainzUrl = Platform.environment['LISTENBRAINZ_TEST_URL'] ?? '';
  group('Playlists', () {
    if (token.isEmpty) {
      Skip('LISTENBRAINZ_TEST_TOKEN not set');
    }
    if (listenbrainzUrl.isEmpty) {
      Skip('LISTENBRAINZ_TEST_URL not set');
    }

    final listenbrainz = ListenBrainz((
      token: token,
      listenBrainzServerUrl: listenbrainzUrl,
      musicBrainzServerUrl: 'https://musicbrainz.org',
      appClientName: 'ListenBrainz Dart Client',
      appClientVersion: '0.0.1',
      appDeveloperContact: 'https://github.com/wezencm/listenbrainz-dart-client',
      client: null,
      rateLimiter: null,
    ));

    final playlist = Playlist(
      title: '.-teste-.',
      track: [
        PlaylistTrack(
          title: 'Sleep and Death',
          identifier: [UuidString('8a3df0d0-ec11-4900-95d6-0c448b5681bc')],
          album: 'Twilight',
          creator: 'Erben der Schöpfung',
          extension: TrackExtension(
            musicBrainzTrackExtension: MusicBrainzTrackExtension(
              releaseIdentifier: UuidString('2f465d57-09ff-365e-8c53-e0053d65ff91'),
              artistIdentifiers: [UuidString('7c06a8cc-6fd6-40d7-b53b-fc7a937171a1')],
            ),
          ),
        ),
      ],
    );
/*     test('Get playlists', () async {
      final res = await listenbrainz.playlist.getPlaylists('wezenCM');
    }); */

    test('Export playlist', () async {
      final res = await listenbrainz.playlists.exportJspf(ConnectedServices.spotify, playlist, false);
      expect(res.externalUrl.contains('https://open.spotify.com/playlist/'), true);
    });
  }, skip: token.isEmpty || listenbrainzUrl.isEmpty);
}

