import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_state.freezed.dart';

@freezed
sealed class CounterState with _$CounterState {
  const factory CounterState.idle() = CounterIdle;
  const factory CounterState.loading() = CounterLoading;
  const factory CounterState.data({required int value}) = CounterData;
  const factory CounterState.error({required String message}) = CounterError;
}
