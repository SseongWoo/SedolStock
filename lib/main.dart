import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_system.dart';
import 'package:stockpj/splash/splash_screen.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/http_request.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/utils/timer.dart';
import 'data/public_data.dart';
import 'data/youtube_data.dart';
import 'login/login/login_screen.dart';
import 'login/login/login_system.dart';
import 'main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setURL();
  startController();
  runApp(const MyApp());
  configLoading();
}

void startController() {
  Get.put(ScreenController());
  Get.put(TimerController(), permanent: true);
  Get.put(YoutubeDataController());
  Get.put(MyDataController());
  Get.put(StockListController());
  Get.put(PublicDataController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'StockGame',
      theme: ThemeData(
        fontFamily: 'Gyeonggi',
        colorScheme: ColorScheme.fromSeed(seedColor: colorStelLive),
        useMaterial3: true,
      ),
      // 기본 경로 설정
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => MainScreen(),
          transition: Transition.noTransition,
          //transitionDuration: const Duration(seconds: 2),
        ),
      ],
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
