import 'package:intl/intl.dart';

String formatToCurrency(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}
