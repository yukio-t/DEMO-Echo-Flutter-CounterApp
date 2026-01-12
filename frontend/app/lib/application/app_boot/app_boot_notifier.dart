import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/demo/demo_mode_provider.dart';
import '../../core/network/dio_provider.dart';
import '../../core/network/error_formatter.dart';
import '../../infrastructure/counter/counter_api.dart';
import 'app_boot_state.dart';

final appBootProvider =
    NotifierProvider<AppBootNotifier, AppBootState>(AppBootNotifier.new);

class AppBootNotifier extends Notifier<AppBootState> {
  @override
  AppBootState build() => const AppBootState.idle();

  Future<void> check() async {
    state = const AppBootState.checking();
    try {
      final dio = await ref.read(dioProvider.future);
      final api = CounterApi(dio);

      // prefs の failCode を読む
      final failCode = await ref.read(demoModeStoreProvider).getPingFailCode();

      await api.ping(failCode: failCode);
      state = const AppBootState.ok();
      
    } catch (e) {
      state = AppBootState.error(message: toUiMessage(e));
    }
  }
}
