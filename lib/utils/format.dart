import 'package:intl/intl.dart';

// int 형식의 데이터를 통화 형식으로 변경해서 반환하는 함수
String formatToCurrency(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}
