import 'package:listenbrainz/src/listenbrainz.dart';
import 'package:listenbrainz/types/feedback_score.dart';
import 'package:listenbrainz/types/recording_pin.dart';
import 'package:listenbrainz/types/types.dart';
import 'package:test/test.dart';

void main() {
  final listenbrainz = ListenBrainz(( 
    listenBrainzServerUrl: 'http://172.27.180.251:8100',
    token: 'bd330775-f7d0-4980-b9b1-7aad7fd7c833',

    //listenBrainzServerUrl: 'https://api.listenbrainz.org',
    //token: 'd046ff7d-72b5-4841-bd94-82c53a3475d8',

    musicBrainzServerUrl: 'https://musicbrainz.org',
    appClientName: 'ListenBrainz Dart Client',
    appClientVersion: '0.0.1',
    appDeveloperContact: 'https://github.com/wezencm/listenbrainz-dart-client',
    client: null,
    rateLimiter: null,
  ));

  final recordingMbid = UuidString('aa534844-00f1-46d5-a0ae-15917cdefbab');
  late String userName;

  setUp(() async {
    final res = await listenbrainz.core.validateToken();
    userName = res.userName ?? '';
  });
  group('Recordings feedback', () {
    test('Should love a recording', () async {
      final wasLoved = await listenbrainz.recordings.love(mbid: recordingMbid);
      expect(wasLoved, true);

      final loved = await listenbrainz.recordings.getUserFeedback(userName, mbids: [recordingMbid]);
      expect(loved.first.recordingMbid?.value, recordingMbid.value);
      expect(loved.first.score, FeedbackScore.love);

      /* final current = await listenbrainz.recordings.getCurrentPinForUser('wezenCM');
      expect(current?.recordingMbid, recordingMbid); */
    });

    test('Lists all feedbacks from user', () async {
      final feedbacks = await listenbrainz.recordings.getAllFeedbackFromUser(userName);
      final firstFeedback = feedbacks.feedback.first;
      expect(firstFeedback.recordingMbid?.value, recordingMbid.value);
      expect(firstFeedback.score, FeedbackScore.love);
    });

    test('Gets a feedback for a recording', () async {
      final feedbacks = await listenbrainz.recordings.getUserFeedback(userName, mbids: [recordingMbid]);
      final feedback = feedbacks.first;

      expect(feedback.recordingMbid?.value, recordingMbid.value);
      expect(feedback.userId, userName);
      expect(feedback.score, FeedbackScore.love);
    });


  });

  group('Recordings pins', () {
    test('Should pin a recording', () async {
      final RecordingPin pinData = RecordingPin(
        recordingMbid: recordingMbid,
        blurbContent: 'Recording pinned by api test', 
        pinnedUntil: DateTime.now().add(Duration(minutes: 1)),
      );
      final pinned = await listenbrainz.recordings.pin(pinData);
      expect(pinned.recordingMbid?.value, recordingMbid.value);

      final current = await listenbrainz.recordings.getCurrentPinForUser(userName);
      expect(current?.recordingMbid?.value, recordingMbid.value);
    });

    test('Should update a pin', () async {
      final active = await listenbrainz.recordings.getCurrentPinForUser(userName);
      await listenbrainz.recordings.updatePin(active!.rowId!, 'comment');
      final activeUpdated = await listenbrainz.recordings.getCurrentPinForUser(userName);

      expect(activeUpdated?.blurbContent, 'comment');
    });

    test('Should unpin', () async {
      await Future.delayed(Duration(seconds: 1));
      final deleted = await listenbrainz.recordings.unpin();
      expect(deleted, true);

      final current = await listenbrainz.recordings.getCurrentPinForUser(userName);
      expect(current, null);
    });

    test('Should delete a pin', () async {
      final allPins = await listenbrainz.recordings.getAllPinsOfUser(userName);
      final firstPin = allPins.pinnedRecordings.first;
      expect(firstPin.recordingMbid?.value, recordingMbid.value);

      final deleted = await listenbrainz.recordings.deletePin(firstPin.rowId!);
      expect(deleted, true);
    });

    test('getPinsFromFollowing returns a valid response', () async {
      final res = await listenbrainz.recordings.getPinsFromFollowing(userName);

      expect(res.pinnedRecordings.isEmpty, true);
    });

  });
}