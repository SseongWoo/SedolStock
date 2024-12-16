import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stockpj/main.dart';

// 오디오 재생 관련 함수
class AudioController extends GetxController {
  late AudioPlayer _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  Future<void> playSound(String filePath) async {
    try {
      await _audioPlayer.setAsset(filePath);
      await _audioPlayer.play();
    } catch (e) {
      logger.e('playSound error : $e');
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
