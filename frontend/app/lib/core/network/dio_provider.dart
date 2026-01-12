import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env.dart';
import '../client_id/client_id_store.dart';

final clientIdStoreProvider = Provider<ClientIdStore>((ref) => ClientIdStore());

final clientIdProvider = FutureProvider<String>((ref) async {
  final store = ref.read(clientIdStoreProvider);
  return store.getOrCreate();
});

final dioProvider = FutureProvider<Dio>((ref) async {
  final clientId = await ref.watch(clientIdProvider.future);

  final dio = Dio(BaseOptions(
    baseUrl: Env.apiBaseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Authorization': 'Bearer $clientId',
      'Content-Type': 'application/json',
    },
  ));

  // ログ（開発用）
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  return dio;
});
