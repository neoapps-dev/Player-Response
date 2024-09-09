final Map<String, String> headers = {
  'accept': '*/*',
  'content-type': 'application/json',
  'content-encoding': 'gzip',
  'origin': "https://music.youtube.com/",
};

final Map<String, dynamic> body = {
  "context": {
    "androidSdkVersion": 30,
    "client": {
      "clientName": "ANDROID_MUSIC",
      "clientVersion": "5.28.1",
      "hl": "en",
      "platform": "MOBILE",
      "visitorData": "CgttN24wcmd5UzNSWSi2lvq2BjIKCgJKUBIEGgAgYQ%3D%3D",
      "userAgent":
          "com.google.android.apps.youtube.music/5.28.1 (Linux; U; Android 11) gzip",
    }
  },
  "playlistId": null,
};

const kPart = "AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8";

const url = "https://music.youtube.com/youtubei/v1/player?key=$kPart";
