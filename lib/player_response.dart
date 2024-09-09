library player_response;

import 'package:dio/dio.dart';
import './const.dart';

class PlayerResponse {
  final bool playable;
  final List<Audio> audioFormats;
  PlayerResponse({required this.playable, required this.audioFormats});

  static Future<PlayerResponse?> fetch(String videoId) async {
    body['videoId'] = videoId;
    try {
      final response = (await Dio().post(url,
          options: Options(
            headers: headers,
          ),
          data: body));
      if (response.statusCode == 200) {
        return PlayerResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  factory PlayerResponse.fromJson(json) {
    final isplayable = json["playabilityStatus"]["status"] == "OK";
    //if not plablable no need to proceed further
    if (!isplayable) return PlayerResponse(playable: false, audioFormats: []);

    final availableAudioFormats =
        (json["streamingData"]["adaptiveFormats"] as List)
            .where((item) => item['mimeType'].contains("audio"));
    return PlayerResponse(
        playable: isplayable,
        audioFormats:
            availableAudioFormats.map((item) => Audio.fromJson(item)).toList());
  }

  Audio get highestBitrateAudio => sortByBitrate[0];

  Audio get highestQualityAudio =>
      audioFormats.lastWhere((item) => item.itag == 251 || item.itag == 140);

  Audio get highestBitrateMp4aAudio =>
      audioFormats.lastWhere((item) => item.itag == 140 || item.itag == 139);

  Audio get highestBitrateOpusAudio =>
      audioFormats.lastWhere((item) => item.itag == 251 || item.itag == 250);

  Audio get lowQualityAudio =>
      audioFormats.lastWhere((item) => item.itag == 249 || item.itag == 139);

  List<Audio> get sortByBitrate {
    final audioFormatsCopy = audioFormats.toList();
    audioFormatsCopy
        .sort((audio1, audio2) => audio1.bitrate.compareTo(audio2.bitrate));
    return audioFormatsCopy;
  }

  List<dynamic> get hmStreamingData {
    if (!playable) return [false, null, null];
    return [
      true,
      lowQualityAudio.toJson(),
      highestQualityAudio.toJson(),
    ];
  }
}

class Audio {
  final int itag;
  final Codec audioCodec;
  final int bitrate;
  final int duration;
  final double loudnessDb;
  final String url;
  Audio(
      {required this.itag,
      required this.audioCodec,
      required this.bitrate,
      required this.duration,
      required this.loudnessDb,
      required this.url});

  factory Audio.fromJson(json) => Audio(
      audioCodec: (json["mimeType"] as String).contains("mp4a")
          ? Codec.mp4a
          : Codec.opus,
      itag: json['itag'],
      duration: int.parse(json["approxDurationMs"]),
      bitrate: json["bitrate"],
      loudnessDb: (json['loudnessDb']).toDouble(),
      url: json['url']);

  Map<String, dynamic> toJson() => {
        "itag": itag,
        "audioCodec": audioCodec.toString(),
        "bitrate": bitrate,
        "loudnessDb": loudnessDb,
        "url": url,
        "approxDurationMs": duration
      };
}

enum Codec { mp4a, opus }
