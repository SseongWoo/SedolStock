import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stockpj/utils/get_env.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../widget/simple_widget.dart';

class HttpService {
  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$httpURL$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  // GET 요청
  Future<http.Response> getRequest(String endpoint) async {
    final response = await http.get(
      Uri.parse('$httpURL$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> deleteRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.delete(
      Uri.parse('$httpURL$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> putRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$httpURL$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<void> openUrl(String url, String errorMessage) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showSimpleDialog(Get.back, '이동 실패', errorMessage);
    }
  }
}
