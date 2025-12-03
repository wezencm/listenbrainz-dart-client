
import 'package:listenbrainz/listenbrainz.dart';

Future<void> main() async {
  final InitParams params = (
    token: 'token',
    listenBrainzServerUrl: 'http://api.listenbrainz.org',
    musicBrainzServerUrl: 'http://musicbrainz.org',
    appClientName: 'my-awesome-music-app',
    appClientVersion: '1.0.0',
    appDeveloperContact: 'dev@example.com',
    client: null,
    rateLimiter: null,
  );
  
  final lb = ListenBrainz(params);

  final listen = SubmissionListen(
    trackMetadata: TrackMetadata(artistName: 'artistName', trackName: 'trackName')
  );


  // once user starts listening a song we send the playing now Listen.
  lb.core.setPlayingNow(listen);

  // we set the timestamp for when user started the listening
  listen.listenedAt = DateTime.now().millisecondsSinceEpoch;

  // once the user pass the threshold we send the listen
  final submissionSuccess = await lb.core.submitSingleListen(listen);

  if (submissionSuccess) {
    print('${listen.trackMetadata.artistName} - ${listen.trackMetadata.trackName} submitted to ListenBrainz');
  }


  // now we are submiting the listens that for some reason
  // was not submitted when user was activelly using the app. 
  final List<SubmissionListen> oldListens = [];

  final oldListen1 = SubmissionListen(
    listenedAt: 1764683590,
    trackMetadata: TrackMetadata(
      artistName: 'Röyksopp', 
      trackName: 'In the End',
      additionalInfo: AdditionalInfo(
        artistMbids: [
          UuidString('1c70a3fc-fa3c-4be1-8b55-c3192db8a884'),
          UuidString('eb7657e8-71bb-43d5-b2d5-a9be8f8f8db3'),
          UuidString('f3f9e76a-0685-4a9a-97d1-6fa2b50f9fba'),
        ],
        recordingMbid: UuidString('12768a2b-f130-4a6b-9aca-df246e8f2dc8'),
        mediaPlayer: 'my-awesome-music-app',
        mediaPlayerVersion: '1.0.0',
        tags: ['synth-pop']
      )
    ),
  );

  oldListens.add(oldListen1);

  final notSubmitted = await lb.core.importListens(oldListens);

  if (notSubmitted.isEmpty) {
    print('All listens were synced with listenbrainz');
  }
}
