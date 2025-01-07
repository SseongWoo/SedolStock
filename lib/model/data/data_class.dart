import 'package:flutter/material.dart';

import '../main/trade_model.dart';

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
  String tradetime;
  int tradePrice;
  int profit;
  double ratio;

  TradeHistoryClass({
    required this.itemuid,
    required this.itemtype,
    required this.itemcount,
    required this.transactionprice,
    required this.type,
    required this.tradetime,
    required this.tradePrice,
    required this.profit,
    required this.ratio,
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
  String name;
  String choiceChannel;
  int rank;
  int beforeRank;
  int totalMoney;

  RankingDataClass(
    this.name,
    this.choiceChannel,
    this.rank,
    this.beforeRank,
    this.totalMoney,
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'choicechannel': choiceChannel,
        'rank': rank,
        'beforerank': beforeRank,
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
      json['name']?.toString() ?? '',
      json['choicechannel']?.toString() ?? '',
      json['rank'] ?? 0,
      json['beforerank'] ?? 0,
      totalMoney!,
    );
  }
}

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

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'birthday': birthday,
        'description': description,
        'subscribercount': subscribercount,
      };

  // JSON을 객체로 변환
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

// 차트에 사용될 주식 데이터 리스트 클래스
class YoutubeChartDataClass {
  List<SalesData> commentCount;
  List<SalesData> likeCount;
  List<SalesData> viewCount;

  YoutubeChartDataClass(this.commentCount, this.likeCount, this.viewCount);
}
//
// // 채널의 가격 데이터 클래스
// class YoutubeLiveDataClass {
//   int differenceCommentCount;
//   int differenceLikeCount;
//   int differenceViewCount;
//   int lastDifferenceCommentCount;
//   int lastDifferenceLikeCount;
//   int lastDifferenceViewCount;
//   int lastTotalCommentCount;
//   int lastTotalLikeCount;
//   int lastTotalViewCount;
//   int totalCommentCount;
//   int totalLikeCount;
//   int totalViewCount;
//   int lastCommentCountPrice;
//   int lastViewCountPrice;
//   int lastLikeCountPrice;
//   int commentCountPrice;
//   int likeCountPrice;
//   int viewCountPrice;
//   int viewDelisting;
//   int likeDelisting;
//   int commentDelisting;
//   String updateTime;
//
//   YoutubeLiveDataClass(
//       this.differenceCommentCount,
//       this.differenceLikeCount,
//       this.differenceViewCount,
//       this.lastDifferenceCommentCount,
//       this.lastDifferenceLikeCount,
//       this.lastDifferenceViewCount,
//       this.lastTotalCommentCount,
//       this.lastTotalLikeCount,
//       this.lastTotalViewCount,
//       this.totalCommentCount,
//       this.totalLikeCount,
//       this.totalViewCount,
//       this.lastCommentCountPrice,
//       this.lastViewCountPrice,
//       this.lastLikeCountPrice,
//       this.commentCountPrice,
//       this.likeCountPrice,
//       this.viewCountPrice,
//       this.viewDelisting,
//       this.likeDelisting,
//       this.commentDelisting,
//       this.updateTime,
//       );
// }

class ItemPriceDataClass {
  String type;
  String uid;
  int totalCount;
  int price;
  int beforeTotalCount;
  int beforePrice;
  int delisting;
  int differencePrice;
  int subTotalCount;
  int subBeforeTotalCount;
  double ratio;

  ItemPriceDataClass(
      this.uid,
      this.type,
      this.price,
      this.totalCount,
      this.beforePrice,
      this.beforeTotalCount,
      this.delisting,
      this.differencePrice,
      this.ratio,
      this.subTotalCount,
      this.subBeforeTotalCount);
}

class TotalMoneyDataClass {
  int money;
  String date;

  TotalMoneyDataClass(this.money, this.date);
}
