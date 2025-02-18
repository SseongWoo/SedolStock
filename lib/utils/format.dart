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

String formatValue(double value) {
  String formatNumber(double num) {
    // 소수점이 0이면 정수로, 아니면 소수점 포함
    return num % 1 == 0 ? num.toStringAsFixed(0) : num.toStringAsFixed(1);
  }

  if (value >= 1000000) {
    return '${formatNumber(value / 1000000)}m'; // 백만 단위
  } else if (value >= 1000) {
    return '${formatNumber(value / 1000)}k'; // 천 단위
  } else {
    return formatNumber(value); // 그대로 표시
  }
}

String formatVersion(String version) {
  RegExp regex = RegExp(r'\(([^)]+)\)');
  Match? match = regex.firstMatch(version);

  if (match != null) {
    return match.group(1)!;
  } else {
    return '0.0.0';
  }
}
