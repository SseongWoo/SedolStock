import 'package:intl/intl.dart';

// int 형식의 데이터를 통화 형식으로 변경해서 반환하는 함수
String formatToCurrency(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}

// 값을 올림하는 함수
double ceilToUnit(double value, double unit) {
  return (value / unit).ceil() * unit;
}

String truncateText(String text, int maxLength) {
  if (text.length > maxLength) {
    return '${text.substring(0, maxLength)}...';
  }
  return text;
}
