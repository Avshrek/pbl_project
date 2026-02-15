import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';
import 'package:dfei_opus/features/chain_of_custody/data/repositories/audit_repository_impl.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';

/// Audit repository provider.
final auditRepositoryProvider = Provider<AuditRepository>((ref) {
  return AuditRepositoryImpl(ref.watch(databaseProvider));
});

/// Watch audit logs for a specific case.
final auditLogsForCaseProvider =
    StreamProvider.family<List<AuditLogEntity>, int>((ref, caseId) {
  final AuditRepository repo = ref.watch(auditRepositoryProvider);
  return repo.watchAuditLogsForCase(caseId);
});
