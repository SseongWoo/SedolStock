import 'package:flutter/material.dart';
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/service/storage_service.dart';
import 'package:get/get.dart';
import 'package:stockpj/widget/simple_widget.dart';
import 'package:stockpj/main.dart';
import '../model/data/data_class.dart';
import '../model/data/data_model.dart';

class MyDataController extends GetxController {
  final DataModel dataModel = DataModel();
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  RxString myUid = ''.obs; // 사용자 정보
  RxString myId = ''.obs; // *
  RxString myFirstlogintime = ''.obs; // *
  RxString myName = ''.obs; // *
  RxString myChoicechannel = ''.obs; // *
  RxString myLastLoginTime = ''.obs; // *
  RxInt myMoney = 0.obs; // *
  RxInt myStockMoney = 0.obs; // *
  RxInt myRank = 0.obs; // *
  RxInt myBeforeRank = 0.obs; // *
  RxInt myTotalMoney = 0.obs; // *
  RxInt myReturnMoney = 0.obs; // *
  RxDouble myRatioMoney = 0.0.obs; // *
  RxInt myStockCount = 0.obs; // *
  RxInt myStockList = 0.obs; // //
  RxMap<String, OwnStock> ownStock = <String, OwnStock>{}.obs; // 보유 주식 맵 데이터
  RxMap<String, StockListClass> stockListItem = <String, StockListClass>{}.obs; // 보유 주식 리스트 데이터
  RxList<TradeHistoryClass> tradeHistoryList = <TradeHistoryClass>[].obs; // 거래 내역 리스트 데이터
  RxMap<String, ItemHistoryClass> itemHistory = <String, ItemHistoryClass>{}.obs; // 주식 정보 맵 데이터
  RxInt totalMoneyHistory = 0.obs; // 거래 내역 정보
  RxInt totalSellHistory = 0.obs; // *
  RxInt totalBuyHistory = 0.obs; // //
  RxList<TotalMoneyDataClass> totalMoneyHistoryList =
      <TotalMoneyDataClass>[].obs; // 사용자 보유 잔고 역사 그래프 데이터
  RxList<MessageClass> messageList = <MessageClass>[].obs; // 메세지 리스트 데이터

  // 사용자의 자산 데이터를 설정하는 함수
  void setMoneyData() {
    myStockMoney.value = 0;
    myRatioMoney.value = 0;
    myReturnMoney.value = 0;
    int totalBuyPrice = 0; // 총 구매 가격
    stockListItem.clear();

    ownStock.forEach((key, value) {
      if (value.stockCount > 0) {
        if (_youtubeDataController.itemPriceDateMap[key] != null) {
          // 주식 종류를 구분해서 가격정보를 가져옴
          ItemPriceDataClass itemPriceData = _youtubeDataController.itemPriceDateMap[key]!;

          int stockPrice = itemPriceData.price * value.stockCount;
          int buyPrice = value.stockPrice ~/ value.stockCount;

          myStockMoney.value += stockPrice;
          totalBuyPrice += value.stockPrice;
          int profit = itemPriceData.price - buyPrice; // 이익 계산
          myReturnMoney.value += profit;

          String itemUid = itemPriceData.uid;

          stockListItem['${itemUid}_${itemPriceData.type}'] = StockListClass(
              itemUid,
              _youtubeDataController.channelMapData[itemUid]!,
              profit,
              (profit / buyPrice) * 100,
              value.stockCount,
              stockPrice,
              buyPrice,
              itemPriceData.price,
              itemPriceData.type,
              streamerColorMap[itemUid]!);

          itemHistory[key] = ItemHistoryClass(
              itemUid, itemPriceData.type ?? '', value.stockPrice ~/ value.stockCount);
        }
      }
    });

    // 수익률 계산
    if (totalBuyPrice > 0) {
      myRatioMoney.value = (myReturnMoney.value / totalBuyPrice) * 100;
    } else {
      myRatioMoney.value = 0;
    }

    // 전체 자산 업데이트
    myTotalMoney.value = myMoney.value + myStockMoney.value;
  }

