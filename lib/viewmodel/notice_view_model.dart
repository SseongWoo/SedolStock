import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';
import '../../utils/screen_size.dart';

// 이벤트 뷰모델
class NoticeViewModel extends GetxController {
  final ScreenController screenController = Get.find<ScreenController>();
  final PublicDataController publicDataController = Get.find<PublicDataController>();
}
