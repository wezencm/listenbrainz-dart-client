## 1.2.0

- Implements the Statistics endpoints.

- Fix a bug on the json converter that was generating wrong datetimes.

- The `Playlist` the now has a `duration` field.
- The `Playlist.releaseIdentifier` is now nullable.

## 1.1.1

- Fixed a bug on Aux.matchSongMusicBrainz() always returning `null`.

## 1.1.0

- Implements the Recordings endpoints.

- Change in architeture; for simplicity in code, fields that represent a time, will no receive a `int` time anymore, but a `DateTime` type, the lib will take care of conversion.


## 1.0.1

- Corrects the ListenBrainz constructor to accepts a RateLimiter instance.

## 1.0.0

- Initial version.
