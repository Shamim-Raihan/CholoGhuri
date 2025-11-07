import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService {
  static const _keyToken = 'auth_token';
  static const _keyName = 'auth_name';
  static const _keyRole = 'auth_role';

  Future<void> saveAuth({
    required String token,
    required String name,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyRole, role);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<Map<String, String?>> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_keyToken),
      'name': prefs.getString(_keyName),
      'role': prefs.getString(_keyRole),
    };
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyName);
    await prefs.remove(_keyRole);
  }
}
