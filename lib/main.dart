import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stockpj/main/home/home_system.dart';
import 'package:stockpj/main/wallet/stocklist/stocklist_system.dart';
import 'package:stockpj/splash/splash_screen.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/get_env.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/utils/timer.dart';
import 'data/public_data.dart';
import 'data/youtube_data.dart';
import 'login/login/login_screen.dart';
import 'login/login/login_system.dart';
import 'login/signup/4_setdata/signup_setdata_screen.dart';
import 'main/main_screen.dart';
import 'main/trade/trade_system.dart';
import 'main/wallet/stockhistory/stockhistory_system.dart';

var logger = Logger(); // 로그를 나타내기 위한 변수

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 빌드 초기화
  // 가로화면 금지
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // FlutterError.onError = (FlutterErrorDetails details) {
  //   // 콘솔에 에러를 출력
  //   FlutterError.dumpErrorToConsole(details);
  //
  //   // 자세한 오류 정보 추출
  //   final String exception = details.exceptionAsString(); // 예외 메시지
  //   final String stackTrace = details.stack?.toString() ?? 'No stack trace available'; // 스택 트레이스
  //
  //   // GetX 다이얼로그로 에러 메시지 표시
  //   Get.defaultDialog(
  //     title: 'Error Occurred',
  //     content: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Exception:', style: TextStyle(fontWeight: FontWeight.bold)),
  //           Text(exception, style: TextStyle(color: Colors.red)),
  //           SizedBox(height: 10),
  //           Text('Stack Trace:', style: TextStyle(fontWeight: FontWeight.bold)),
  //           Text(
  //             stackTrace,
  //             style: TextStyle(fontSize: 12, color: Colors.black54),
  //           ),
  //         ],
  //       ),
  //     ),
  //     confirm: ElevatedButton(
  //       onPressed: () {
  //         Get.back(); // 다이얼로그 닫기
  //       },
  //       child: Text('OK'),
  //     ),
  //   );
  // };

  await dotenv.load(fileName: '.env'); // 환경변수 파일 로드
  setURL(); // 로드된 환경변수 데이터를 사용해서 주소 설정
  startController(); // 컨트롤러들 생성

  // // 비동기 에러 핸들링
  // runZonedGuarded(() {
  //   runApp(MyApp());
  // }, (error, stackTrace) {
  //   // 스낵바로 에러 표시
  //   Get.snackbar(
  //     'An Error Occurred',
  //     error.toString(),
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
  //     duration: Duration(seconds: 4),
  //   );
  // });

  logger.d("Logger is working!");

  runApp(const MyApp());
  configLoading();
}

// 컨트롤러들 생성 함수
void startController() {
  Get.put(ScreenController());
  Get.put(TimerController(), permanent: true);
  Get.put(YoutubeDataController());
  Get.put(MyDataController());
  Get.put(StockListController());
  Get.put(StockHistoryController());
  Get.put(PublicDataController());
  Get.put(TradeController());
  Get.put(HomeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return Center(
          child: Container(
            constraints: GetPlatform.isWeb
                ? BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.height > 750
                        ? MediaQuery.of(context).size.height * (10 / 16)
                        : 500,
                  )
                : null, // 화면 너비 제한
            child: child,
          ),
        );
      },
      //builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'StockGame',
      theme: ThemeData(
        fontFamily: 'Maple',
        colorScheme: ColorScheme.fromSeed(seedColor: colorISEGYEIDOL),
        useMaterial3: true,
      ),
      // 기본 경로 설정
      initialRoute: '/',

      getPages: [
        GetPage(
          name: '/test',
          page: () => const SignupSetprofileScreen(),
        ),
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
        ),
      ],
    );
  }
}

// easyloading 설정
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
