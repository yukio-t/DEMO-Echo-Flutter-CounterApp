import 'package:shared_preferences/shared_preferences.dart';

class DemoModeStore {
  static const _keyPingFail = 'demo_ping_fail_code'; // 例: "503", "404"

  Future<String?> getPingFailCode() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_keyPingFail);
    if (v == null || v.isEmpty) return null;
    return v;
  }

  Future<void> setPingFailCode(String? code) async {
    final prefs = await SharedPreferences.getInstance();
    if (code == null || code.isEmpty) {
      await prefs.remove(_keyPingFail);
    } else {
      await prefs.setString(_keyPingFail, code);
    }
  }
}
