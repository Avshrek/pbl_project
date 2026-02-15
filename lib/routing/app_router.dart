import 'package:flutter/material.dart';

import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/presentation/pages/case_list_page.dart';
import 'package:dfei_opus/features/chain_of_custody/presentation/pages/audit_log_page.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/pages/triage_dashboard_page.dart';
import 'package:dfei_opus/features/export/presentation/pages/export_page.dart';
import 'package:dfei_opus/features/silent_sniffer/presentation/pages/sniffer_page.dart';

/// Centralized named-route generation for the app.
class AppRouter {
  AppRouter._();

  static const String cases = '/';
  static const String triage = '/triage';
  static const String sniffer = '/sniffer';
  static const String audit = '/audit';
  static const String export = '/export';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case cases:
        return MaterialPageRoute<void>(
          builder: (_) => const CaseListPage(),
        );

      case triage:
        final CaseEntity caseEntity = settings.arguments! as CaseEntity;
        return MaterialPageRoute<void>(
          builder: (_) => TriageDashboardPage(caseEntity: caseEntity),
        );

      case sniffer:
        return MaterialPageRoute<void>(
          builder: (_) => const SnifferPage(),
        );

      case audit:
        final CaseEntity caseEntity = settings.arguments! as CaseEntity;
        return MaterialPageRoute<void>(
          builder: (_) => AuditLogPage(caseEntity: caseEntity),
        );

      case export:
        final CaseEntity caseEntity = settings.arguments! as CaseEntity;
        return MaterialPageRoute<void>(
          builder: (_) => ExportPage(caseEntity: caseEntity),
        );

      default:
        return MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

