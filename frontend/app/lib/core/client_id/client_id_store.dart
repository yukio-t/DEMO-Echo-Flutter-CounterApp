import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ClientIdStore {
  static const _key = 'client_id';
  static const _uuid = Uuid();

  // デモ用 clientId（dart-define から受け取る）
  static const String? _demoClientId = String.fromEnvironment('DEMO_CLIENT_ID');

  Future<String> getOrCreate() async {
    // DEMO_CLIENT_ID が指定されていたら使う
    if (_demoClientId != null && _demoClientId!.isNotEmpty) {
      return _demoClientId!;
    }

    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing != null && existing.isNotEmpty) return existing;

    final created = _uuid.v4();
    await prefs.setString(_key, created);
    return created;
  }
}