  // 사용자 데이터를 가져오는 함수
  Future<bool> getUserData() async {
    try {
      if (myUid.value.isEmpty) {
        final storedUid = await getUID();
        if (storedUid != null) {
          myUid.value = storedUid;
        } else {
          throw Exception('Empty My Uid');
        }
      }
      // 모델을 통해 사용자 데이터 가져오기
      final userData = await dataModel.fetchUserData(myUid.value);

      // 서버에서 데이터를 가져온 경우
      if (userData != null) {
        myId.value = userData['id'];
        myFirstlogintime.value = userData['firstlogintime'];
        myName.value = userData['name'];
        myChoicechannel.value = userData['choicechannel'];
        myMoney.value = userData['money'];
        myRank.value = userData['rank'];
        myBeforeRank.value = userData['beforerank'];
        return true;
      }

      // 사용자 데이터가 없는 경우
      return false;
    } catch (e) {
      logger.e('getUserData error: $e');
      showSimpleSnackbar('에러', '$e', SnackPosition.BOTTOM, Colors.red);
      return false;
    }
  }

  // 사용자의 지갑 데이터를 가져오는 함수
  Future<bool> getWalletData() async {
    try {
      if (myUid.value.isEmpty) {
        final uid = await getUID();
        if (uid != null) {
          myUid.value = uid;
        } else {
          throw Exception('Empty My UID');
        }
      }

      final result = await dataModel.fetchWalletData(myUid.value);
      if (result != null) {
        final jsonData = result['data'] as Map<String, dynamic>;
        final jsonData2 = result['moneyHistory'];

        totalMoneyHistoryList.value = jsonData2['totalmoneyhistory'].map<TotalMoneyDataClass>((e) {
          return TotalMoneyDataClass(
            int.tryParse(e['money'].toString()) ?? 0, // 금액 데이터
            e['date']?.toString() ?? '', // 날짜 데이터
          );
        }).toList();

        // 보유 주식 데이터 처리
        myStockCount.value = 0;
        myStockList.value = 0;

        jsonData.forEach((key, value) {
          final stock = OwnStock(
            value['stockName'] ?? 'Unknown',
            value['stockCount'] ?? 0,
            value['stockPrice'] ?? 0,
          );
          ownStock[key] = stock;

          if (stock.stockCount > 0) {
            myStockCount += stock.stockCount;
            myStockList++;
          }
        });

        return true;
      } else {
        return false;
      }
    } catch (e) {
      logger.e('getWalletData error: $e');
      showSimpleSnackbar('에러', '$e', SnackPosition.BOTTOM, Colors.red);
      return false;
    }
  }

  // 거래내역 데이터를 가져오는 함수
  Future<void> getTradeHistoryData() async {
    try {
      if (myUid.value.isEmpty) {
        final uid = await getUID();
        if (uid != null) {
          myUid.value = uid;
        } else {
          throw Exception('Empty My UID');
        }
      }
      final tradeHistoryListData = await dataModel.fetchTradeHistory(myUid.value);

      if (tradeHistoryListData != null) {
        tradeHistoryList.clear();
        tradeHistoryList.addAll(tradeHistoryListData);

        // 총 구매 및 판매 금액 계산
        totalBuyHistory.value = 0;
        totalSellHistory.value = 0;

        for (var trade in tradeHistoryList) {
          if (trade.type == 'buy') {
            totalBuyHistory += trade.tradePrice;
          } else {
            totalSellHistory += trade.tradePrice;
          }
        }
        // 총 수익 계산
        totalMoneyHistory.value = totalSellHistory.value - totalBuyHistory.value;
      }

      logger.i('getTradeHistoryData log: getData successfully');
    } catch (e) {
      logger.e('getTradeHistoryData error: $e');
    }
  }

  // 사용자의 총 자산을 서버에 업데이트하는 함수
  Future<void> updateMyTotalMoney() async {
    try {
      if (myUid.value.isEmpty) {
        final uid = await getUID();
        if (uid != null) {
          myUid.value = uid;
        } else {
          throw Exception('Empty My UID');
        }
      }

      final isSuccess = await dataModel.updateTotalMoney(myUid.value, myTotalMoney.value);

      if (isSuccess) {
        logger.i('updateMyTotalMoney log: Total money updated successfully');
      }
    } catch (e) {
      logger.e('updateMyTotalMoney error: $e');
    }
  }

  // 서버에서 메시지 데이터를 가져오는 함수
  Future<void> getMessage() async {
    try {
      if (myUid.value.isEmpty) {
        final uid = await getUID();
        if (uid != null) {
          myUid.value = uid;
        } else {
          throw Exception('Empty My UID');
        }
      }

      final List<MessageClass> messages = await dataModel.fetchMessages(myUid.value);

      messageList.assignAll(messages);
      logger.i('getMessage log: get message successfully');
    } catch (e) {
      logger.e('getMessage error: $e');
    }
  }
}
