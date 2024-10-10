import 'package:flutter/material.dart';

import '../../utils/screen_size.dart';
import 'package:get/get.dart';

import 'home_system.dart';

class HomeMyDataWidget extends StatelessWidget {
  final ScreenController _screenController = Get.put(ScreenController());
  HomeMyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Card(
      color: Colors.white,
      // height: _screenController.screenSize.value.getHeightPerSize(12),
      // width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: _screenController.screenSize.value.getHeightPerSize(10),
              width: _screenController.screenSize.value.getHeightPerSize(10),
              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: Center(child: const Text('프사')),
            ),
            SizedBox(
              width: _screenController.screenSize.value.getWidthPerSize(4),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '닉네임',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(2),
                  ),
                ),
                Text(
                  '총 자산',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                  ),
                ),
                Text(
                  '가용 자산',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                  ),
                ),
                Text(
                  '보유 주식 자산 : 100,000,000,000',
                  style: TextStyle(
                    fontSize: _screenController.screenSize.value.getHeightPerSize(1.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeStockDataListWidget extends StatelessWidget {
  final String titleText;
  HomeStockDataListWidget({super.key, required this.titleText});

  final ScreenController _screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) {
    _screenController.updateScreenSize(context);
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(_screenController.screenSize.value.getHeightPerSize(1)),
            child: Text(
              titleText,
              style: TextStyle(fontSize: _screenController.screenSize.value.getHeightPerSize(1.8)),
            ),
          ),
          SizedBox(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.photo, size: 50),
                  title: Text('Card Title'),
                  subtitle: Text('This is a subtitle'),
                  trailing: Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.photo, size: 50),
                  title: Text('Card Title'),
                  subtitle: Text('This is a subtitle'),
                ),
                ListTile(
                  leading: Icon(Icons.photo, size: 50),
                  title: Text('Card Title'),
                  subtitle: Text('This is a subtitle'),
                ),
                ListTile(
                  leading: Icon(Icons.photo, size: 50),
                  title: Text('Card Title'),
                  subtitle: Text('This is a subtitle'),
                ),
                ListTile(
                  leading: Icon(Icons.photo, size: 50),
                  title: Text('Card Title'),
                  subtitle: Text('This is a subtitle'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
