import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureData {
  static const storage = FlutterSecureStorage();

  static Future writeSecureData(
          {required String key, required dynamic value}) async =>
      await storage.write(
        key: key,
        value: jsonEncode(value),
      );

  static Future readSecureData({required String key}) async {
    String? value = await storage.read(key: key);
    return value != null ? jsonDecode(value) : null;
  }

  static Future deleteSecureData({required String key}) async =>
      await storage.delete(key: key);

  static Future deleteAllSecureData() async => await storage.deleteAll();
}
