import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_boot_state.freezed.dart';

@freezed
sealed class AppBootState with _$AppBootState {
  const factory AppBootState.idle() = AppBootIdle;
  const factory AppBootState.checking() = AppBootChecking;
  const factory AppBootState.ok() = AppBootOk;
  const factory AppBootState.error({required String message}) = AppBootError;
}
