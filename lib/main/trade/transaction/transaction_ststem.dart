import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  RxString transactionText = ''.obs;
  RxString calculatorDisplay = ''.obs;
  RxInt calculatorInt = 0.obs;

  void setTransactionText(bool buying) {
    if (buying) {
      transactionText.value = '구매';
    } else {
      transactionText.value = '판매';
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
}
