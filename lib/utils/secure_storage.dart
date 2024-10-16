import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 토큰을 안전하게 저장하기 위한 보안 저장소
const storage = FlutterSecureStorage();

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setTokens(String accessToken, String refreshToken, String uid) async {
  await storage.write(key: 'accessToken', value: accessToken);
  await storage.write(key: 'refreshToken', value: refreshToken);
  await storage.write(key: 'uid', value: uid);
}

Future<void> setIdToken(String idTiken) async {
  await storage.write(key: 'idTiken', value: idTiken);
}

Future<void> setAccessToken(String accessToken) async {
  await storage.write(key: 'accessToken', value: accessToken);
}

Future<void> setUid(String uid) async {
  await storage.write(key: 'uid', value: uid);
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getIdToken() async {
  return await storage.read(key: 'idToken');
}

// accessToken을 보안 저장소에서 읽어오는 함수
Future<String?> getAccessToken() async {
  return await storage.read(key: 'accessToken');
}

// refreshToken을 보안 저장소에서 읽어오는 함수
Future<String?> getRefreshToken() async {
  return await storage.read(key: 'refreshToken');
}

// accessToken을 보안 저장소에서 읽어오는 함수
Future<String?> getUID() async {
  return await storage.read(key: 'uid');
}

// 보안 저장소에서 모든 데이터를 삭제하는 함수
Future<void> clearTokens() async {
  await storage.deleteAll();
}

// 보안 저장소에 토큰을 저장하는 함수
Future<void> setIDPW(String id, String pw) async {
  await storage.write(key: 'id', value: id);
  await storage.write(key: 'pw', value: pw);
}

// 보안 저장소에 토큰을 저장하는 함수
Future<Map<String, String>> getIDPW() async {
  String id = '', pw = '';
  id = (await storage.read(key: 'id'))!;
  pw = (await storage.read(key: 'pw'))!;

  return {'id': id, 'pw': pw};
}

Future<void> deleteIDPW() async {
  await storage.delete(key: 'id');
  await storage.delete(key: 'pw');
}
