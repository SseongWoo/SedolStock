import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import 'package:stockpj/utils/simple_widget.dart';
import '../../../data/start_data.dart';
import '../../../data/youtube_data.dart';
import '../../../utils/http_request.dart';
import 'package:http/http.dart' as http;

class TransactionController extends GetxController {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController _myDataController = Get.find<MyDataController>();

  late bool buying;
  late String channelUID;
  late String transactionText;
  late String itemType = 'view';
  RxString calculatorDisplay = ''.obs;
  RxInt calculatorInt = 0.obs;
  RxInt calculatorSum = 0.obs;
  RxDouble stockRatio = 0.0.obs;
  Color textColor = Colors.black;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    buying = arguments['buying'];
    channelUID = arguments['channelUID'];
    stockRatio = arguments['stockRatio'];
    setTransactionText(arguments['buying']);
    setTitleTextColor();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    ever(
      calculatorInt,
      (callback) {
        calculatorSum.value = calculatorInt.value *
            _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice;
      },
    );
  }

  void setTransactionText(bool buying) {
    if (buying) {
      transactionText = '구매';
    } else {
      transactionText = '판매';
    }
  }

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

  void onTapPlus() {
    if (calculatorDisplay.value.isNotEmpty) {
      calculatorInt.value++;
    } else {
      calculatorInt.value = 1;
    }
    calculatorDisplay.value = calculatorInt.value.toString();
  }

  void onTapMinus() {
    if (calculatorDisplay.value.isNotEmpty && calculatorInt.value > 0) {
      calculatorInt.value--;
    } else {
      calculatorInt.value = 0;
    }
    calculatorDisplay.value = calculatorInt.value.toString();
  }

  void onTapHalf() {
    if (buying) {
      calculatorInt.value = (_myDataController.myMoney.value ~/
              _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice) ~/
          2;
      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && _myDataController.ownStock['$channelUID$itemType']!.stockCount > 0) {
      calculatorInt.value = _myDataController.ownStock['$channelUID$itemType']!.stockCount ~/ 2;
    }
  }

  void onTapMax() {
    if (buying) {
      calculatorInt.value = (_myDataController.myMoney.value ~/
          _youtubeDataController.youtubeLiveData[channelUID]!.viewCountPrice);
      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && _myDataController.ownStock['$channelUID$itemType']!.stockCount > 0) {
      calculatorInt.value = _myDataController.ownStock['$channelUID$itemType']!.stockCount;
    }
  }

  bool checkData() {
    if (buying && calculatorSum.value > _myDataController.myMoney.value) {
      return false;
    }

    if (_myDataController.ownStock['$channelUID$itemType']!.stockCount < calculatorInt.value) {
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

  Future<void> trySale(int price, int count) async {
    EasyLoading.show();
    final url = Uri.parse('$httpURL/trade/${_myDataController.myUid}/trade/0');
    String type = buying ? 'buy' : 'sell';
    int priceAvg = 0;

    if (!buying) {
      priceAvg = _myDataController.itemHistory['${channelUID}_view']!.itemPriceAvg;
    }

    // JSON 데이터를 구성
    final Map<String, dynamic> tradeData = {
      'itemuid': channelUID,
      'itemtype': 'view',
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
        Get.back();
        await reflashGetData(false);
        showSimpleSnackbar('거래 완료', '거래가 성공적으로 완료되었습니다!', SnackPosition.TOP, Colors.black);
        print('Trade data updated successfully');
      } else {
        showSimpleSnackbar(
            '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
        print('Failed to update trade data. Status code: ${response.statusCode}');
      }
      EasyLoading.dismiss();
    } catch (e) {
      showSimpleSnackbar(
          '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
      print('Error updating trade data: $e');
      Get.back();
      EasyLoading.dismiss();
    }
  }
}
