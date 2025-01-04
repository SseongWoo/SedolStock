import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../data/youtube_data.dart';
import '../utils/date_time.dart';
import '../utils/screen_size.dart';

Widget buildVideoItem(
    ScreenSize screenSize, YoutubeVideoDataClass videoData, int index, Function(int) onPressed) {
  return SizedBox(
    height: screenSize.getHeightPerSize(12),
    width: double.infinity,
    child: Row(
      children: [
        SizedBox(
          height: screenSize.getHeightPerSize(10),
          width: screenSize.getHeightPerSize(16),
          child: Image.network(
            videoData.thumbnail,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Image.asset('assets/image/image_error.png'));
            },
          ),
        ),
        SizedBox(width: screenSize.getWidthPerSize(2)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                videoData.title,
                minFontSize: 10,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: screenSize.getHeightPerSize(1.8)),
              ),
              Text(
                videoData.channelName != ''
                    ? videoData.channelName
                    : formatDateString(videoData.publishedAt),
                style: TextStyle(fontSize: screenSize.getHeightPerSize(1.5)),
              ),
            ],
          ),
        ),
        SizedBox(
          width: screenSize.getWidthPerSize(10),
          child: IconButton(
            onPressed: () => onPressed(index),
            icon: const Icon(Icons.play_arrow, color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
