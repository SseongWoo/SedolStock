import 'package:intl/intl.dart';
///////////////////////////
// 날짜 형식을 변환하는 함수들 //
///////////////////////////

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('y년 M월 d일 H시 m분');
  return formatter.format(dateTime);
}

String formatDateString(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);

  // 분이 0이 아닐경우 한시간 올림
  if (dateTime.minute > 0) {
    dateTime = dateTime.add(const Duration(hours: 1));
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, 0, 0);
  }

  DateFormat formatter = DateFormat('MM월 dd일 HH시 mm분');
  return formatter.format(dateTime);
}

String formatDateString2(String dateString) {
  try {
    dateString = dateString.replaceAll('오전', 'AM').replaceAll('오후', 'PM');
    // '오전/오후'를 포함한 한국어 날짜 파싱
    DateTime dateTime = DateFormat('yyyy. M. d. a h:mm:ss', 'en_US').parse(dateString);

    // 원하는 형식으로 변환하여 반환
    return DateFormat('MM.dd HH:mm:ss').format(dateTime);
  } catch (e) {
    return "00-00-00 00:00:00"; // 오류 발생 시 기본값 반환
  }
}

String formatDateString3(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);

  DateFormat formatter = DateFormat('MM월 dd일');
  return formatter.format(dateTime);
}

String formatDateString4(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  return '${dateTime.year}년 ${dateTime.month.toString().padLeft(2, '0')}월 ${dateTime.day.toString().padLeft(2, '0')}일';
}
