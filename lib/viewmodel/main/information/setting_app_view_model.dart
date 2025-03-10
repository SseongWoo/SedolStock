import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import 'package:stockpj/utils/restart.dart';
import '../../../constants/route_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/start_data.dart';
import '../../../main.dart';
import '../../../model/main/information_model.dart';
import '../../../utils/audio.dart';
import '../../../utils/change_fandom.dart';
import '../../../utils/format.dart';
import '../../../utils/logout.dart';
import '../../../utils/screen_size.dart';
import '../../../utils/search_name.dart';
import '../../../widget/simple_widget.dart';
import '../../../utils/timer.dart';
import '../../../view/main/information/setting_widget.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart' as korean_filter;
import 'package:profanity_filter/profanity_filter.dart' as english_filter;

// 설정 화면 뷰모델
class SettingAppViewModel extends GetxController {
  final InformationModel _informationModel = InformationModel();
  final TimerController _timerController = Get.find<TimerController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  final ScreenController screenController = Get.find<ScreenController>();
  //final AudioController audioController = Get.find<AudioController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final TextEditingController controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filter = english_filter.ProfanityFilter(); // 비속어 감지 필터
  bool overlapName = true;

  void goInformation() {
    Get.offAllNamed(AppRoute.home, arguments: 4);
  }

// 데이터 수동 새로 고침
  void tryGetData() async {
    if (_publicDataController.manualRefresh > 5) {
      showSimpleDialog(Get.back, '데이터 갱신 실패', '새로고침 한도를 초과했습니다. 잠시 후 다시 시도해주세요.');
    } else if (_timerController.checkDataTime.value) {
      showSimpleDialog(Get.back, '데이터 갱신 실패', '현재 서버에서 데이터를 갱신 중입니다. 갱신 완료 후 다시 이용해 주세요.');
    } else {
      EasyLoading.show(status: '데이터 불러오는중');
      await startGetData();
      EasyLoading.dismiss();
      _publicDataController.manualRefresh++;
      showSimpleSnackbar(
          '데이터 수동 갱신 성공', '데이터 갱신이 완료되었습니다. 최신 정보로 업데이트되었습니다!', SnackPosition.TOP, Colors.black);
    }
  }

  // 회원 탈퇴
  void goDeleteAccount() {
    Get.toNamed(AppRoute.deleteAccount);
  }

  // 이름 변경 기능
  void nameChange() async {
    EasyLoading.show(status: '중복 검사중');
    overlapName = await searchName(controllerName.text);
    if (formKey.currentState!.validate()) {
      bool chaekUpdateName = await _informationModel.updateName(
          myDataController.myUid.value, myDataController.myName.value, controllerName.text);
      if (chaekUpdateName) {
        myDataController.myName.value = controllerName.text;
        Get.back();
        showSimpleSnackbar('변경 완료', '닉네임 변경이 완료되었습니다', SnackPosition.TOP, Colors.black);
      } else {
        showSimpleSnackbar('변경 실패', '닉네임 변경에 실패하였습니다\n다시 시도해 주세요', SnackPosition.TOP, Colors.black);
        logger.e('updateUserName error');
      }
    }
    controllerName.clear();
    EasyLoading.dismiss();
  }

  // 이름 변경 다이얼로그 호출
  void nameChangeDialog() {
    Get.dialog(
      NameChangeDialog(viewModel: this),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요';
    }
    if (value.containsBadWords || filter.hasProfanity(value)) {
      controllerName.clear();
      return '부적절한 언어 사용은 허용되지 않습니다.';
    }
    if (overlapName) {
      controllerName.clear();
      return '해당 이름은 사용할 수 없습니다. 다른 이름을 입력해 주세요.';
    }
    return null;
  }

  // 팬덤 변경 다이어로그 호출
  void changeFandomDialog() {
    Get.dialog(
      FandomChangeDialog(
        screenSize: screenController.screenSize.value,
        myDataController: myDataController,
      ),
    );
  }

  // 로그아웃 기능
  void logout() {
    logOut();
    Get.back();
  }

  // 로그아웃 다이얼로그 호출
  void logoutDialog() {
    showSimpleDialog3(screenController.screenSize.value, '로그아웃', '로그아웃하시겠습니까?', '로그아웃', logout);
  }

  // 비밀번호 변경 이메일 발송
  Future<void> sendPasswordResetEmail() async {
    final email = myDataController.myId.value;

    if (!email.contains('@') || !email.contains('.') || email.contains('guest')) {
      showSimpleDialog(Get.back, '계정 오류', '현재 사용 중인 계정은 게스트 계정입니다.\n이 기능을 사용하려면 이메일 계정을 생성해 주세요.');
      return;
    }

    EasyLoading.show(status: '이메일 전송 중');
    final bool emailSent = await _informationModel.changePW(email);
    EasyLoading.dismiss();

    if (emailSent) {
      showSimpleDialog2(screenController.screenSize.value, '비밀번호 변경',
          '비밀번호 변경 안내 이메일이 아래 주소로 발송되었습니다.\n\n$email', Get.back, true);
    } else {
      showSimpleDialog(Get.back, '오류', '이메일 전송에 실패했습니다.\n다시 시도해 주세요.');
    }
  }

  // 해상도 변경 다이얼로그 호출
  void windowsSizeDialog() {
    Get.dialog(
      WindowsSizeDialog(
        screenController: screenController,
      ),
    );
  }

  // 앱 버전 확인 다이얼로그 호출
  void showAppVersion() {
    showSimpleDialog2(screenController.screenSize.value, '앱 버전',
        _publicDataController.appVersion.value, Get.back, true);
  }

  // 라이선스 페이지 이동
  void showLicenses(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: '세돌스탁',
      applicationVersion: '${_publicDataController.appVersion}',
      applicationIcon: SizedBox(
        height: screenController.screenSize.value.getWidthPerSize(50),
        width: screenController.screenSize.value.getWidthPerSize(50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/image/image_logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void tryRestart() {
    restartDialog(screenController.screenSize.value, myDataController.myUid.value,
        myDataController.myLevel.value);
  }
}
