import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String?> getSavedEmailApiImpl(String spKey) async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: "${spKey}_email");
}
