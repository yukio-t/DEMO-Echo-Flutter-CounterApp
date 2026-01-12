import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/app_boot/app_boot_notifier.dart';
import '../../application/app_boot/app_boot_state.dart';
import '../../application/counter/counter_notifier.dart';
import '../../core/demo/demo_mode_provider.dart';

class BootErrorPage extends ConsumerWidget {
  const BootErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(appBootProvider);

    final message = switch (boot) {
      AppBootError(:final message) => message,
      _ => 'APIに接続できません。',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('接続エラー')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () async {
                  // 1) fail OFF
                  await ref.read(demoModeStoreProvider).setPingFailCode(null);
                  // 2) そのまま再チェック（ping）
                  await ref.read(appBootProvider.notifier).check();
                  // 3) counter fetch（okなら /counter に戻った時に表示が整う）
                  await ref.read(counterNotifierProvider.notifier).fetch();
                },
                child: const Text('デモ: 失敗OFF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
