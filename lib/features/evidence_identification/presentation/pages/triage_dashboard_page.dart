import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/core/utils/hash_utils.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';
import 'package:dfei_opus/features/chain_of_custody/presentation/providers/audit_providers.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/pages/scene_input_page.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/providers/evidence_providers.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/widgets/evidence_action_card.dart';

/// The Active Case Dashboard — the primary operational screen.
///
/// Displays a volatility-sorted list of evidence items with action
/// buttons for progressing through the evidence lifecycle. Critical
/// items ("Volatility Countdown") appear at the top.
class TriageDashboardPage extends ConsumerStatefulWidget {
  const TriageDashboardPage({super.key, required this.caseEntity});

  final CaseEntity caseEntity;

  @override
  ConsumerState<TriageDashboardPage> createState() =>
      _TriageDashboardPageState();
}

class _TriageDashboardPageState extends ConsumerState<TriageDashboardPage> {
  int? _expandedIndex;

  Future<void> _handleStatusChange(
    EvidenceEntity evidence,
    String newStatus,
  ) async {
    final int? itemId = evidence.id;
    if (itemId == null) return;

    // Update evidence status.
    await ref
        .read(evidenceRepositoryProvider)
        .updateEvidenceStatus(itemId, newStatus);

    // Log to chain of custody.
    final String action = newStatus == 'photographed'
        ? AppConstants.actionItemPhotographed
        : AppConstants.actionItemSeized;

    final DateTime now = TimestampUtils.nowUtc();
    final String timestamp = TimestampUtils.toIso8601(now);

    // Get previous hash for chain.
    final String previousHash = await ref
        .read(auditRepositoryProvider)
        .getLastHash(widget.caseEntity.id ?? 0);

    final String hash = HashUtils.computeAuditHash(
      action: action,
      timestamp: timestamp,
      details: '${evidence.name} status changed to $newStatus',
      previousHash: previousHash,
    );

    final AuditLogEntity log = AuditLogEntity(
      caseId: widget.caseEntity.id ?? 0,
      evidenceItemId: itemId,
      action: action,
      details: '${evidence.name} status changed to $newStatus',
      performedBy: widget.caseEntity.officerName,
      utcTimestamp: now,
      sha256Hash: hash,
      previousHash: previousHash,
    );

    await ref.read(auditRepositoryProvider).insertAuditLog(log);

    // Refresh the evidence list.
    ref.invalidate(evidenceForCaseProvider(widget.caseEntity.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    final int caseId = widget.caseEntity.id ?? 0;
    final AsyncValue<List<EvidenceEntity>> evidenceAsync =
        ref.watch(evidenceForCaseProvider(caseId));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.caseEntity.caseNumber,
              style: TacticalTheme.monoDataBold.copyWith(fontSize: 14),
            ),
            Text(
              widget.caseEntity.crimeType,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          // Navigate to sniffer
          IconButton(
            icon: const Icon(Icons.wifi_tethering),
            tooltip: 'Silent Sniffer',
            onPressed: () {
              Navigator.pushNamed(context, '/sniffer');
            },
          ),
          // Navigate to audit log
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            tooltip: 'Audit Trail',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/audit',
                arguments: widget.caseEntity,
              );
            },
          ),
          // Close scene
          PopupMenuButton<String>(
            onSelected: (String value) async {
              if (value == 'close') {
                await ref
                    .read(caseRepositoryProvider)
                    .updateCaseStatus(caseId, AppConstants.caseClosed);
                if (mounted) Navigator.pop(context);
              } else if (value == 'export') {
                Navigator.pushNamed(
                  context,
                  '/export',
                  arguments: widget.caseEntity,
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Export PDF Report'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'close',
                child: Row(
                  children: [
                    Icon(Icons.close, size: 18),
                    SizedBox(width: 8),
                    Text('Close Scene'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: evidenceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stack) => Center(
          child: Text('Error: $error'),
        ),
        data: (List<EvidenceEntity> items) {
          if (items.isEmpty) {
            return _buildEmptyState(context);
          }

          // Stats
          final int critical =
              items.where((EvidenceEntity e) => e.isCritical).length;
          final int secured =
              items.where((EvidenceEntity e) => e.isSecured).length;

          return Column(
            children: [
              // Stats bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                color: TacticalTheme.surface,
                child: Row(
                  children: [
                    _statChip(
                      '${items.length}',
                      'TOTAL',
                      TacticalTheme.neonBlue,
                    ),
                    const SizedBox(width: 12),
                    _statChip(
                      '$critical',
                      'CRITICAL',
                      TacticalTheme.critical,
                    ),
                    const SizedBox(width: 12),
                    _statChip(
                      '$secured',
                      'SECURED',
                      TacticalTheme.success,
                    ),
                    const Spacer(),
                    Text(
                      '${items.length - secured} remaining',
                      style: TacticalTheme.monoDataSmall,
                    ),
                  ],
                ),
              ),

              // Evidence list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 88),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final EvidenceEntity item = items[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedIndex =
                              _expandedIndex == index ? null : index;
                        });
                      },
                      child: EvidenceActionCard(
                        evidence: item,
                        expanded: _expandedIndex == index,
                        onStatusChange: (String newStatus) =>
                            _handleStatusChange(item, newStatus),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      // FAB: Scan scene
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? added = await Navigator.push<bool>(
            context,
            MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  SceneInputPage(caseEntity: widget.caseEntity),
            ),
          );
          if (added == true) {
            ref.invalidate(evidenceForCaseProvider(caseId));
          }
        },
        icon: const Icon(Icons.document_scanner_outlined),
        label: const Text('SCAN SCENE'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.document_scanner_outlined,
            size: 64,
            color: TacticalTheme.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No evidence identified yet',
            style: TacticalTheme.monoDataBold.copyWith(
              color: TacticalTheme.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap SCAN SCENE to describe the environment',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _statChip(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TacticalTheme.monoDataBold.copyWith(
              color: color,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 9, color: color),
          ),
        ],
      ),
    );
  }
}
