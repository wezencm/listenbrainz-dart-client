import 'package:json_annotation/json_annotation.dart';
import 'package:listenbrainz/src/constants/listenbrainz.dart';
import 'package:listenbrainz/types/types.dart';

part 'additional_info.g.dart';

@UuidConverter()
@JsonSerializable()
class AdditionalInfo {
  /// A list of MusicBrainz Artist IDs, one or more Artist IDs may be included here.
  /// If you have a complete MusicBrainz artist credit that contains multiple Artist IDs, include them all in this list.
  List<UuidString>? artistMbids;

  /// A MusicBrainz [Release Group](https://musicbrainz.org/doc/Release_Group) ID of the release group this recording was played from.
  UuidString? releaseGroupMbid;

  /// A MusicBrainz [Release](https://musicbrainz.org/doc/Release) ID of the release this recording was played from.
  UuidString? releaseMbid;

  /// A MusicBrainz [Recording](https://musicbrainz.org/doc/Recording) ID of the recording that was played.
  UuidString? recordingMbid;

  /// A MusicBrainz [Track](https://musicbrainz.org/doc/Track) ID associated with the recording that was played.
  UuidString? trackMbid;

  /// A list of MusicBrainz [Work](https://musicbrainz.org/doc/Work) IDs that may be associated with this recording.
  List<UuidString>? workMbids;

  /// The tracknumber of the recording. This first recording on a release is tracknumber 1.
  String? tracknumber;

  /// The [ISRC](https://musicbrainz.org/doc/ISRC) code associated with the recording.
  String? isrc;

  /// The Spotify track URL associated with this recording.
  /// e.g.: http://open.spotify.com/track/1rrgWMXGCGHru5bIRxGFV0
  String? spotifyId;

  /// A list of user-defined folksonomy tags to be associated with this recording.
  /// For example, you can apply tags such as punk, see-live, smelly.
  /// You may submit up to [ListenBrainzConstants.MAX_TAGS_PER_LISTEN] tags and each tag may be up to [ListenBrainzConstants.MAX_TAG_SIZE] characters large.
  List<String>? tags;

  /// The name of the program being used to listen to music. Don’t include a version number here.
  String? mediaPlayer;

  /// The version of the program being used to listen to music.
  String? mediaPlayerVersion;

  /// The name of the client that is being used to submit listens to ListenBrainz.
  /// If the media player has the ability to submit listens built-in then this value may be the same as mediaPlayer.
  /// Don’t include a version number here.
  String? submissionClient;

  /// The version of the submission client.
  String? submissionClientVersion;

  /// If the song being listened to comes from an online service, the canonical domain of this service.
  String? musicService;

  /// If the song being listened to comes from an online service and you don’t know the canonical domain,
  /// a name that represents the service.
  String? musicServiceName;

  /// If the song of this listen comes from an online source, the URL to the place where it is available.
  /// This could be a Spotify URL (see [spotifyId]), a YouTube video URL, a Soundcloud recording page URL,
  /// or the full URL to a public MP3 file. If there is a webpage for this song (e.g. Youtube page, Soundcloud page)
  /// do not try and resolve the URL to an actual audio resource.
  String? originUrl;

  /// The duration of the track in milliseconds.
  int? durationMs;

  /// The duration of the track in seconds.
  int? duration;

  /// When ListenBrainz receives a [SubmissionListen] withou enough
  /// information to link the recording to a MBID, it links to a [MessyBrainz id](https://community.metabrainz.org/t/where-does-messybrainz-data-come-from/580232/2)
  /// This field should not be sent in a SubmissionListen.
  UuidString? recordingMsid;

  AdditionalInfo({
    this.artistMbids,
    this.releaseGroupMbid,
    this.releaseMbid,
    this.recordingMbid,
    this.trackMbid,
    this.workMbids,
    this.tracknumber,
    this.isrc,
    this.spotifyId,
    this.tags,
    this.mediaPlayer,
    this.mediaPlayerVersion,
    this.submissionClient,
    this.submissionClientVersion,
    this.musicService,
    this.musicServiceName,
    this.originUrl,
    this.durationMs,
    this.duration,
  });


  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => 
    _$AdditionalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);

}
