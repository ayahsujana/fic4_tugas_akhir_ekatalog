// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  final String tokenKey = 'token';

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(tokenKey) ?? '';
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(tokenKey);
  }
}
