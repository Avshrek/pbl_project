import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/auth/presentation/pin_auth_page.dart';
import 'package:dfei_opus/features/auth/providers/auth_provider.dart';
import 'package:dfei_opus/features/case_management/presentation/pages/case_list_page.dart';
import 'package:dfei_opus/routing/app_router.dart';

/// Root application widget.
///
/// Wraps the app in [ProviderScope] and applies the tactical dark theme.
/// Routes through the auth gate — if unauthenticated, shows the PIN
/// page; otherwise shows the case list / dashboard.
class DfeiApp extends ConsumerWidget {
  const DfeiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState auth = ref.watch(authProvider);

    return MaterialApp(
      title: 'DFEI',
      debugShowCheckedModeBanner: false,
      theme: TacticalTheme.darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
      home: _resolveHome(auth),
    );
  }

  Widget _resolveHome(AuthState auth) {
    switch (auth.status) {
      case AuthStatus.unknown:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthStatus.authenticated:
        return const CaseListPage();
      case AuthStatus.unauthenticated:
      case AuthStatus.firstTime:
        return const PinAuthPage();
    }
  }
}
