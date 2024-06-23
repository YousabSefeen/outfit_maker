import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future saveToShared({required String key, required String value}) async {
    await prefs!.setString(key, value);
  }

  static Future setToken(String value) async {
    await prefs!.setString("token", value);
  }

  static getToken() {
    return prefs!.get("token");
  }


  static getFromShared(String key) {
    return prefs!.get(key);
  }

  static Future<bool?> removeFromShared(String key) async {
    return await prefs?.remove(key);
  }


  static removeAll() async {
    await prefs?.clear();
  }
}
