import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 보유 주식 클래스
class OwnStock {
  int stockCount;
  int stockPrice;
  bool delisting;
  OwnStock(this.stockCount, this.stockPrice, this.delisting);

  factory OwnStock.fromJson(Map<String, dynamic> json) {
    return OwnStock(
      json['stockCount'] ?? 0,
      (json['stockPrice'] is num) ? (json['stockPrice'] as num).round() : 0,
      json['delisting'] ?? false,
    );
  }
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
  String stockChannelType;
  Color color;
  bool delisting;

  StockListClass(
    this.stockUID,
    this.stockName,
    this.stockProfit,
    this.stockRatio,
    this.stockCount,
    this.stockTotalPrice,
    this.stockBuyingPrice,
    this.currentPrice,
    this.stockChannelType,
    this.color,
    this.delisting,
  );
}

// 주식 거래 내역 클래스
class TradeHistoryClass {
  String itemuid;
  String channeltype;
  int itemcount;
  int transactionprice;
  String tradetype;
  String tradetime;
  int tradeprice;
  int profit;
  double ratio;
  int saleavgprice;
  int totalcost;
  int fee;

  TradeHistoryClass({
    required this.itemuid,
    required this.channeltype,
    required this.itemcount,
    required this.transactionprice,
    required this.tradetype,
    required this.tradetime,
    required this.tradeprice,
    required this.profit,
    required this.ratio,
    required this.totalcost,
    required this.fee,
    required this.saleavgprice,
  });

  factory TradeHistoryClass.fromJson(Map<String, dynamic> json, int index) {
    int itemCount = json['itemcount'][index] ?? 0;
    int transactionPrice = json['transactionprice'][index] ?? 0;
    int saleAvgPrice = json['priceavg'][index] ?? 0;
    int totalCost = json['totalcost'][index] ?? 0;
    int fee = json['fee'][index] ?? 0;

    return TradeHistoryClass(
      itemuid: json['itemuid'][index] ?? '',
      channeltype: json['channeltype'][index] ?? '',
      itemcount: itemCount,
      transactionprice: transactionPrice,
      tradetype: json['tradetype'][index] ?? '',
      tradetime: json['tradetime'][index] ?? '',
      tradeprice: transactionPrice * itemCount,
      profit: (saleAvgPrice - transactionPrice) * itemCount,
      ratio: (saleAvgPrice - transactionPrice) * 100 / (saleAvgPrice * itemCount),
      totalcost: totalCost,
      fee: fee,
      saleavgprice: saleAvgPrice,
    );
  }
}

// 메세지 데이터 클래스
class MessageClass {
  final String itemUID;
  final int stockCount;
  final String time;

  MessageClass({
    required this.itemUID,
    required this.stockCount,
    required this.time,
  });

  // JSON 데이터를 객체로 변환
  factory MessageClass.fromJson(Map<String, dynamic> json) {
    return MessageClass(
      itemUID: json['itemUid'] as String,
      stockCount: json['stockCount'] as int,
      time: json['time'] as String,
    );
  }
}

// 랭킹 데이터 클래스
class RankingDataClass {
  String uid;
  String name;
  String fandom;
  int rank;
  int totalMoney;
  int level;

  RankingDataClass(
    this.uid,
    this.name,
    this.fandom,
    this.rank,
    this.totalMoney,
    this.level,
  );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'fandom': fandom,
        'rank': rank,
        'totalmoney': totalMoney,
        'level': level,
      };

  // JSON 데이터를 객체로 변환하는 팩토리 생성자
  factory RankingDataClass.fromJson(Map<String, dynamic> json) {
    int? totalMoney;
    if (json['totalmoney'] is double) {
      totalMoney = (json['totalmoney'] as double).round();
    } else {
      totalMoney = json['totalmoney'] ?? 0;
    }

    return RankingDataClass(
      json['uid']?.toString() ?? '',
      json['name']?.toString() ?? '',
      json['fandom']?.toString() ?? '',
      json['rank'] ?? 0,
      totalMoney!,
      json['level'] ?? 0,
    );
  }
}

// 유튜브 영상 데이터 클래스
class YoutubeVideoDataClass {
  final String videoUrl;
  final String title;
  final String description;
  final String thumbnail;
  final String publishedAt;
  final String channelName;

  YoutubeVideoDataClass({
    required this.videoUrl,
    required this.title,
    required this.thumbnail,
    required this.publishedAt,
    this.description = '',
    this.channelName = '',
  });

  // JSON을 객체로 변환 (다양한 형태의 JSON을 처리)
  factory YoutubeVideoDataClass.fromJson(Map<String, dynamic> json) {
    return YoutubeVideoDataClass(
      videoUrl: json['videoUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      channelName: json['channelName'] ?? '',
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
        'videoUrl': videoUrl,
        'title': title,
        'description': description,
        'thumbnail': thumbnail,
        'publishedAt': publishedAt,
        'channelName': channelName,
      };
}

// 채널의 데이터 클래스
class YoutubeChannelDataClass {
  String birthday;
  String description;
  String subscribercount;
  String thumbnail;
  String title;

  YoutubeChannelDataClass(
    this.title,
    this.thumbnail,
    this.birthday,
    this.description,
    this.subscribercount,
  );

  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'birthday': birthday,
        'description': description,
        'subscribercount': subscribercount,
      };

  factory YoutubeChannelDataClass.fromJson(Map<String, dynamic> json) {
    return YoutubeChannelDataClass(
      json['title'],
      json['thumbnail'],
      json['birthday'],
      json['description'],
      json['subscribercount'],
    );
  }
}

// 아이템 정보 클래스
class ItemPriceDataClass {
  final String uid;
  final String channelType;
  final int price;
  final int totalViewCount;
  final int totalLikeCount;
  final int beforeTotalViewCount;
  final int beforeTotalLikeCount;
  final int beforePrice;
  final int differencePrice;
  final int delisting;
  final int continuous;
  final double ratio;

