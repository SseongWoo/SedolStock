import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'home/home_screen.dart';

class MainController extends GetxController {
  // 현재 선택된 탭 인덱스
  var selectedIndex = 0.obs;

  // 선택된 탭에 맞는 페이지 가져오기
  final List<Widget> pages = [
    HomeScreen(),
    const Center(child: Text('거래')),
    const Center(child: Text('랭킹')),
    const Center(child: Text('내정보')),
    const Center(child: Text('설정')),
  ];

  // 인덱스 변경 함수
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

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

  void _startTimer() {
    _scheduleNextRun();
  }

  void _scheduleNextRun() {
    final now = DateTime.now();
    final nextRunMinute = ((now.minute ~/ 5) + 1) * 5;

    // 다음 실행 시간을 계산 (현재 시각에서 다음 5분 배수로)
    final nextRunTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      nextRunMinute % 60,
    );

    Duration delay = nextRunTime.difference(now);
    secondsRemaining.value = delay.inSeconds; // 남은 시간을 초 단위로 저장

    _startCountdown(); // 남은 시간 카운트다운 시작
  }

  void _startCountdown() {
    _countdownTimer?.cancel(); // 기존 카운트다운 타이머가 있으면 취소
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining.value--; // 남은 시간을 1초씩 줄임
        _updateTimeDisplay(); // "분:초" 형식으로 업데이트
      } else {
        timer.cancel(); // 시간이 끝나면 타이머 종료
        _executeTask(); // 5분이 다 되면 실행할 작업
      }
    });
  }

  void _executeTask() {
    currentTime.value = '5분 단위로 실행됨: ${DateTime.now()}';
    print(currentTime.value);

    // 다음 5분 주기로 타이머 다시 시작
    _scheduleNextRun();
  }

  void _updateTimeDisplay() {
    int minutes = secondsRemaining.value ~/ 60;
    int seconds = secondsRemaining.value % 60;
    timeDisplay.value =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _countdownTimer?.cancel(); // 카운트다운 타이머도 취소
    super.onClose();
  }
}
