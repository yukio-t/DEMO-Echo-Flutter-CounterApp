import 'package:dio/dio.dart';

String toUiMessage(Object error) {
  if (error is DioException) {
    final code = error.response?.statusCode;

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'タイムアウトしました。時間をおいて再試行してください。';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'サーバーに接続できません。';
    }

    if (code == 401) return '認証に失敗しました（clientId不正）。';
    if (code == 429) return 'リクエストが多すぎます。少し待って再試行してください。';
    if (code != null && code >= 500) return 'サーバーエラーが発生しました。';

    return '通信エラーが発生しました。';
  }

  return '予期しないエラーが発生しました。';
}
