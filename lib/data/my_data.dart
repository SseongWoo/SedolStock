import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:stockpj/data/youtube_data.dart';
import 'package:stockpj/utils/color.dart';
import 'package:stockpj/utils/http_request.dart';
import 'package:stockpj/utils/data_storage.dart';
import 'package:get/get.dart';

class OwnStock {
  String stockName;
  int stockCount;
  int stockPrice;
  OwnStock(this.stockName, this.stockCount, this.stockPrice);
}

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

class ItemHistoryClass {
  String itemUID;
  String itemType;
  int itemPriceAvg;
  ItemHistoryClass(this.itemUID, this.itemType, this.itemPriceAvg);
}

class MyDataController extends GetxController {
  final YoutubeDataController _youtubeDataController = Get.find<YoutubeDataController>();
  RxString myUid = ''.obs;
  RxString myId = ''.obs;
  RxString myFirstlogintime = ''.obs;
  RxString myName = ''.obs;
  RxString myChoicechannel = ''.obs;
  RxString myLastLoginTime = ''.obs;
  RxInt myMoney = 0.obs;
  RxInt myStockMoney = 0.obs;
  RxInt myRank = 0.obs;
  RxInt myBeforeRank = 0.obs;
  RxInt myTotalMoney = 0.obs;
  RxInt myReturnMoney = 0.obs;
  RxDouble myRatioMoney = 0.0.obs;
  RxInt myStockCount = 0.obs;
  RxInt myStockList = 0.obs;
  RxMap<String, OwnStock> ownStock = <String, OwnStock>{}.obs;
  RxList<StockListClass> stockListItem = <StockListClass>[].obs;
  RxList<TradeHistoryClass> tradeHistoryList = <TradeHistoryClass>[].obs;
  RxMap<String, ItemHistoryClass> itemHistory = <String, ItemHistoryClass>{}.obs;
  RxInt totalMoneyHistory = 0.obs;
  RxInt totalSellHistory = 0.obs;
  RxInt totalBuyHistory = 0.obs;
  RxList<int> totalMoneyHistoryList = <int>[].obs;

  void setTotalMoney() {
    myTotalMoney.value = myMoney.value + myStockMoney.value;
  }

  void setMoneyData() {
    myStockMoney.value = 0;
    myRatioMoney.value = 0;
    myReturnMoney.value = 0;
    int totalBuyPrice = 0; // 총 구매 가격을 추적
    stockListItem.clear();

    ownStock.forEach((key, value) {
      if (value.stockCount > 0) {
        String keyUID = key.replaceAll(RegExp(r'(_view|_comment|_like)$'), '');
        String? type = RegExp(r'_([^_]+)$') // 마지막 '_' 뒤의 단어만 매칭
            .firstMatch(key)
            ?.group(1);

        if (_youtubeDataController.youtubeLiveData[keyUID] != null) {
          int stockPrice = (type == 'view'
                  ? _youtubeDataController.youtubeLiveData[keyUID]!.viewCountPrice
                  : _youtubeDataController.youtubeLiveData[keyUID]!.likeCountPrice) *
              value.stockCount;

          myStockMoney.value += stockPrice;

          totalBuyPrice += value.stockPrice * value.stockCount;

          int profit = stockPrice - value.stockPrice;
          myReturnMoney.value += profit;

          stockListItem.add(StockListClass(
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
              streamerColorMap[keyUID]!));

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

Future<bool> getUserData() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  myDataController.myUid.value = (await getUID())!;
  final String apiUrl = '$httpURL/users/${myDataController.myUid.value}'; // 서버 URL과 엔드포인트

  try {
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
    return false;
  }
}

Future<bool> getWalletData() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  // UID를 가져옴
  myDataController.myUid.value = (await getUID())!;
  final String apiUrl = '$httpURL/users/wallet/${myDataController.myUid.value}'; // 서버 URL과 엔드포인트
  myDataController.myStockCount.value = 0;
  myDataController.myStockList.value = 0;

  try {
    // 서버에 GET 요청을 보냄
    final response = await http.get(Uri.parse(apiUrl));

    // 요청이 성공적인지 확인
    if (response.statusCode == 200) {
      // JSON 데이터를 파싱
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
        // 예상한 데이터 형식이 아닐 때의 처리
        print('Unexpected data format: $jsonData');
        return false;
      }
    } else if (response.statusCode == 404) {
      // 문서가 존재하지 않는 경우의 처리
      print('No wallet data found for user ${myDataController.myUid.value}');
      return false;
    } else {
      // 다른 상태 코드에 대한 처리
      print('Failed to fetch wallet data. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    // 예외 발생 시 처리
    print('Error fetching wallet data: $e');
    return false;
  }
}

Future<void> getTradeHistoryData() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  // UID를 가져옴
  myDataController.myUid.value = (await getUID())!;
  final String apiUrl = '$httpURL/users/tradeList/${myDataController.myUid.value}';

  try {
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

        // 데이터 초기화
        myDataController.tradeHistoryList.clear();
        myDataController.totalBuyHistory.value = 0;
        myDataController.totalSellHistory.value = 0;

        // 모든 리스트의 길이가 같은지 체크
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
          print('Data length mismatch between lists.');
        }
      } else {
        print('Unexpected data format: $jsonData');
      }
    } else if (response.statusCode == 404) {
      print('No wallet data found for user ${myDataController.myUid.value}');
    } else {
      print('Failed to fetch wallet data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching wallet data: $e');
  }
}

Future<void> updateMyTotalMoney() async {
  final MyDataController myDataController = Get.find<MyDataController>();

  // UID를 가져옴
  myDataController.myUid.value = (await getUID())!;

  // 서버 URL
  final String apiUrl = '$httpURL/users/updatetotalmoney/${myDataController.myUid.value}';

  // 요청에 보낼 데이터 구성
  final Map<String, dynamic> requestData = {
    'totalmoney': myDataController.myTotalMoney.value,
  };

  try {
    // HTTP PUT 요청 보내기
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // JSON 형식으로 헤더 설정
      },
      body: jsonEncode(requestData), // 데이터 JSON으로 인코딩
    );

    if (response.statusCode == 200) {
      // 업데이트 성공 처리
      print('Total money updated successfully');
    } else {
      // 상태 코드가 200이 아닌 경우 실패 처리
      print('Failed to update total money. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // 요청 도중 발생한 예외 처리
    print('Error updating total money: $e');
  }
}
