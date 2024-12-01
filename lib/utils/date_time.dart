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

  DateFormat formatter = DateFormat('MM월 dd일 hh시 mm분');
  return formatter.format(dateTime);
}

String formatDateString2(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);

  DateFormat formatter = DateFormat('MM.dd hh:mm');
  return formatter.format(dateTime);
}

String formatDateString3(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);

  DateFormat formatter = DateFormat('MM월 dd일');
  return formatter.format(dateTime);
}

String formatDateString4(String isoString) {
  List<String> parts = isoString.split('-');
  String formattedDate = "${parts[0]}년 ${parts[1]}월 ${parts[2]}일";

  return formattedDate;
}
