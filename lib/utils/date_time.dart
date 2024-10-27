import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('y년 M월 d일 H시 m분');
  return formatter.format(dateTime);
}

String formatDateString(String isoString) {
  // ISO 형식의 문자열을 DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(isoString);

  // 원하는 형식으로 변환 (MM월 DD일 hh시 mm분)
  DateFormat formatter = DateFormat('MM월 dd일 hh시 mm분');
  return formatter.format(dateTime);
}

String formatDateString2(String isoString) {
  // ISO 형식의 문자열을 DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(isoString);

  // 원하는 형식으로 변환 (MM월 DD일 hh시 mm분)
  DateFormat formatter = DateFormat('MM.dd hh:mm');
  return formatter.format(dateTime);
}

String formatDateString3(String isoString) {
  // ISO 형식의 문자열을 DateTime 객체로 변환
  DateTime dateTime = DateTime.parse(isoString);

  // 원하는 형식으로 변환 (MM월 DD일 hh시 mm분)
  DateFormat formatter = DateFormat('MM월 dd일');
  return formatter.format(dateTime);
}
