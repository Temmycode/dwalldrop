import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefrenceService {
  // SET

  static cacheUsername({required String username}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
  }

  static cacheUserEmail({required String email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
  }

  static setIsLoggedIn({required bool isLoggedIn}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isloggedin', isLoggedIn);
  }

  // GET

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isloggedin') ?? false;
  }
}
