# ListenBrainz Dart Client

A strongly typed Dart client for the [ListenBrainz](https://listenbrainz.org/) API.
It wraps the public Core and Playlist endpoints, adds request throttling, and
exposes helpers for building submissions or parsing responses inside Flutter, Dart CLI
tools, or server-side apps.

## Features

- Covers Core API actions such as submitting listens, browsing user histories, searching
  users, and fetching similarity data.
- Playlist management helpers (`getPlaylists`, `create`, `edit`, `addRecordings`, …) using
  the ListenBrainz JSPF schema.
- Consistent `ApiException` error surface plus a rate limiter to avoid hitting API caps.
- Generated DTOs for listen payloads, playlists, UUIDs, and additional track metadata.
- Works with any `http.Client`, so you can inject mocks in tests or add logging/middleware.

## Installation

```bash
dart pub add listenbrainz
```

This package targets Dart ^3.0. See `pubspec.yaml` for the exact SDK constraints.

## Quick start

```dart
import 'package:listenbrainz/listenbrainz.dart';

final lb = ListenBrainz((
  token: '<your-user-token>',
  listenBrainzServerUrl: 'https://api.listenbrainz.org',
  musicBrainzServerUrl: 'https://musicbrainz.org',
  appClientName: 'my-app',
  appClientVersion: '1.0.0',
  appDeveloperContact: 'me@example.com',
  client: null, // optional custom http.Client
  rateLimiter: null // pass a RateLimiter instance in case of dealing with multiple ListenBrainz instances.
));

Future<void> main() async {
  final recent = await lb.core.userListens('wezenCM', 5);
  print('Fetched ${recent.count} listens');

  await lb.core.submitSingleListen(
    SubmissionListen(
      listenedAt: 1764347341, 
      trackMetadata: TrackMetadata(
        artistName: 'BROODS', 
        trackName: 'Four Walls',
        releaseName: 'Evergreen',
        additionalInfo: AdditionalInfo(
          artistMbids: [
            UuidString('68205c8f-9518-4b49-8df7-bd297da67599'),
          ],
          releaseMbid: UuidString('fd381aa1-65ed-4af2-8f58-40ddf6bfe2dd'),
          recordingMbid: UuidString('a1f5b352-4070-4fa2-ab9c-faf75a77c6d5'),
          tags: ['eletronic', 'indie pop', 'alternative'],
          mediaPlayer: 'My Awesome Music App',
          mediaPlayerVersion: '1.0.0',
          durationMs: 208000,
        )
      ),
    );
  );

  final playlists = await lb.playlist.getPlaylists('wezenCM');
  print('Found ${playlists.playlists.length} playlists');
}
```

All endpoints honor the provided token. Some read-only calls can omit the token, but
submissions and private playlist operations still require it.

## Usage guide

### Core API helpers

- `searchUser(query)` – fuzzy username search.
- `userListens(user, count)` – fetch listens with fully typed payloads.
- `submitSingleListen` / `setPlayingNow` / `importListens` – send listens in the correct
  format and surface backend failures as `ApiException`.
- `similarUsers(user)` and `similarTo(userA, userB)` – retrieve similarity between two users.

Explore `lib/components/core.dart` or `test/core_unit_test.dart` for additional calls like
`lb.radioTags`, `recordingsFromRecordingMsids`, etc.

### Playlist manager

```dart
final playlistId = UuidString('11111111-1111-1111-1111-111111111111');
final playlist = await lb.playlist.getByMbid(playlistId, true);

await lb.playlist.deleteRecording(playlist.identifier, 0, 1);
```

Builders in `lib/types/playlists.dart` help construct JSPF payloads without manually
crafting JSON.

### Rate limiting & HTTP customization

All components share a `RateLimiter` instance so bursts of API calls automatically wait
instead of being rejected. Pass a custom `http.Client` in `InitParams.client` to use
retries, caching, interceptors, or `MockClient` in tests.

## Development

- Run the test suite: `dart test`
- Format code: `dart format .`
- Lints are configured via `analysis_options.yaml`

Consider reading `CODE_QUALITY_ANALYSIS.md` for current architectural notes.

## Contributing

Issues and PRs are welcome. Please open bugs or feature requests in this repository,
include reproductions where possible, and add tests for new behavior. For API behavior
questions, refer to the official [ListenBrainz API docs](https://listenbrainz.readthedocs.io/).
