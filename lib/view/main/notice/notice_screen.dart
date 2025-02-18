import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockpj/widget/KeyBoardMouseEvent.dart';
import '../../../model/data/data_class.dart';
import '../../../utils/screen_size.dart';
import '../../../viewmodel/notice_view_model.dart';

// 이벤트 화면
class NoticeScreen extends StatelessWidget {
  final NoticeViewModel _viewModel = Get.put(NoticeViewModel());
  NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = _viewModel.screenController.screenSize.value;
    return keyBoardMouseEvent(
      child: Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '공지사항',
            style: TextStyle(fontSize: screenSize.getHeightPerSize(2.5)),
          ),
        ),
        body: Obx(
          () {
            final noticeList = _viewModel.publicDataController.noticeList;
            return noticeList.isNotEmpty
                ? ListView.builder(
                    itemCount: noticeList.length,
                    itemBuilder: (context, index) {
                      final notice = noticeList[index];
                      return _noticeListItemWidget(screenSize, notice);
                    },
                  )
                : const Center(
                    child: Text('등록된 공지사항이 없습니다.'),
                  );
          },
        ),
      ),
    );
  }

  // 이벤트 리스트 아이템 위젯
  Widget _noticeListItemWidget(ScreenSize screenSize, NoticeClass noticeItem) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: Padding(
        padding: EdgeInsets.all(screenSize.getHeightPerSize(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              noticeItem.title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(2.2), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            Text(
              noticeItem.content,
              style: TextStyle(
                fontSize: screenSize.getHeightPerSize(1.8),
              ),
            ),
            SizedBox(
              height: screenSize.getHeightPerSize(1),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                noticeItem.uploadTime,
                style: TextStyle(
                  fontSize: screenSize.getHeightPerSize(1.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
