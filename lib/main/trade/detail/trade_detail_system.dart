import 'package:get/get.dart';
import 'package:stockpj/main/trade/transaction/transaction_screen.dart';

class TradeDetailController extends GetxController {
  void goTransaction(bool buying) {
    Get.to(() => TransactionScreen(
          buying: buying,
        ));
  }
}
