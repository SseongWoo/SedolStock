import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart' as korean_filter;
import 'package:profanity_filter/profanity_filter.dart' as english_filter;
import 'package:stockpj/model/sign/signup_model.dart';
import 'package:stockpj/widget/simple_widget.dart';
import '../../constants/route_constants.dart';
import '../../constants/data_constants.dart';
import '../../main.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';
import '../../utils/search_name.dart';

// 회원가입 2단계 뷰 모델
class SignupViewModel extends GetxController {
  final SignupModel signupModel = SignupModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerID = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerPasswordCheck = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final enFilter = english_filter.ProfanityFilter(); // 비속어 감지 필터
  bool overlapName = true; // 설정할 이름이 이미 존재하는지 확인하는 변수
  late bool email; // 이메일
  late String idLabel; // 텍스트필드 이메일,아이디 선택 문장
  RxString labelText = ''.obs; // 팬덤
  RxInt listIndex = 0.obs; // 팬덤
  Color labelColor = Colors.black; // 팬덤
  RxBool visPW = true.obs; // 비밀번호 표시
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    email = Get.arguments;
    idLabel = email ? '이메일' : '게스트';
    labelText.value = fanNameList[listIndex.value];
  }

  int? lengthID() {
    return email ? null : 20;
  }

  // 아이디 유효성 검사
  String? validateId(String? value) {
    if (value == null || value.isEmpty) {
      return '값을 입력해 주세요';
    }
    if (value.length < 5) {
      return '5글자 이상 입력해 주세요';
    }
    if (!email && RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(value)) {
      return '아이디에 특수 문자는 사용할 수 없습니다.';
    }
    if (email) {
      // @와 .을 반드시 포함해야 하고, 나머지 특수문자는 허용되지 않음
      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
        return '이메일 형식이 아닙니다.';
      }
      // 이메일에 허용되지 않는 특수문자가 포함되어 있으면 에러 반환
      if (RegExp(r'[!#$%^&*(),?":{}|<>~`+=_]').hasMatch(value)) {
        return '이메일에 허용되지 않는 특수문자가 포함되어 있습니다.';
      }
    }
    return null;
  }

  // 비밀번호 유효성 검사
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해 주세요';
    }
    if (value.length < 6) {
      return '비밀번호를 여섯글자 이상 입력해 주세요';
    }
    if (value.trim() != controllerPasswordCheck.text.trim()) {
      return '비밀번호가 동일하지 않습니다.';
    }
    return null;
  }

  // 비밀번호 유효성 검사
  String? validatePasswordCheck(String? value) {
    if (value == null || value.isEmpty) {
      return '값을 입력해 주세요';
    }
    if (value.length < 5) {
      return '5글자 이상 입력해 주세요';
    }
    return null; // 유효한 경우 null을 반환
  }

  // 이름 유효성 검사
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력해주세요';
    }
    if (value.containsBadWords || enFilter.hasProfanity(value)) {
      return '부적절한 언어 사용은 허용되지 않습니다. 다시 입력해 주세요.';
    }
    if (overlapName) {
      return '해당 이름은 사용할 수 없습니다. 다른 이름을 입력해 주세요.';
    }
    return null;
  }

  // 팬덤 위젯 왼쪽버튼 클릭
  void onPressedLeft() {
    if (listIndex > 0) {
      listIndex.value--;
    } else {
      listIndex.value = fanNameList.length - 1;
    }
    labelColor = fanColorMap[fanNameList[listIndex.value]]!;
    labelText.value = fanNameList[listIndex.value];
  }

  // 팬덤 위젯 오른쪽 버튼 클릭
  void onPressedRight() {
    if (listIndex < fanNameList.length - 1) {
      listIndex.value++;
    } else {
      listIndex.value = 0;
    }
    labelColor = fanColorMap[fanNameList[listIndex.value]]!;
    labelText.value = fanNameList[listIndex.value];
  }

  // 이메일 계정일경우 이메일 확인 페이지로 이동
  void goCheckEmail() {
    Get.offAllNamed(AppRoute.signupCheckEmail,
        arguments: {'id': controllerID.text, 'pw': controllerPassword.text});
  }

  // 로그인 화면으로 이동
  void goSignin() {
    Get.offAllNamed(AppRoute.signin);
  }

  // 회원가입 시작
  void signup() async {
    EasyLoading.show();
    try {
      overlapName = await searchName(controllerName.text);
      if (!formKey.currentState!.validate()) return;
      final id = _processId(controllerID.text);
      final password = controllerPassword.text;
      if (!await _validateNameAndSignup(id, password)) return;

      if (email) {
        await _handleEmailUserSignup(id, password);
      } else {
        showSimpleSnackbar('회원가입 완료', '회원가입이 완료되었습니다. 환영합니다!', SnackPosition.TOP, Colors.black);
        goSignin();
      }
    } catch (e) {
      _showErrorSnackbar('회원가입 오류', '알 수 없는 오류가 발생했습니다. 다시 시도해 주세요.');
      logger.e(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  // 닉네임 중복 확인, 유저 데이터 DB에 등록 작업
  Future<bool> _validateNameAndSignup(String id, String password) async {
    final checkSignup = await signupModel.signup(id, password);
    if (!checkSignup) {
      _clearSignupFields();
      _showErrorSnackbar('회원가입 오류', '회원가입에 실패했습니다. 다시 시도해 주세요.');
      return false;
    }

    final checkSignupUserData = await signupModel.signupUserData(
        controllerID.text, controllerName.text, fanNameList[listIndex.value]);
    if (!checkSignupUserData) {
      _clearSignupFields();
      _showErrorSnackbar('회원가입 오류', '추가 데이터를 저장하는 중 오류가 발생했습니다.');
      return false;
    }

    signupModel.saveUserData();
    return true;
  }

  // 이메일 전송 작업
  Future<void> _handleEmailUserSignup(String id, String password) async {
    final sendEmail = await signupModel.sendEmail(id, password);
    if (sendEmail) {
      goCheckEmail();
    } else {
      _showErrorSnackbar('회원가입 오류', '이메일 전송에 실패했습니다. 다시 시도해 주세요.');
    }
  }

  String _processId(String rawId) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>~`+=_-]').hasMatch(rawId) ? rawId : '$rawId@guest.login';
  }

  void _showErrorSnackbar(String title, String message) {
    showSimpleSnackbar(title, message, SnackPosition.TOP, Colors.red);
  }

  // 텍스트 필드 정리
  void _clearSignupFields() {
    controllerID.clear();
    controllerPassword.clear();
    controllerPasswordCheck.clear();
    signupModel.deleteUser();
  }

  // 비밀번호 표현 유무
  void changeVisPW() {
    visPW.value = !visPW.value;
  }
}
