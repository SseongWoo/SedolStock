// import 'package:win32/win32.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// Size getPhysicalScreenSize() {
//   if (GetPlatform.isDesktop) {
//     final hdc = GetDC(0);
//     final width = GetDeviceCaps(hdc, GET_DEVICE_CAPS_INDEX.HORZRES);
//     final height = GetDeviceCaps(hdc, GET_DEVICE_CAPS_INDEX.VERTRES);
//     ReleaseDC(0, hdc);
//
//     return Size(width.toDouble(), height.toDouble());
//   } else {
//     throw UnsupportedError('This function is only supported on Windows');
//   }
// }
