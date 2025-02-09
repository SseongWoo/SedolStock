import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 보유 주식 클래스
class OwnStock {
  int stockCount;
  int stockPrice;
  bool delisting;
  OwnStock(this.stockCount, this.stockPrice, this.delisting);
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
}

// 주식 정보 클래스
class ItemHistoryClass {
  String itemUID;
  String itemType;
  int itemPriceAvg;
  ItemHistoryClass(this.itemUID, this.itemType, this.itemPriceAvg);
}

class MessageClass {
  String itemUID;
  int stockCount;
  String time;
  MessageClass(this.itemUID, this.stockCount, this.time);
}

// 랭킹 데이터 클래스
class RankingDataClass {
  String uid;
  String name;
  String fandom;
  int rank;
  int totalMoney;

  RankingDataClass(
    this.uid,
    this.name,
    this.fandom,
    this.rank,
    this.totalMoney,
  );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'fandom': fandom,
        'rank': rank,
        'totalmoney': totalMoney,
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
  String uid;
  String channelType;
  int price;
  int totalViewCount;
  int totalLikeCount;
  int beforeTotalViewCount;
  int beforeTotalLikeCount;
  int beforePrice;
  int differencePrice;
  int delisting;
  int continuous;
  double ratio;

  ItemPriceDataClass(
      this.uid,
      this.channelType,
      this.price,
      this.totalViewCount,
      this.totalLikeCount,
      this.beforeTotalViewCount,
      this.beforeTotalLikeCount,
      this.beforePrice,
      this.differencePrice,
      this.delisting,
      this.continuous,
      this.ratio);
}

class TotalMoneyDataClass {
  int money;
  String date;

  TotalMoneyDataClass(this.money, this.date);
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
