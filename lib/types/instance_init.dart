import 'package:http/http.dart' as http;
import 'package:listenbrainz/utils/rate_limiter.dart';

typedef InitParams = ({
  /// The user token https://listenbrainz.org/settings/
  String token,
  
  /// The URI of the ListenBrainz server instance.
  /// Normally https://api.listenbrainz.org if you arent using a custom build.
  String listenBrainzServerUrl,
  
  /// The URI of the MusicBrainz server instance.
  /// Normally https://musicbrainz.org if you arent using a custom build.
  String musicBrainzServerUrl,
  
  String appClientName,
  String appClientVersion,
  String appDeveloperContact,
  
  /// Optional shared [RateLimiter].
  ///
  /// By default each [ListenBrainz] instance creates its own internal limiter.
  /// If you construct multiple instances and want them to share rate limits
  /// (e.g. per process or per API token), create a single [RateLimiter]
  /// and pass it here.
  RateLimiter? rateLimiter,
  
  http.Client? client,
});