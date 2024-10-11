import 'package:flutter_test/flutter_test.dart';
import 'package:player_response/player_response.dart';

Future<void> main() async {
  test('Verify/Observe Player response', () async {
    final startTime = DateTime.now();
    final res = await PlayerResponse.fetch("HyHNuVaZJ-k", option: 1);
    final endTime = DateTime.now();
    final executionTime = endTime.difference(startTime);

    if (res != null) {
      print("Request time: ${executionTime.inMilliseconds}\n");
      print("Playable: ${res.playable}\n");
      for (Audio item in res.audioFormats) {
        print("${item.toJson()}\n");
      }
      print(res.hmStreamingData);
    }
    expect(res?.playable, true);
  });
}
