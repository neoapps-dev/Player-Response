final Map<String, String> headers = {
  'accept': '*/*',
  'content-type': 'application/json',
  'content-encoding': 'gzip',
  "Referer": "https://wwww.youtube.com/",
  'origin': "https://www.youtube.com/",
};

final ANDROID_CONTEXT = {
 'client': {
    'clientName': 'ANDROID_VR',
    'clientVersion': '1.56.21',
    'deviceModel': 'Quest 3',
    'androidSdkVersion': '32',
    'userAgent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36 Edg/105.0.1343.42',
    'hl': 'en',
    'timeZone': 'UTC',
    'playerType': 'UNIPLAYER',
    'utcOffsetMinutes': 0
  },
};

final IOS_CONTEXT = {
  'client': {
    'clientName': 'IOS',
    'clientVersion': '19.29.1',
    'deviceMake': 'Apple',
    'deviceModel': 'iPhone16,2',
    'hl': 'en',
    'osName': 'iPhone',
    'osVersion': '17.5.1.21F90',
    'timeZone': 'UTC',
    'userAgent':
        'com.google.ios.youtube/19.29.1 (iPhone16,2; U; CPU iOS 17_5_1 like Mac OS X;)',
    'utcOffsetMinutes': 0
  }
};

const kPartIOS = "AIzaSyB-63vPrdThhKuerbB2N_l7Kwwcxj6yUAc";
const kPartAndroid = "AIzaSyAOghZGza2MQSZkY_zfZ370N-PUdXEo8AI";
const allKeys = [kPartIOS, kPartAndroid];

String getUrl(int option) =>
    "https://www.youtube.com/youtubei/v1/player?key=${allKeys[option]}&prettyPrint=false";

Map<String, dynamic> getBody(int option) => {
      "context": option == 0 ? IOS_CONTEXT : ANDROID_CONTEXT,
    };
