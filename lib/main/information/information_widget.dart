import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:korean_profanity_filter/korean_profanity_filter.dart';
import 'package:stockpj/data/my_data.dart';
import 'package:stockpj/main/information/information_system.dart';
import 'package:stockpj/utils/format.dart';
import 'package:stockpj/utils/search_name.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/public_data.dart';
import '../../utils/color.dart';
import '../../utils/screen_size.dart';

class InformationMyWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  InformationMyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Obx(
              () => Container(
                height: _screenController.screenSize.value.getHeightPerSize(8),
                decoration:
                    BoxDecoration(color: fanColorMap[_myDataController.myChoicechannel.value]),
              ),
            ),
            Obx(
              () => Container(
                height: _screenController.screenSize.value.getHeightPerSize(11),
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: _screenController.screenSize.value.getHeightPerSize(1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _myDataController.myChoicechannel.value,
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                            color: fanColorMap[_myDataController.myChoicechannel.value]),
                      ),
                      Text(
                        _myDataController.myName.value,
                        style: TextStyle(
                            fontSize: _screenController.screenSize.value.getHeightPerSize(2)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: _screenController.screenSize.value.getHeightPerSize(2),
            ),
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(8),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: _screenController.screenSize.value.getHeightPerSize(0.5),
                  bottom: _screenController.screenSize.value.getHeightPerSize(0.5),
                ),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.grey, width: 0.25),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '전일 대비 자산 변동률',
                                style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.4),
                                ),
                              ),
                              Text(
                                '${_informationController.rate.toStringAsFixed(2)}%',
                                style: TextStyle(
                                    fontSize:
                                        _screenController.screenSize.value.getHeightPerSize(2),
                                    color: _informationController.rate.value > 0
                                        ? Colors.red
                                        : _informationController.rate.value < 0
                                            ? Colors.blue
                                            : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey, width: 0.25),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '랭킹',
                                style: TextStyle(
                                  fontSize:
                                      _screenController.screenSize.value.getHeightPerSize(1.4),
                                ),
                              ),
                              Text(
                                '${_myDataController.myRank.value != 0 ? _myDataController.myRank.value : '-'}',
                                style: TextStyle(
                                  fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(2),
              ),
              Obx(
                () => Container(
                  height: _screenController.screenSize.value.getHeightPerSize(10),
                  width: _screenController.screenSize.value.getHeightPerSize(10),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InformationPropertyWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  InformationPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1),
            _screenController.screenSize.value.getWidthPerSize(10),
            _screenController.screenSize.value.getHeightPerSize(1)),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '내 자산',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: _screenController.screenSize.value.getHeightPerSize(2.5),
                ),
              ),
              SizedBox(
                height: _screenController.screenSize.value.getHeightPerSize(1),
              ),
              PropertyRowWidget(
                title: '총 자산',
                value: formatToCurrency(_myDataController.myTotalMoney.value),
              ),
              PropertyRowWidget(
                title: '가용 자산',
                value: formatToCurrency(_myDataController.myMoney.value),
              ),
              PropertyRowWidget(
                title: '보유 주식 자산',
                value: formatToCurrency(_myDataController.myStockMoney.value),
              ),
              PropertyRowWidget(
                title: '보유 주식 종목 개수',
                value: '${_myDataController.myStockList.value} 종목',
              ),
              PropertyRowWidget(
                title: '보유 주식 개수',
                value: '${_myDataController.myStockCount.value} 주',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyRowWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final String title;
  final String value;
  PropertyRowWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorStelLiveDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
            color: colorStelLiveDark,
          ),
        ),
      ],
    );
  }
}

class InformationButtonWidget extends StatelessWidget {
  final String title;
  final Function function;
  const InformationButtonWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          function();
        },
      ),
    );
  }
}

Widget settingTitle(String title) {
  final ScreenController _screenController = Get.find<ScreenController>();
  return Padding(
    padding: EdgeInsets.only(left: _screenController.screenSize.value.getWidthPerSize(2)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
        ),
      ),
    ),
  );
}

