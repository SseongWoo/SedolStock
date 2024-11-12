import 'dart:async';
import 'package:get/get.dart';
import 'package:stockpj/data/public_data.dart';

class HomeController extends GetxController {
  RxBool mainChannelList = true.obs;
  RxBool mainChannelVideoList = true.obs;

  List<String> getChannelList() {
    return mainChannelList.value ? channelIdList : subChannelIdList;
  }

  List<String> getVideoList() {
    return mainChannelVideoList.value ? channelIdList : subChannelIdList;
  }
}
