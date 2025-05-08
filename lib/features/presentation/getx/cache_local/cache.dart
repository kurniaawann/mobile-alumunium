import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenResetPassword = 'token_reset_password';
  static const String _tokenUser = 'token_user';
  static const String _role = 'role';

  /// Simpan token Reset Password
  /// Simpan token
  static Future<void> saveTokenResetPassword(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenResetPassword, token);
  }

  /// Ambil token
  static Future<String?> getTokenResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenResetPassword);
  }

  /// Hapus token
  static Future<void> clearTokenResetPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenResetPassword);
  }

  /// Simpan token
  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenUser, token);
  }

  /// Ambil token
  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenUser);
  }

  /// Hapus token
  static Future<void> clearUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenUser);
  }

  static Future<void> saveRole(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_role, token);
  }

  static Future<void> deleteRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_role);
  }

  static Future<String?> getRoleUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenUser);
  }
}
