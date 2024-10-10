import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/main/trade/detail/trade_detail_system.dart';
import '../../../utils/screen_size.dart';

final ScreenController _screenController = Get.put(ScreenController());

class TradeDatailChartWidget extends StatefulWidget {
  const TradeDatailChartWidget({super.key});

  @override
  State<TradeDatailChartWidget> createState() => _TradeDatailChartWidgetState();
}

class _TradeDatailChartWidgetState extends State<TradeDatailChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenController.screenSize.value.getHeightPerSize(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '종목 가격',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(3),
              ),
            ),
            Text(
              '등락값',
              style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TradeDetailMyStock extends StatelessWidget {
  const TradeDetailMyStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: _screenController.screenSize.value.getHeightPerSize(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '보유 주식',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(3),
              ),
            ),
            ListTile(
              title: Text(
                '1주 평균',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              trailing: Text(
                '1000원',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
            ),
            ListTile(
              title: Text(
                '보유 수량',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              trailing: Text(
                '1주',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
            ),
            ListTile(
              title: Text(
                '총 금액',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '1000원',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '-300(70%)',
                    style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TradeDetailVideoListWidget extends StatelessWidget {
  const TradeDetailVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: _screenController.screenSize.value.getHeightPerSize(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.1, offset: Offset(0, 0)),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오늘의 영상',
              style: TextStyle(
                fontSize: _screenController.screenSize.value.getHeightPerSize(3),
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo, size: 50),
              title: Text(
                '영상 제목',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              subtitle: Text(
                '조회수 1.2만, 좋아요 1000, 댓글 100',
                style:
                    TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.2)),
              ),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
            ),
            ListTile(
              leading: Icon(Icons.photo, size: 50),
              title: Text(
                '영상 제목',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              subtitle: Text(
                '조회수 1.2만, 좋아요 1000, 댓글 100',
                style:
                    TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.2)),
              ),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
            ),
            ListTile(
              leading: Icon(Icons.photo, size: 50),
              title: Text(
                '영상 제목',
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
                ),
              ),
              subtitle: Text(
                '조회수 1.2만, 좋아요 1000, 댓글 100',
                style:
                    TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.2)),
              ),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
            ),
          ],
        ),
      ),
    );
  }
}

class TradeDetailButtonWidget extends StatelessWidget {
  final TradeDetailController _tradeDetailController = Get.put(TradeDetailController());
  TradeDetailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: _screenController.screenSize.value.getWidthPerSize(4),
          right: _screenController.screenSize.value.getWidthPerSize(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
                  ),
                ),
                onPressed: () {
                  _tradeDetailController.goTransaction(false);
                },
                child: Text(
                  '판매하기',
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: _screenController.screenSize.value.getWidthPerSize(4),
          ),
          Expanded(
            child: SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
                  ),
                ),
                onPressed: () {
                  _tradeDetailController.goTransaction(true);
                },
                child: Text(
                  '구매하기',
                  style: TextStyle(
                      fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
