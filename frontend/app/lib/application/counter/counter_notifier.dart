import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_provider.dart';
import '../../core/network/error_formatter.dart';
import '../../infrastructure/counter/counter_api.dart';
import 'counter_state.dart';

final counterNotifierProvider = NotifierProvider<CounterNotifier, CounterState>(CounterNotifier.new);

class CounterNotifier extends Notifier<CounterState> {
  @override
  CounterState build() => const CounterState.idle();
  bool get _isBusy => state is CounterLoading;

  Future<CounterApi> _api() async {
    final dio = await ref.read(dioProvider.future);
    return CounterApi(dio);
  }

  Future<void> fetch() async {
    if (_isBusy) return;

    state = const CounterState.loading();

    try {
      final api = await _api();
      final counter = await api.fetch();
      state = CounterState.data(value: counter.value);
    } catch (e) {
      state = CounterState.error(message: toUiMessage(e));
    }
  }

  Future<void> increment() async {
    if (_isBusy) return;

    state = const CounterState.loading();

    try {
      final api = await _api();
      final counter = await api.increment();
      state = CounterState.data(value: counter.value); // ←レスポンスで確定（楽観更新なし）
    } catch (e) {
      state = CounterState.error(message: toUiMessage(e));
    }
  }

  Future<void> reset() async {
    if (_isBusy) return;

    state = const CounterState.loading();
    
    try {
      final api = await _api();
      final counter = await api.reset();
      state = CounterState.data(value: counter.value);
    } catch (e) {
      state = CounterState.error(message: toUiMessage(e));
    }
  }
}
