

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;


  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  static Future setToken(String token) async {
    await _prefs?.setString("access_token", token);
  }

  static String? getToken() {
    return _prefs?.getString("access_token");
  }

  static Future clearToken() async {
    await _prefs?.remove("access_token");
  }


  static Future setUsername(String username) async {
    await _prefs?.setString("username", username);
  }

  static String? getUsername() {
    return _prefs?.getString("username");
  }

  static Future setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  static Future setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int getInt(String key) {
    return _prefs?.getInt(key) ?? 0;
  }

  static Future clearAll() async {
    await _prefs?.clear();
  }
}