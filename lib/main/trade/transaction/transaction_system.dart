import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/utils/audio.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../../../data/public_data.dart';
import '../../../data/start_data.dart';
import '../../../data/youtube_data.dart';
import '../../../main.dart';
import '../../../utils/get_env.dart';
import 'package:http/http.dart' as http;

class TransactionController extends GetxController {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final AudioController _audioController = Get.find<AudioController>();

  late bool buying; // 판매, 구매 구분 변수
  late String channelUID;
  late String transactionText; // 판매, 구매 구분 텍스트
  late String itemType; // 조회수, 좋아요수 구분 텍스트
  RxString calculatorDisplay = ''.obs; // 계산기 디스플레이에 나타날 변수
  RxInt calculatorInt = 0.obs; // 계산기 입력된 값(주식 개수)
  RxInt calculatorSum = 0.obs; // 구매, 판매할 주식의 총 가격
  RxDouble stockRatio = 0.0.obs; // 주식 변동률
  Color textColor = Colors.black;
  RxInt delistingCount = 0.obs; // 상장폐지 기간

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    buying = arguments['buying'];
    channelUID = arguments['channelUID'];
    stockRatio = arguments['stockRatio'];
    itemType = arguments['type'];
    setTransactionText(arguments['buying']);
    setTitleTextColor();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    // 화면의 숫자 버튼을 눌렀을떄 실행되는 기능
    ever(
      calculatorInt,
      (callback) {
        calculatorSum.value = calculatorInt.value *
            (itemType == 'view'
                ? _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice
                : _youtubeDataController.youtubeLiveData[channelUID]!.likeCountPrice);
      },
    );
  }

  // 해당 종목이 상장폐지가 되었는지 확인하는 함수
  bool checkDelisting() {
    final delistingValue = (itemType == 'view')
        ? _youtubeDataController.youtubeLiveData[channelUID]!.viewDelisting
        : _youtubeDataController.youtubeLiveData[channelUID]!.likeDelisting;
    delistingCount.value = delistingValue;
    return delistingValue > 0;
  }

  // 구매, 판매를 구분하여 텍스트를 설정하는 함수
  void setTransactionText(bool buying) {
    if (buying) {
      transactionText = '구매';
    } else {
      transactionText = '판매';
    }
  }

  // 매매 화면의 버튼중 숫자 버튼을 눌렀을때 계산기 화면에 등록될 값을 설정하는 화면
  void onTapNumButton(int pad) {
    if (pad >= 0) {
      calculatorInt.value = (calculatorInt.value * 10) + pad;
    } else if (pad == -1) {
      calculatorInt.value = calculatorInt.value ~/ 10;
    } else {
      calculatorInt.value = 0;
    }
    calculatorDisplay.value = calculatorInt.value.toString();
  }

  // 주식 매매 수량 +1 버튼
  void onTapPlus() {
    if (calculatorDisplay.value.isNotEmpty) {
      calculatorInt.value++;
    } else {
      calculatorInt.value = 1;
    }
    calculatorDisplay.value = calculatorInt.value.toString();
  }

  // 주식 매매 수량 -1 버튼
  void onTapMinus() {
    if (calculatorDisplay.value.isNotEmpty && calculatorInt.value > 0) {
      calculatorInt.value--;
    } else {
      calculatorInt.value = 0;
    }
    calculatorDisplay.value = calculatorInt.value.toString();
  }

  // 내 자산으로 매매 가능한 최대값의 절반을 계산해서 등록해주는 함수
  void onTapHalf() {
    if (buying) {
      calculatorInt.value = (_myDataController.myMoney.value ~/
              (_youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice *
                  (1 + feeRate))) ~/
          2;
      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && _myDataController.ownStock['${channelUID}_$itemType']!.stockCount > 0) {
      calculatorInt.value = _myDataController.ownStock['${channelUID}_$itemType']!.stockCount ~/ 2;
      calculatorDisplay.value = calculatorInt.value.toString();
    }
  }

  // 내 자산으로 매매 가능한 최대값을 계산해서 등록해주는 함수
  void onTapMax() {
    if (buying) {
      calculatorInt.value = (_myDataController.myMoney.value ~/
          (_youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice * (1 + feeRate)));
      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && _myDataController.ownStock['${channelUID}_$itemType']!.stockCount > 0) {
      calculatorInt.value = _myDataController.ownStock['${channelUID}_$itemType']!.stockCount;
      calculatorDisplay.value = calculatorInt.value.toString();
    }
  }

  // 내 자산보다 구매할 주식이 클 경우 또는 판매할 주식이 내 보유 주식보다 많은지 체크하는 함수
  bool checkData() {
    if (buying && calculatorSum.value > _myDataController.myMoney.value) {
      return false;
    }
    if (_myDataController.ownStock['${channelUID}_$itemType']!.stockCount < calculatorInt.value) {
      return false;
    }
    return true;
  }

  void setTitleTextColor() {
    if (stockRatio > 0) {
      textColor = Colors.red;
    } else if (stockRatio < 0) {
      textColor = Colors.blue;
    } else {
      textColor = Colors.black;
    }
  }

  // 매매 함수
  Future<void> trySale(int price, int count) async {
    EasyLoading.show();
    final url = Uri.parse('$httpURL/trade/${_myDataController.myUid}/trade/0');
    String type = buying ? 'buy' : 'sell';
    int priceAvg = 0;

    if (!buying) {
      priceAvg = _myDataController.itemHistory['${channelUID}_$itemType']!.itemPriceAvg;
    }

    final Map<String, dynamic> tradeData = {
      'itemuid': channelUID,
      'itemtype': itemType,
      'itemcount': count,
      'transactionprice': price,
      'type': type,
      'priceavg': priceAvg,
    };

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(tradeData),
      );

      if (response.statusCode == 200) {
        _audioController.playSound('assets/sound/testsound.wav');
        Get.back();
        await reflashGetData(false);
        showSimpleSnackbar('거래 완료', '거래가 성공적으로 완료되었습니다!', SnackPosition.TOP, Colors.black);
        logger.i('trySale : Trade data updated successfully');
      } else {
        showSimpleSnackbar(
            '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
        logger.w('trySale : Failed to update trade data. Status code: ${response.statusCode}');
      }
      EasyLoading.dismiss();
    } catch (e) {
      showSimpleSnackbar(
          '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
      logger.e('trySale : Error updating trade data: $e');
      Get.back();
      EasyLoading.dismiss();
    }
  }
}
