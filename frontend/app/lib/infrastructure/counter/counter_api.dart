import 'package:dio/dio.dart';

import '../../domain/counter/counter.dart';

class CounterApi {

  CounterApi(this._dio);
  final Dio _dio;

  Future<Counter> fetch() async {
    final res = await _dio.get('/counter');

    final dto = Counter.fromJson(
      res.data as Map<String, dynamic>,
    );

    return dto;
  }

  Future<Counter> increment() async {
    final res = await _dio.post('/counter/increment');

    final dto = Counter.fromJson(
      res.data as Map<String, dynamic>,
    );

    return dto;
  }

  Future<Counter> reset() async {
    final res = await _dio.post('/counter/reset');

    final dto = Counter.fromJson(
      res.data as Map<String, dynamic>,
    );

    return dto;
  }

  // 接続確認用（200 が返れば OK）
  Future<void>  ping({String? failCode}) async {
    final path = (failCode != null && failCode.isNotEmpty)
        ? '/ping?fail=$failCode'
        : '/ping';

    await _dio.get(path);
  }
}
