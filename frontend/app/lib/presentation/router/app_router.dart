import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../boot/boot_error_page.dart';
import '../counter/counter_page.dart';
import '../../application/app_boot/app_boot_state.dart';
import '../../application/app_boot/app_boot_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // Riverpod state変化でGoRouterをrefreshさせるための簡易notifier
  final refresh = ValueNotifier<int>(0);
  ref.listen<AppBootState>(appBootProvider, (_, __) => refresh.value++);

  return GoRouter(
    initialLocation: '/counter',
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: '/counter',
        builder: (context, state) => const CounterPage(),
      ),
      GoRoute(
        path: '/error',
        builder: (context, state) => const BootErrorPage(),
      ),
    ],
    redirect: (context, state) {
      final boot = ref.read(appBootProvider);
      final goingError = state.matchedLocation == '/error';

      // bootが未チェック/チェック中は counter 側でローディング表示でもOK
      if (boot is AppBootError) {
        return goingError ? null : '/error';
      }

      // error以外（idle/checking/ok）は counter を許可
      if (goingError) return '/counter';

      return null;
    },
  );
});
