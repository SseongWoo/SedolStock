import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/utils/check_list.dart';
import 'package:stockpj/utils/simple_widget.dart';

import '../data/start_data.dart';

class TimerController extends GetxController {
  Timer? _countdownTimer;
  RxInt secondsRemaining = 0.obs; // 총 남은 시간을 초 단위로 저장
  RxString timeDisplay = '00:00'.obs; // 남은 시간을 "분:초"로 저장
  RxString currentTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer(); // 타이머 시작
  }

  // 타이머 시작 함수
  void _startTimer() {
    _scheduleNextRun(); // 다음 실행 시간 예약
  }

  // 다음 실행 시간을 예약하는 함수
  void _scheduleNextRun() {
    final now = DateTime.now();
    int nextRunMinute = ((now.minute ~/ 5) + 1) * 5;

    // 60분을 넘는 경우 처리 (시(hour)를 올려주고, 분(minute)은 0으로 설정)
    int nextRunHour = now.hour;
    if (nextRunMinute >= 60) {
      nextRunMinute = 0;
      nextRunHour += 1;
      if (nextRunHour >= 24) {
        nextRunHour = 0; // 하루가 넘어가면 시간은 0으로 설정
      }
    }

    // 다음 실행 시간을 설정
    final nextRunTime = DateTime(now.year, now.month, now.day, nextRunHour, nextRunMinute, 30);

    // 현재 시각과 다음 실행 시간의 차이 계산
    Duration delay = nextRunTime.difference(now);
    secondsRemaining.value = delay.inSeconds; // 남은 시간을 초 단위로 저장

    // 카운트다운 시작
    _startCountdown();
  }

  // 카운트다운 시작 함수
  void _startCountdown() {
    _countdownTimer?.cancel(); // 기존 카운트다운 타이머가 있으면 취소

    // 매 1초마다 실행
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--; // 남은 시간을 1초씩 줄임
        _updateTimeDisplay(); // 남은 시간을 "분:초" 형식으로 업데이트
      } else {
        timer.cancel(); // 시간이 끝나면 타이머 종료
        secondsRemaining.value = 600;
        _executeTask(); // 5분이 다 되면 작업 실행
      }
    });
  }

  // 5분이 다 되면 실행되는 작업
  void _executeTask() async {
    currentTime.value = '5분 단위로 실행됨: ${DateTime.now()}';
    print(currentTime.value);
    _scheduleNextRun();

    if (Get.isRegistered<InformationController>()) {
      EasyLoading.show(status: '데이터 갱신중');
      bool serverState = await checkServer();
      if (serverState) {
        await startGetData();
        await reflashGetData(true);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        showSimpleDialog(closeApp, '서버 점검중', '서버 점검중입니다.\n앱을 종료합니다.');
      }
    }
  }

  void closeApp() {
    exit(0);
  }

  // 남은 시간을 "분:초" 형식으로 업데이트하는 함수
  void _updateTimeDisplay() {
    int minutes = secondsRemaining.value ~/ 60;
    int seconds = secondsRemaining.value % 60;
    timeDisplay.value =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _countdownTimer?.cancel(); // 카운트다운 타이머 취소
    super.onClose();
  }
}

class TimerWidget extends StatelessWidget {
  final TimerController _timerController = Get.find<TimerController>();
  TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        _timerController.timeDisplay.value,
        style: TextStyle(
            color: _timerController.secondsRemaining.value > 60 ? Colors.black : Colors.red),
      ),
    );
  }
}