  ItemPriceDataClass({
    required this.uid,
    required this.channelType,
    required this.price,
    required this.totalViewCount,
    required this.totalLikeCount,
    required this.beforeTotalViewCount,
    required this.beforeTotalLikeCount,
    required this.beforePrice,
    required this.differencePrice,
    required this.delisting,
    required this.continuous,
    required this.ratio,
  });

  // 빈 객체 생성
  factory ItemPriceDataClass.empty() {
    return ItemPriceDataClass(
      uid: '',
      channelType: '',
      price: 0,
      totalViewCount: 0,
      totalLikeCount: 0,
      beforeTotalViewCount: 0,
      beforeTotalLikeCount: 0,
      beforePrice: 0,
      differencePrice: 0,
      delisting: 0,
      continuous: 0,
      ratio: 0.0,
    );
  }

  // JSON 데이터를 객체로 변환하는 메서드
  factory ItemPriceDataClass.fromJson(
      String channelId, Map<String, dynamic> json, List<String> channelIdList) {
    int price = json['price'] ?? 0;
    int lastPrice = json['lastPrice'] ?? 0;
    int diff = price - lastPrice;
    double ratio = lastPrice != 0 ? (diff / lastPrice) * 100 : 0.0;
    String channelType = channelIdList.contains(channelId) ? 'main' : 'sub';

    return ItemPriceDataClass(
      uid: channelId,
      channelType: channelType,
      price: price,
      totalViewCount: json['totalViewCount'] ?? 0,
      totalLikeCount: json['totalLikeCount'] ?? 0,
      beforeTotalViewCount: json['lastTotalViewCount'] ?? 0,
      beforeTotalLikeCount: json['lastTotalLikeCount'] ?? 0,
      beforePrice: lastPrice,
      differencePrice: diff,
      delisting: json['delisting'] ?? 0,
      continuous: json['continuous'] ?? 0,
      ratio: ratio,
    );
  }
}

class TotalMoneyDataClass {
  final int money;
  final String date;

  TotalMoneyDataClass({
    required this.money,
    required this.date,
  });

  factory TotalMoneyDataClass.fromJson(Map<String, dynamic> json) {
    return TotalMoneyDataClass(
      money: int.tryParse(json['money'].toString()) ?? 0,
      date: json['date']?.toString() ?? '',
    );
  }
}

class FeeConfig {
  final double buyFeeRate;
  final double sellFeeRate;

  FeeConfig({
    required this.buyFeeRate,
    required this.sellFeeRate,
  });

  factory FeeConfig.fromJson(Map<String, dynamic> json) {
    return FeeConfig(
      buyFeeRate: json['feeratebuy'].toDouble(),
      sellFeeRate: json['feeratesell'].toDouble(),
    );
  }
}

class PercentConfig {
  final int delistingTime;
  final int percentage;
  final int firstPrice;

  PercentConfig({
    required this.delistingTime,
    required this.percentage,
    required this.firstPrice,
  });

  factory PercentConfig.fromJson(Map<String, dynamic> json) {
    return PercentConfig(
      delistingTime: json['delistingtime'],
      percentage: json['pricepercentage'],
      firstPrice: json['firstprice'],
    );
  }
}

// 이벤트 정보 클래스
class EventClass {
  final String id;
  final String eventStart;
  final String eventEnd;
  final List<String> channel;
  final double multiplier;
  final String title;
  final String description;

  EventClass({
    required this.id,
    required this.eventStart,
    required this.eventEnd,
    required this.channel,
    required this.multiplier,
    required this.title,
    required this.description,
  });

  // JSON 데이터를 EventClass로 변환
  factory EventClass.fromJson(Map<String, dynamic> json) {
    return EventClass(
      id: json['id'],
      eventStart: json['eventstart'],
      eventEnd: json['eventend'],
      channel: List<String>.from(json['channel']),
      multiplier: (json['multiplier'] as num).toDouble(),
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventstart': eventStart,
      'eventend': eventEnd,
      'channel': channel,
      'multiplier': multiplier,
      'title': title,
      'description': description,
    };
  }
}

class NoticeClass {
  String title; // 내용
  String content; // 내용
  String uploadTime; // 공지사항 게시 날짜

  NoticeClass(this.title, this.content, this.uploadTime);

  // JSON 데이터를 NoticeClass로 변환하는 팩토리 메서드
  factory NoticeClass.fromJson(Map<String, dynamic> json) {
    List<String> lines = json['content'].split('\n');
    String content = lines.sublist(1).join('\n');
    String title = lines.isNotEmpty ? lines[0] : '';

    //날짜변환
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
    String uploadTime = DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(dateTime);

    return NoticeClass(title, content, uploadTime);
  }
}
