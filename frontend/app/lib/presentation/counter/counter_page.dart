import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/app_boot/app_boot_notifier.dart';
import '../../application/app_boot/app_boot_state.dart';
import '../../application/counter/counter_notifier.dart';
import '../../application/counter/counter_state.dart';
import '../../core/demo/demo_mode_provider.dart';

class CounterPage extends ConsumerStatefulWidget {
  const CounterPage({super.key});

  @override
  ConsumerState<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends ConsumerState<CounterPage> {
  bool _fetchedOnce = false;

  @override
  Widget build(BuildContext context) {
    final boot = ref.watch(appBootProvider);
    final state = ref.watch(counterNotifierProvider);
    final isBusy = state is CounterLoading;
    final bootOk = boot is AppBootOk;

    // bootがOKになった瞬間にfetch（1回）
    ref.listen<AppBootState>(appBootProvider, (prev, next) async {
      final wasOk = prev is AppBootOk;
      final isOk = next is AppBootOk;

      // OKに切り替わった瞬間に一度だけfetch
      if (!wasOk && isOk && !_fetchedOnce) {
        _fetchedOnce = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(counterNotifierProvider.notifier).fetch();
        });
      }

      // bootがエラーに落ちたら、次に復帰した時また取れるように戻しておく
      if (next is AppBootError) {
        _fetchedOnce = false;
      }
    });

    // もし既にOKなら最初からfetch
    if (boot is AppBootOk && !_fetchedOnce) {
      _fetchedOnce = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(counterNotifierProvider.notifier).fetch();
      });
    }

    Widget counterBody;
    switch (state) {
      case CounterIdle():
        counterBody = const Text('Press Fetch');
        break;
      case CounterLoading():
        counterBody = const CircularProgressIndicator();
        break;
      case CounterData(value: final v):
        counterBody = Text('$v', style: Theme.of(context).textTheme.displayMedium);
        break;
      case CounterError(message: final m):
        counterBody = Text(
          m,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        );
        break;
    }

    Widget bootBanner;
    switch (boot) {
      case AppBootIdle():
        bootBanner = const SizedBox.shrink();
        break;
      case AppBootChecking():
        bootBanner = const _StatusBanner(text: 'API: checking...');
        break;
      case AppBootOk():
        bootBanner = const _StatusBanner(text: 'API: OK');
        break;
      case AppBootError(message: final m):
        bootBanner = _StatusBanner(text: 'API: ERROR - $m', isError: true);
        break;
    }

    Future<void> demoFailOn() async {
      // 503で boot error を発生させる
      await ref.read(demoModeStoreProvider).setPingFailCode('503');
      await ref.read(appBootProvider.notifier).check();
      // check()でAppBootErrorになれば、router redirectで /error へ
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              counterBody,
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: isBusy ? null : demoFailOn,
                child: const Text('デモ: 失敗ON(503)'),
              ),
              const SizedBox(height: 12),
              bootBanner,
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: (!bootOk || isBusy) ? null : () => ref.read(counterNotifierProvider.notifier).fetch(),
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(height: 24),
              const Text('本アプリは Flutter と Go(Echo) を用いた「技術サンプル」です。'),
              const SizedBox(height: 24),
              const Text('エラーページを見るにはlocal storage または IndexedDB に保存されている "client_id" を "00000000-0000-0000-0000-000000000000" に変更し、「デモ: 失敗ON」ボタンをクリックしてください。'),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () {
              ref.read(counterNotifierProvider.notifier).reset();
            },
            child: const Icon(Icons.exposure_zero),
          ),
        ],
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.text, this.isError = false});

  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Colors.red : Colors.green,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: isError ? Colors.red : Colors.green),
      ),
    );
  }
}