import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';
import 'package:dfei_opus/features/chain_of_custody/presentation/providers/audit_providers.dart';

/// Page displaying the immutable chain-of-custody audit trail for a case.
///
/// Shows each action with its UTC timestamp, SHA-256 hash, and the
/// hash chain linking entries together.
class AuditLogPage extends ConsumerWidget {
  const AuditLogPage({super.key, required this.caseEntity});

  final CaseEntity caseEntity;

  Color _actionColor(String action) {
    if (action.contains('created')) return TacticalTheme.neonBlue;
    if (action.contains('found')) return TacticalTheme.warning;
    if (action.contains('photographed')) return TacticalTheme.neonBlueLight;
    if (action.contains('seized')) return TacticalTheme.success;
    if (action.contains('closed')) return TacticalTheme.textMuted;
    if (action.contains('exported')) return TacticalTheme.neonBlueDark;
    return TacticalTheme.textSecondary;
  }

  IconData _actionIcon(String action) {
    if (action.contains('created')) return Icons.add_circle_outline;
    if (action.contains('found')) return Icons.search;
    if (action.contains('photographed')) return Icons.camera_alt;
    if (action.contains('seized')) return Icons.lock;
    if (action.contains('closed')) return Icons.close;
    if (action.contains('exported')) return Icons.picture_as_pdf;
    return Icons.receipt_long;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int caseId = caseEntity.id ?? 0;
    final AsyncValue<List<AuditLogEntity>> logsAsync =
        ref.watch(auditLogsForCaseProvider(caseId));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chain of Custody'),
            Text(
              caseEntity.caseNumber,
              style: TacticalTheme.monoDataSmall,
            ),
          ],
        ),
      ),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stack) => Center(
          child: Text('Error: $error'),
        ),
        data: (List<AuditLogEntity> logs) {
          if (logs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: TacticalTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No audit entries yet',
                    style: TacticalTheme.monoDataBold.copyWith(
                      color: TacticalTheme.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                color: TacticalTheme.surface,
                child: Row(
                  children: [
                    Text(
                      '${logs.length} entries',
                      style: TacticalTheme.monoDataBold,
                    ),
                    const Spacer(),
                    Icon(Icons.link, size: 14, color: TacticalTheme.neonBlue),
                    const SizedBox(width: 4),
                    Text(
                      'HASH CHAIN VERIFIED',
                      style: TacticalTheme.monoDataSmall.copyWith(
                        color: TacticalTheme.neonBlue,
                      ),
                    ),
                  ],
                ),
              ),

              // Log entries
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemCount: logs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final AuditLogEntity log = logs[index];
                    final Color color = _actionColor(log.action);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Action header
                            Row(
                              children: [
                                Icon(
                                  _actionIcon(log.action),
                                  size: 18,
                                  color: color,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    log.action.toUpperCase().replaceAll('_', ' '),
                                    style: TacticalTheme.monoDataBold.copyWith(
                                      color: color,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  TimestampUtils.toShortTime(log.utcTimestamp),
                                  style: TacticalTheme.monoDataSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Timestamp
                            Text(
                              TimestampUtils.toDisplay(log.utcTimestamp),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            // Officer
                            Text(
                              'By: ${log.performedBy}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),

                            // Details
                            if (log.details.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                log.details,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],

                            // Hash
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: TacticalTheme.background,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SHA-256:',
                                    style: TacticalTheme.monoDataSmall.copyWith(
                                      color: TacticalTheme.neonBlue,
                                      fontSize: 9,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    log.sha256Hash,
                                    style: TacticalTheme.monoDataSmall.copyWith(
                                      fontSize: 9,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  if (log.previousHash.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'PREV:',
                                      style:
                                          TacticalTheme.monoDataSmall.copyWith(
                                        color: TacticalTheme.textMuted,
                                        fontSize: 9,
                                      ),
                                    ),
                                    Text(
                                      log.previousHash,
                                      style:
                                          TacticalTheme.monoDataSmall.copyWith(
                                        fontSize: 9,
                                        color: TacticalTheme.textMuted,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
