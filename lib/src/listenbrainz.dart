import 'package:http/http.dart' as http;

import 'package:listenbrainz/components/auxiliar.dart';
import 'package:listenbrainz/components/core.dart';
import 'package:listenbrainz/components/playlists.dart';
import 'package:listenbrainz/types/instance_init.dart';
import 'package:listenbrainz/utils/rate_limiter.dart';


class ListenBrainz {
  final RateLimiter _limiter = RateLimiter();
  final InitParams params;
  final http.Client _client;
  
  ListenBrainz(this.params)
    : _client = params.client ?? http.Client();

  late final core = Core(params, _limiter, _client);
  late final playlists = PlaylistManager(params, _limiter, _client);
  late final aux = Aux(params, _limiter, _client);
}
