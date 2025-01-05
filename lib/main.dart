import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stockpj/utils/audio.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/get_env.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/utils/timer.dart';
import 'package:stockpj/view/main/information/delete_account_screen.dart';
import 'package:stockpj/view/main/information/setting_app_screen.dart';
import 'package:stockpj/view/main/main_screen.dart';
import 'package:stockpj/view/main/notification/notification_screen.dart';
import 'package:stockpj/view/main/trade/trade_dealing_screen.dart';
import 'package:stockpj/view/main/trade/trade_detail_screen.dart';
import 'package:stockpj/view/sign/find/find_account_screen.dart';
import 'package:stockpj/view/sign/signin/signin_screen.dart';
import 'package:stockpj/view/sign/signup/signup_checkemail_screen.dart';
import 'package:stockpj/view/sign/signup/signup_choice_screen.dart';
import 'package:stockpj/view/sign/signup/signup_screen.dart';
import 'package:stockpj/view/splash_screen.dart';
import 'constants/route_constants.dart';
import 'data/public_data.dart';
import 'data/youtube_data.dart';

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
  Get.put(YoutubeDataController());
  Get.put(MyDataController());
  Get.put(TimerController(), permanent: true);
  Get.put(PublicDataController());
  Get.put(AudioController());
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
      debugShowCheckedModeBanner: false,
      title: 'StockGame',
      theme: ThemeData(
        fontFamily: 'Maple',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // 기본 경로 설정
      initialRoute: AppRoute.splash,

      getPages: [
        GetPage(
          name: AppRoute.splash,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: AppRoute.signupChoice,
          page: () => SignupChoiceScreen(),
        ),
        GetPage(
          name: AppRoute.signupScreen,
          page: () => SignupScreen(),
        ),
        GetPage(
          name: AppRoute.signupCheckEmail,
          page: () => SignupCheckemailScreen(),
        ),
        GetPage(
          name: AppRoute.signin,
          page: () => SigninScreen(),
        ),
        GetPage(
          name: AppRoute.home,
          page: () => MainScreen(),
        ),
        GetPage(
          name: AppRoute.findPW,
          page: () => FindAccountScreen(),
        ),
        GetPage(
          name: AppRoute.tradeDetail,
          page: () => TradeDetailScreen(),
        ),
        GetPage(
          name: AppRoute.tradeDealing,
          page: () => TradeDealingScreen(),
        ),
        GetPage(
          name: AppRoute.notification,
          page: () => NotificationScreen(),
        ),
        GetPage(
          name: AppRoute.settingApp,
          page: () => SettingAppScreen(),
        ),
        GetPage(
          name: AppRoute.deleteAccount,
          page: () => DeleteAccountScreen(),
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
