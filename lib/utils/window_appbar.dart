import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

class CustomWindowApp extends StatelessWidget {
  const CustomWindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomWindowScreen(),
    );
  }
}

class CustomWindowScreen extends StatelessWidget {
  final List<String> resolutions = [
    'HD (1280x720)',
    'FHD (1920x1080)',
    'QHD (2560x1440)',
    'UHD (3840x2160)'
  ];
  final Map<String, Size> resolutionSizes = {
    'HD (1280x720)': const Size(1280, 720),
    'FHD (1920x1080)': const Size(1920, 1080),
    'QHD (2560x1440)': const Size(2560, 1440),
    'UHD (3840x2160)': const Size(3840, 2160),
  };

  @override
  Widget build(BuildContext context) {
    String selectedResolution = 'FHD (1920x1080)'; // 기본 해상도

    return Scaffold(
      body: Column(
        children: [
          // 커스텀 상단바
          Container(
            height: 40,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 타이틀 영역
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Custom Window',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                // 드롭다운 메뉴 및 버튼
                Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedResolution,
                      dropdownColor: Colors.white,
                      underline: const SizedBox(),
                      style: const TextStyle(color: Colors.black),
                      items: resolutions.map((String resolution) {
                        return DropdownMenuItem<String>(
                          value: resolution,
                          child: Text(resolution),
                        );
                      }).toList(),
                      onChanged: (String? newValue) async {
                        if (newValue != null) {
                          selectedResolution = newValue;
                          final Size? size = resolutionSizes[newValue];
                          if (size != null) {
                            await DesktopWindow.setWindowSize(size);
                          }
                        }
                      },
                    ),
                    // 최소화 버튼
                    IconButton(
                      icon: const Icon(Icons.minimize, color: Colors.white),
                      onPressed: () {
                        //DesktopWindow.minimizeWindow();
                      },
                    ),
                    // 닫기 버튼
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        //DesktopWindow.closeWindow();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 나머지 본문
          Expanded(
            child: Center(
              child: Text(
                '해상도를 선택하세요!',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
