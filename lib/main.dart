import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stockpj/utils/audio.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/get_env.dart';
import 'package:stockpj/utils/screen_size.dart';
import 'package:stockpj/utils/timer.dart';
import 'package:stockpj/view/main/event/event_screen.dart';
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

  if (GetPlatform.isDesktop) {
    await DesktopWindow.setMinWindowSize(const Size(450, 800));
    await DesktopWindow.setMaxWindowSize(const Size(2160, 3840));
  }

  // 초기 창 크기를 FHD로 설정
  await _setResolution('FHD');

  await dotenv.load(fileName: '.env'); // 환경변수 파일 로드
  setURL(); // 로드된 환경변수 데이터를 사용해서 주소 설정
  startController(); // 컨트롤러들 생성

  logger.d("Logger is working!");

  runApp(MyApp());
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

// 해상도에 따른 창 크기 설정 함수
Future<void> _setResolution(String resolution) async {
  double aspectRatio = 19.5 / 9; // iPhone 15 비율
  Size size;

  switch (resolution) {
    case 'FHD': // 1080x1920 (iPhone 15 비율)
      size = Size(1080 / aspectRatio, 1080);
      break;
    case 'QHD': // 1440x2560 (iPhone 15 비율)
      size = Size(1440 / aspectRatio, 1440);
      break;
    case 'UHD': // 2160x3840 (iPhone 15 비율)
      size = Size(2160 / aspectRatio, 2160);
      break;
    default:
      size = Size(1080 / aspectRatio, 1080); // 기본값: FHD
  }

  await DesktopWindow.setWindowSize(size); // 창 크기 설정
}

class MyApp extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //
    // });
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
      title: '세돌스탁',
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
        GetPage(
          name: AppRoute.event,
          page: () => EventScreen(),
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
