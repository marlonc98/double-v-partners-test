import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> logoutApiFake(String spKey) async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: spKey);
  await storage.delete(key: "${spKey}_email");
  return true;
}
