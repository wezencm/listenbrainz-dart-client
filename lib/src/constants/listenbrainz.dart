// ignore_for_file: constant_identifier_names

class ListenBrainzConstants {
  static const int MAX_LISTEN_PAYLOAD_SIZE = 10240000;
  static const int MAX_LISTEN_SIZE = 10240;
  static const int MAX_DURATION_LIMIT = 2073600;
  static const int MAX_DURATION_MS_LIMIT = 2073600000;
  static const int MAX_LISTENS_PER_REQUEST = 1000;
  static const int MAX_ITEMS_PER_GET = 1000;
  static const int DEFAULT_ITEMS_PER_GET = 25;
  static const int MAX_TAGS_PER_LISTEN = 50;
  static const int MAX_TAG_SIZE = 64;
  static const int LISTEN_MINIMUM_TS = 1033430400;
  
  // these constants are cited on docs but its values can be found only on source code.
  
  // https://github.com/metabrainz/listenbrainz-server/blob/e1e024186e4414fd471b86bc84a8333fcbe5e46e/listenbrainz/webserver/views/api.py#L32
  // https://github.com/metabrainz/listenbrainz-server/blob/e1e024186e4414fd471b86bc84a8333fcbe5e46e/listenbrainz/webserver/views/playlist_api.py#L34
  static const int DEFAULT_NUMBER_OF_PLAYLISTS_PER_CALL = 25;

  // https://github.com/metabrainz/listenbrainz-server/blob/e1e024186e4414fd471b86bc84a8333fcbe5e46e/listenbrainz/webserver/views/playlist_api.py#L33
  static const int MAX_RECORDINGS_PER_ADD = 100;
}
