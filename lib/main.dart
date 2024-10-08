import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/color.dart';
import 'login/login/login_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StockGame',
      theme: ThemeData(
        fontFamily: 'Gyeonggi',
        colorScheme: ColorScheme.fromSeed(seedColor: colorStelLive),
        useMaterial3: true,
      ),
      // 기본 경로 설정
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
      ],
    );
  }
}
