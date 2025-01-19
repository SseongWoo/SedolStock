import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stockpj/main.dart';
import '../service/storage_service.dart';

// 오디오 재생 관련 함수
class AudioController extends GetxController {
  late AudioPlayer audioPlayer;
  RxBool onAudio = true.obs; // 오디오 사용 설정
  RxDouble audioVolume = 0.5.obs; // 오디오 볼륨

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    audioPlayer.setVolume(audioVolume.value);

    bool? onoffState = readData('onAudio');
    if (onoffState != null) {
      onAudio.value = onoffState;
    }
  }

  Future<void> playSound(String filePath) async {
    try {
      await audioPlayer.setAsset(filePath);
      await audioPlayer.play();
    } catch (e) {
      logger.e('playSound error : $e');
    }
  }

  Future<void> onoffAudio() async {
    onAudio.value = !onAudio.value;
    saveData('onAudio', onAudio.value);
  }

  Future<void> stopSound() async {
    await audioPlayer.stop();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
