import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/app_boot/app_boot_notifier.dart';
import '../../../application/app_boot/app_boot_state.dart';
import '../../../core/demo/demo_mode_provider.dart';

class AppBootstrapper extends ConsumerStatefulWidget {
  const AppBootstrapper({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends ConsumerState<AppBootstrapper> {
  // dart-define（未指定なら空文字）
  static const String _demoPingFail = String.fromEnvironment('DEMO_PING_FAIL');

  static const _demoInitKey = 'demo_ping_fail_initialized';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // デモ fail の初期セット（初回のみ）
      if (_demoPingFail.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        final initialized = prefs.getBool(_demoInitKey) ?? false;

        if (!initialized) {
          // 初回だけ demo fail を保存
          await ref
              .read(demoModeStoreProvider)
              .setPingFailCode(_demoPingFail);

          await prefs.setBool(_demoInitKey, true);
        }
      }

      // 通常の boot check
      final boot = ref.read(appBootProvider);
      if (boot is AppBootIdle) {
        await ref.read(appBootProvider.notifier).check();
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
