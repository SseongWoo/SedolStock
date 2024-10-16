import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('y년 M월 d일 H시 m분');
  return formatter.format(dateTime);
}
