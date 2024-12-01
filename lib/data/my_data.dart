import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/get_env.dart';
import 'package:stockpj/utils/data_storage.dart';
import 'package:get/get.dart';
import 'package:stockpj/utils/simple_widget.dart';
import 'package:stockpj/main.dart';

// 보유 주식 클래스
class OwnStock {
  String stockName;
  int stockCount;
  int stockPrice;
  OwnStock(this.stockName, this.stockCount, this.stockPrice);
}

// 보유 주식 리스트 클래스
class StockListClass {
  String stockUID;
  String stockName;
  int stockProfit;
  double stockRatio;
  int stockCount;
  int stockTotalPrice;
  int stockBuyingPrice;
  int currentPrice;
  String stockType;
  Color color;

  StockListClass(
    this.stockUID,
    this.stockName,
    this.stockProfit,
    this.stockRatio,
    this.stockCount,
    this.stockTotalPrice,
    this.stockBuyingPrice,
    this.currentPrice,
    this.stockType,
    this.color,
  );
}

// 주식 거래 내역 클래스
class TradeHistoryClass {
  String itemuid;
  String itemtype;
  int itemcount;
  int transactionprice;
  String type;
  int moneybefore;
  int moneyafter;
  String tradetime;
  int priceavg;

  TradeHistoryClass({
    required this.itemuid,
    required this.itemtype,
    required this.itemcount,
    required this.transactionprice,
    required this.type,
    required this.moneybefore,
    required this.moneyafter,
    required this.tradetime,
    required this.priceavg,
  });
}

// 주식 정보 클래스
class ItemHistoryClass {
  String itemUID;
  String itemType;
  int itemPriceAvg;
  ItemHistoryClass(this.itemUID, this.itemType, this.itemPriceAvg);
}

class MyDataController extends GetxController {
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
  RxList<StockListClass> stockListItem = <StockListClass>[].obs; // 보유 주식 리스트 데이터
  RxList<TradeHistoryClass> tradeHistoryList = <TradeHistoryClass>[].obs; // 거래 내역 리스트 데이터
  RxMap<String, ItemHistoryClass> itemHistory = <String, ItemHistoryClass>{}.obs; // 주식 정보 맵 데이터
  RxInt totalMoneyHistory = 0.obs; // 거래 내역 정보
  RxInt totalSellHistory = 0.obs; // *
  RxInt totalBuyHistory = 0.obs; // //
  RxList<int> totalMoneyHistoryList = <int>[].obs; // 사용자 보유 잔고 역사 그래프 데이터

  // 사용자의 소지 금액과 주식 금액을 더해서 총 소유 자산을 계산하는 함수
  void setTotalMoney() {
    myTotalMoney.value = myMoney.value + myStockMoney.value;
  }