Widget settingDivider() {
  final ScreenController screenController = Get.find<ScreenController>();
  return Divider(
    indent: screenController.screenSize.value.getWidthPerSize(4),
    endIndent: screenController.screenSize.value.getWidthPerSize(4),
    color: Colors.grey, // 경계선 색상
    thickness: 0.5, // 경계선 두께
    height: 0, // 경계선 위아래 여백
  );
}

class TradeDatailChartWidget extends StatefulWidget {
  const TradeDatailChartWidget({super.key});

  @override
  State<TradeDatailChartWidget> createState() => _TradeDatailChartWidgetState();
}

class _TradeDatailChartWidgetState extends State<TradeDatailChartWidget> {
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  final ScreenController _screenController = Get.find<ScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _screenController.screenSize.value.getHeightPerSize(60),
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Obx(
          () => SfCartesianChart(
            title: const ChartTitle(text: '내 자산 변동 그래프', alignment: ChartAlignment.near),
            primaryXAxis: const CategoryAxis(
              autoScrollingDelta: 5, // X축에서 5개의 데이터만 보여주고 나머지는 스크롤 가능
              autoScrollingMode: AutoScrollingMode.end, // 끝부분에서 스크롤
              isVisible: false,
            ),
            primaryYAxis: NumericAxis(
              minimum: _informationController.minValue.value.toDouble(),
              numberFormat: NumberFormat('#,##0'),
              interval: 1,
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true, // 팬(슬라이드) 기능 활성화
            ),
            //title: ChartTitle(text: 'Half yearly sales analysis'),
            //tooltipBehavior: _tooltipBehavior,

            series: <LineSeries<int, int>>[
              LineSeries<int, int>(
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  color: fanColorMap[_myDataController.myChoicechannel.value],
                  borderColor: Colors.white,
                  borderWidth: 1,
                  width: _screenController.screenSize.value.getHeightPerSize(1),
                  height: _screenController.screenSize.value.getHeightPerSize(1),
                ),
                dataSource: _myDataController.totalMoneyHistoryList, // List<int> 사용
                xValueMapper: (int value, int index) => index, // 인덱스를 x축 값으로 사용
                yValueMapper: (int value, _) => value, // 값 자체를 y축 값으로 사용
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                ),
                dataLabelMapper: (int value, _) => formatToCurrency(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StockPieChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  StockPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SfCircularChart(
        title: const ChartTitle(text: '보유 주식 비율', alignment: ChartAlignment.near),
        //legend: const Legend(isVisible: true),
        series: <PieSeries<StockListClass, String>>[
          PieSeries<StockListClass, String>(
            dataSource: _myDataController.stockListItem.isEmpty
                ? [StockListClass('', '보유 주식 없음', 0, 0, 1, 0, 0, 0, '', colorStelLive)]
                : _myDataController.stockListItem,
            xValueMapper: (StockListClass data, _) => data.stockName,
            yValueMapper: (StockListClass data, _) => data.stockCount,
            pointColorMapper: (StockListClass data, _) => data.color,
            dataLabelMapper: (StockListClass data, _) => _myDataController.stockListItem.isNotEmpty
                ? '${data.stockName} : ${data.stockCount}주'
                : data.stockName,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside, // 또는 inside
              textStyle:
                  TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
            ),
          ),
        ],
      ),
    );
  }
}

class MoneyPieChartWidget extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final InformationController _informationController = Get.find<InformationController>();
  MoneyPieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SfCircularChart(
        title: const ChartTitle(text: '보유 자산 비율', alignment: ChartAlignment.near),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <PieSeries<MoneyChartClass, String>>[
          PieSeries<MoneyChartClass, String>(
            dataSource: _informationController.moneyChartList,
            xValueMapper: (MoneyChartClass data, _) => data.name,
            yValueMapper: (MoneyChartClass data, _) => data.money,
            dataLabelMapper: (MoneyChartClass data, _) =>
                '${data.name} : ${formatToCurrency(data.money)}원',
            dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside, // 또는 inside
              textStyle:
                  TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.6)),
            ),
          ),
        ],
      ),
    );
  }
}

class NameChangeDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  NameChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('이름 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  '원래 이름 : ${_myDataController.myName}',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                  ),
                ),
              )),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Form(
            key: _informationController.formKey,
            child: TextFormField(
              controller: _informationController.controllerName,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(0.5)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 1,
              maxLength: 12,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value!.isEmpty) {
                  return '이름을 입력해주세요';
                }
                if (value.containsBadWords || _informationController.filter.hasProfanity(value)) {
                  return '부적절한 언어 사용은 허용되지 않습니다. 다시 입력해 주세요.';
                }
                if (_informationController.overlapName) {
                  return '이미 사용 중인 이름입니다. 다른 이름을 선택해 주세요.';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // 다이얼로그 닫기
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            EasyLoading.show(status: '중복 검사중');
            _informationController.overlapName =
                await searchName(_informationController.controllerName.text);

            if (!_informationController.overlapName &&
                _informationController.formKey.currentState!.validate()) {
              await _informationController.updateUserName();
              EasyLoading.dismiss();
            }
          },
          child: const Text('변경'),
        ),
      ],
    );
  }
}

class ChannelChangeDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  final InformationController _informationController = Get.find<InformationController>();
  ChannelChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('진영 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(
                  '원래 진영 : ${_myDataController.myChoicechannel}',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.6),
                  ),
                ),
              )),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (_informationController.dialogIndex.value <= 0) {
                    _informationController.dialogIndex.value = fanNameList.length - 1;
                  } else {
                    _informationController.dialogIndex.value--;
                  }
                },
                icon: Icon(
                  Icons.arrow_left,
                  size: _screenController.screenSize.value.getHeightPerSize(5),
                ),
              ),
              Expanded(
                child: Center(
                    child: Obx(
                  () => Text(
                    fanNameList[_informationController.dialogIndex.value],
                    style: TextStyle(
                      color: fanColorMap[fanNameList[_informationController.dialogIndex.value]],
                      fontSize: _screenController.screenSize.value.getHeightPerSize(3),
                    ),
                  ),
                )),
              ),
              IconButton(
                onPressed: () {
                  if (_informationController.dialogIndex.value >= fanNameList.length - 1) {
                    _informationController.dialogIndex.value = 0;
                  } else {
                    _informationController.dialogIndex.value++;
                  }
                },
                icon: Icon(
                  Icons.arrow_right,
                  size: _screenController.screenSize.value.getHeightPerSize(5),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // 다이얼로그 닫기
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            EasyLoading.show(status: '등록중');
            if (fanNameList[_informationController.dialogIndex.value] !=
                _myDataController.myChoicechannel.value) {
              await _informationController.updateFanName();
            } else {
              EasyLoading.dismiss();
              Get.back();
            }
          },
          child: const Text('변경'),
        ),
      ],
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final PublicDataController _publicDataController = Get.find<PublicDataController>();
  LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('로그아웃'),
      content: Text(
        '로그아웃하시겠습니까?',
        style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            _publicDataController.logOut();
          },
          child: const Text('로그아웃'),
        ),
      ],
    );
  }
}

class ChangePWDialog extends StatelessWidget {
  final ScreenController _screenController = Get.find<ScreenController>();
  final MyDataController _myDataController = Get.find<MyDataController>();
  ChangePWDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('비밀번호 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '비밀번호 변경 안내 이메일이 아래 주소로 발송되었습니다.',
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(1.8),
            ),
          ),
          SizedBox(
            height: _screenController.screenSize.value.getHeightPerSize(1),
          ),
          Text(
            _myDataController.myId.string,
            style: TextStyle(
              fontSize: _screenController.screenSize.value.getHeightPerSize(2),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
