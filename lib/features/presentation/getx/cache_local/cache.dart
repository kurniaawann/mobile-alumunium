import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = 'token_reset_password';
  static const String _tokenUser = 'token_user';

  /// Simpan token Reset Password
  /// Simpan token
  static Future<void> saveTokenResetPassword(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenUser, token);
  }

  /// Ambil token
  static Future<String?> getTokenResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenUser);
  }

  /// Hapus token
  static Future<void> clearTokenResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenUser);
  }

  /// Cek apakah ada token
  static Future<bool> hasTokenResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenUser);
  }

  /// Simpan token
  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenUser, token);
  }

  /// Ambil token
  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenUser);
  }

  /// Hapus token
  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenUser);
  }

  /// Cek apakah ada token
  static Future<bool> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_tokenUser);
  }
}
