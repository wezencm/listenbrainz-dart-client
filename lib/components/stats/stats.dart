import 'package:http/http.dart' as http;
import 'package:listenbrainz/components/stats/artist.dart';
import 'package:listenbrainz/components/stats/release_group.dart';
import 'package:listenbrainz/components/stats/sitewide.dart';
import 'package:listenbrainz/components/stats/user.dart';
import 'package:listenbrainz/listenbrainz.dart';

class Stats {
  final RateLimiter limiter;
  final InitParams params;
  final http.Client client;

  late final UserHandler user = UserHandler(this);
  late final ArtistHandler artist = ArtistHandler(this);
  late final ReleaseGroupHandler releaseGroup = ReleaseGroupHandler(this);
  late final SiteWide siteWide = SiteWide(this);

  Stats(this.params, this.limiter, this.client);

}
