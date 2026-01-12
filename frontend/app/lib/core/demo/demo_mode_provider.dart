import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'demo_mode_store.dart';

final demoModeStoreProvider = Provider<DemoModeStore>((ref) {
  return DemoModeStore();
});