  // 사용자의 자산 데이터를 설정하는 함수
  void setMoneyData() {
    myStockMoney.value = 0;
    myRatioMoney.value = 0;
    myReturnMoney.value = 0;
    int totalBuyPrice = 0; // 총 구매 가격
    stockListItem.clear();

    ownStock.forEach((key, value) {
      if (value.stockCount > 0) {
        String keyUID = key.replaceAll(RegExp(r'(_view|_comment|_like)$'), ''); // 조건에 맞는 단어들을 삭제
        String? type = RegExp(r'_([^_]+)$') // 마지막 '_' 뒤의 단어만 매칭 가져옴
            .firstMatch(key)
            ?.group(1);

        if (_youtubeDataController.youtubeLiveData[keyUID] != null) {
          // 주식 종류를 구분해서 가격정보를 가져옴
          int stockPrice = (type == 'view'
                  ? _youtubeDataController.youtubeLiveData[keyUID]!.viewCountPrice
                  : _youtubeDataController.youtubeLiveData[keyUID]!.likeCountPrice) *
              value.stockCount;

          myStockMoney.value += stockPrice;
          totalBuyPrice += value.stockPrice;
          int profit = stockPrice - value.stockPrice; // 이익 계산
          myReturnMoney.value += profit;

          stockListItem.add(
            StockListClass(
                keyUID,
                channelMapData[keyUID]!,
                profit,
                (profit / value.stockPrice) * 100,
                value.stockCount,
                stockPrice,
                value.stockPrice ~/ value.stockCount,
                type == 'view'
                    ? _youtubeDataController.youtubeLiveData[keyUID]!.viewCountPrice
                    : _youtubeDataController.youtubeLiveData[keyUID]!.likeCountPrice,
                type ?? '',
                streamerColorMap[keyUID]!),
          );

          itemHistory[key] =
              ItemHistoryClass(keyUID, type ?? '', value.stockPrice ~/ value.stockCount);
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
    setTotalMoney();
  }
}

// 사용자의 정보를 가져오는 함수
Future<bool> getUserData() async {
  final MyDataController myDataController = Get.find<MyDataController>();
  try {
    // 사용자의 정보가 저장이 안되어있고 기기에 저장된 데이터도 없을 경우 예외발생
    if (myDataController.myUid.value == '') {
      if (await getUID() != null) {
        myDataController.myUid.value = (await getUID())!;
      } else {
        throw Exception('Empty My Uid');
      }
    }
    final String apiUrl = '$httpURL/users/${myDataController.myUid.value}'; // 서버와 통신하기위한 url
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      myDataController.myId.value = jsonData['data']['id'];
      myDataController.myFirstlogintime.value = jsonData['data']['firstlogintime'];
      myDataController.myName.value = jsonData['data']['name'];
      myDataController.myChoicechannel.value = jsonData['data']['choicechannel'];
      myDataController.myMoney.value = jsonData['data']['money'];
      myDataController.myRank.value = jsonData['data']['rank'];
      myDataController.myBeforeRank.value = jsonData['data']['beforerank'];
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      return false;
    }
  } catch (e) {
    logger.e('getUserData error : $e');
    showSimpleSnackbar('에러', '$e', SnackPosition.BOTTOM, Colors.red);
    return false;
  }
}

// 사용자의 자산 데이터를 가져오는 함수
Future<bool> getWalletData() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  try {
    // 사용자의 정보가 저장이 안되어있고 기기에 저장된 데이터도 없을 경우 예외발생
    if (myDataController.myUid.value == '') {
      if (await getUID() != null) {
        myDataController.myUid.value = (await getUID())!;
      } else {
        throw Exception('Empty My Uid');
      }
    }
    final String apiUrl = '$httpURL/users/wallet/${myDataController.myUid.value}'; // 서버와 통신하기위한 url
    myDataController.myStockCount.value = 0;
    myDataController.myStockList.value = 0;

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final jsonData2 = jsonDecode(response.body)['moneyhistory'];

      myDataController.totalMoneyHistoryList.value = List<int>.from(
          jsonData2['totalmoneyhistory'].map((e) => int.tryParse(e.toString()) ?? 0));

      if (jsonData is Map<String, dynamic>) {
        jsonData.forEach((key, value) {
          myDataController.ownStock[key] = OwnStock(
            value['stockName'] ?? 'Unknown',
            value['stockCount'] ?? 0,
            value['stockPrice'] ?? 0,
          );

          if (myDataController.ownStock[key]!.stockCount > 0) {
            myDataController.myStockCount += myDataController.ownStock[key]!.stockCount;
            myDataController.myStockList++;
          }
        });
        return true;
      } else {
        logger.w('getWalletData error : Unexpected data format: $jsonData');
        return false;
      }
    } else if (response.statusCode == 404) {
      logger
          .w('getWalletData error : No wallet data found for user ${myDataController.myUid.value}');
      return false;
    } else {
      logger.w(
          'getWalletData error : Failed to fetch wallet data. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    logger.e('getWalletData error : $e');
    showSimpleSnackbar('에러', '$e', SnackPosition.BOTTOM, Colors.red);
    return false;
  }
}

// 거래 데이터 내역을 가져오는 함수
Future<void> getTradeHistoryData() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  try {
    // 사용자의 정보가 저장이 안되어있고 기기에 저장된 데이터도 없을 경우 예외발생
    if (myDataController.myUid.value == '') {
      if (await getUID() != null) {
        myDataController.myUid.value = (await getUID())!;
      } else {
        throw Exception('Empty My Uid');
      }
    }

    final String apiUrl = '$httpURL/users/tradeList/${myDataController.myUid.value}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData is Map<String, dynamic>) {
        List<String> itemuids = List<String>.from(jsonData['itemuid'] ?? []);
        List<String> itemtypes = List<String>.from(jsonData['itemtype'] ?? []);
        List<int> itemcounts = List<int>.from(jsonData['itemcount'] ?? []);
        List<int> transactionprices = List<int>.from(jsonData['transactionprice'] ?? []);
        List<String> types = List<String>.from(jsonData['type'] ?? []);
        List<int> moneybefores = List<int>.from(jsonData['moneybefore'] ?? []);
        List<int> moneyafters = List<int>.from(jsonData['moneyafter'] ?? []);
        List<String> tradetimes = List<String>.from(jsonData['tradetime'] ?? []);
        List<int> priceavgs = List<int>.from(jsonData['priceavg'] ?? []);

        myDataController.tradeHistoryList.clear();
        myDataController.totalBuyHistory.value = 0;
        myDataController.totalSellHistory.value = 0;

        if (itemuids.length == itemtypes.length &&
            itemuids.length == itemcounts.length &&
            itemuids.length == transactionprices.length &&
            itemuids.length == types.length &&
            itemuids.length == moneybefores.length &&
            itemuids.length == moneyafters.length &&
            itemuids.length == tradetimes.length) {
          for (int i = 0; i < itemuids.length; i++) {
            myDataController.tradeHistoryList.add(
              TradeHistoryClass(
                itemuid: itemuids[i],
                itemtype: itemtypes[i],
                itemcount: itemcounts[i],
                transactionprice: transactionprices[i],
                type: types[i],
                moneybefore: moneybefores[i],
                moneyafter: moneyafters[i],
                tradetime: tradetimes[i],
                priceavg: priceavgs[i],
              ),
            );

            // 판매인지 구매인지 구분하여 저장
            if (types[i] == 'buy') {
              myDataController.totalBuyHistory.value += transactionprices[i] * itemcounts[i];
            } else {
              myDataController.totalSellHistory.value += transactionprices[i] * itemcounts[i];
            }
          }

          // 수익 계산
          myDataController.totalMoneyHistory.value =
              myDataController.totalSellHistory.value - myDataController.totalBuyHistory.value;
        } else {
          logger.w('getTradeHistoryData error : Data length mismatch between lists.');
        }
      } else {
        logger.w('getTradeHistoryData error : Unexpected data format: $jsonData');
      }
    } else if (response.statusCode == 404) {
      logger.w(
          'getTradeHistoryData error : No wallet data found for user ${myDataController.myUid.value}');
    } else {
      logger.w(
          'getTradeHistoryData error : Failed to fetch wallet data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('getTradeHistoryData error : $e');
  }
}

// 사용자의 자산 데이터를 DB에 업데이트 하는 함수
Future<void> updateMyTotalMoney() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  try {
    // 사용자의 정보가 저장이 안되어있고 기기에 저장된 데이터도 없을 경우 예외발생
    if (myDataController.myUid.value == '') {
      if (await getUID() != null) {
        myDataController.myUid.value = (await getUID())!;
      } else {
        throw Exception('Empty My Uid');
      }
    }

    // 서버 URL
    final String apiUrl = '$httpURL/users/updatetotalmoney/${myDataController.myUid.value}';

    final Map<String, dynamic> requestData = {
      'totalmoney': myDataController.myTotalMoney.value,
    };

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      logger.i('updateMyTotalMoney log : Total money updated successfully');
    } else {
      logger.w(
          'updateMyTotalMoney error : Failed to update total money. Status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('updateMyTotalMoney error : $e');
  }
}
