import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stockpj/model/main/trade_model.dart';
import '../../../constants/data_constants.dart';
import '../../../data/my_data.dart';
import '../../../data/public_data.dart';
import '../../../data/start_data.dart';
import '../../../data/youtube_data.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/audio.dart';
import '../../../utils/format.dart';
import '../../../utils/screen_size.dart';
import '../../../widget/simple_widget.dart';
import '../../../utils/timer.dart';
import '../../../view/main/trade/trade_dealing_widget.dart';

class TradeDealingViewModel extends GetxController {
  final TradeModel tradeModel = TradeModel();
  final ScreenController screenController = Get.find<ScreenController>();
  final YoutubeDataController youtubeDataController = Get.find<YoutubeDataController>();
  final MyDataController myDataController = Get.find<MyDataController>();
  final TimerController _timerController = Get.find<TimerController>();
  final AudioController _audioController = Get.find<AudioController>();

  bool buying = false; // 판매, 구매 구분 변수
  String channelUID = '';
  String itemType = ''; // 조회수, 좋아요수 구분 텍스트
  RxString calculatorDisplay = ''.obs; // 계산기 디스플레이에 나타날 변수
  RxInt calculatorInt = 0.obs; // 계산기 입력된 값(주식 개수)
  RxInt calculatorSum = 0.obs; // 구매, 판매할 주식의 총 가격
  Rx<ItemPriceDataClass> itemPriceData = ItemPriceDataClass(
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0.0,
    0,
    0,
  ).obs; // 아이템 가격데이터

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // 이전 화면에서 넘겨받은 데이터
    final arguments = Get.arguments as Map<String, dynamic>;
    buying = arguments['buying'];
    channelUID = arguments['channelUID'];
    itemType = arguments['type'];
    itemPriceData.value = youtubeDataController.itemPriceDateMap['${channelUID}_$itemType']!;
  }

  @override
  void onReady() {
    // 주식 매매 개수가 변경되는걸 감지해서 실행시킴
    ever(
      calculatorInt,
      (callback) => setSalePrice(),
    );
  }

  String typeTitle() {
    return itemType == 'view' ? '조회수' : '좋아요수';
  }

  String saleTitle() {
    return buying ? '구매' : '판매';
  }

  int getPrice() {
    return itemPriceData.value.price;
  }

  // 매매 화면의 버튼중 숫자 버튼을 눌렀을때 계산기 화면에 등록될 값을 설정하는 화면
  void onTapNumButton(int pad) {
    if (calculatorDisplay.value.length > 15) return;

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
    if (calculatorDisplay.value.length > 15) return;
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
      calculatorInt.value =
          (myDataController.myMoney.value ~/ (itemPriceData.value.price * (1 + feeRate))) ~/ 2;

      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && myDataController.ownStock['${channelUID}_$itemType']!.stockCount > 0) {
      calculatorInt.value = myDataController.ownStock['${channelUID}_$itemType']!.stockCount ~/ 2;
      calculatorDisplay.value = calculatorInt.value.toString();
    }
  }

  // 내 자산으로 매매 가능한 최대값을 계산해서 등록해주는 함수
  void onTapMax() {
    if (buying) {
      calculatorInt.value =
          (myDataController.myMoney.value ~/ (itemPriceData.value.price * (1 + feeRate)));

      calculatorDisplay.value = calculatorInt.value.toString();
    } else if (!buying && myDataController.ownStock['${channelUID}_$itemType']!.stockCount > 0) {
      calculatorInt.value = myDataController.ownStock['${channelUID}_$itemType']!.stockCount;
      calculatorDisplay.value = calculatorInt.value.toString();
    }
  }

  // 해당 종목이 상장폐지가 되었는지 확인하는 함수
  bool checkDelisting() {
    return itemPriceData.value.delisting > 0;
  }

  Color buttonColor() {
    return buying ? Colors.red : Colors.blue;
  }

  void setSalePrice() {
    calculatorSum.value = calculatorInt.value * itemPriceData.value.price;
  }

  String calculatorDataText() {
    return '현재 가격 : ${formatToCurrency(itemPriceData.value.price)}원 수수료 : ${formatToCurrency((itemPriceData.value.price * feeRate).round())}원';
  }

  // 매매 버튼을 클릭했을때 실행
  void onPressedDealingButton() {
    if ((calculatorInt.value <= 0 ||
            myDataController.myMoney.value < getPrice() * calculatorInt.value) &&
        buying) {
      showSimpleDialog(Get.back, '거래 오류', '구매 수량 혹은 잔액이 충분하지 않습니다.');
    } else if (myDataController.ownStock['${channelUID}_$itemType']!.stockCount <= 0 && !buying) {
      showSimpleDialog(Get.back, '거래 오류', ' 판매 수량이 충분하지 않습니다.');
    } else {
      int price = getPrice();
      int fee = ((price * calculatorInt.value) * feeRate).round();
      Get.dialog(
        DealingDialog(
          viewModel: this,
          screenSize: screenController.screenSize.value,
          price: price,
          fee: fee,
        ),
      );
    }
  }

  // 매매 다이얼로그에서 매매버튼을 클릭했을떄 실행
  void onPressedSaleButton(int price) {
    if (_timerController.checkDataTime.value) {
      showSimpleDialog(Get.back, '매매 실패', '현재 서버에서 데이터를 갱신 중입니다. 갱신 완료 후 다시 이용해 주세요.');
    } else if (checkDelisting()) {
      showSimpleDialog(
          Get.back, '매매 실패', '현재 상장폐지중인 아이템입니다. ${itemPriceData.value.delisting}턴 후에 다시 이용해주세요');
    } else {
      trySale(price, calculatorInt.value);
    }
  }

  // 매매 함수
  Future<void> trySale(int price, int count) async {
    EasyLoading.show();
    try {
      bool checkSale = await tradeModel.trySale(
          myDataController.myUid.value,
          price,
          count,
          channelUID,
          itemType,
          saleTitle(),
          myDataController.itemHistory['${channelUID}_$itemType']!.itemPriceAvg);
      if (checkSale) {
        _audioController.playSound('assets/sound/testsound.wav');
        Get.back();
        await reflashGetData(false);
        showSimpleSnackbar('거래 완료', '거래가 성공적으로 완료되었습니다!', SnackPosition.TOP, Colors.black);
      } else {
        showSimpleSnackbar(
            '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
      }
      EasyLoading.dismiss();
    } catch (e) {
      showSimpleSnackbar(
          '거래 실패', '거래를 처리하는 중 문제가 발생했습니다. 다시 시도해 주세요.', SnackPosition.TOP, Colors.red);
      Get.back();
    } finally {
      EasyLoading.dismiss();
    }
  }

  // 매매에 실패했을때 실행되는 함수
  void onPressedFinalDealingButton(int price, int transactionCount) {
    if (_timerController.checkDataTime.value) {
      showSimpleDialog(Get.back, '매매 실패', '현재 서버에서 데이터를 갱신 중입니다. 갱신 완료 후 다시 이용해 주세요.');
    } else if (checkDelisting()) {
      showSimpleDialog(
          Get.back, '매매 실패', '현재 상장폐지중인 아이템입니다. ${itemPriceData.value.delisting}턴 후에 다시 이용해주세요');
    } else {
      trySale(price, transactionCount);
    }
  }

  String setPlus() {
    if (itemPriceData.value.differencePrice > 0) {
      return '+';
    } else {
      return '';
    }
  }
}
