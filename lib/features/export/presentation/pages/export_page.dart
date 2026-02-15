import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/core/utils/hash_utils.dart';
import 'package:dfei_opus/core/utils/pdf_export.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';
import 'package:dfei_opus/features/chain_of_custody/presentation/providers/audit_providers.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/providers/evidence_providers.dart';

/// Export page — generates and shares/prints the forensic PDF report.
///
/// Collects case data, evidence items, and audit logs, then
/// generates a PDF using [PdfExportService] and offers print/share.
class ExportPage extends ConsumerStatefulWidget {
  const ExportPage({super.key, required this.caseEntity});

  final CaseEntity caseEntity;

  @override
  ConsumerState<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends ConsumerState<ExportPage> {
  bool _generating = false;
  bool _generated = false;
  Uint8List? _pdfBytes;
  String _statusText = 'Ready to generate report';

  Future<void> _generateReport() async {
    setState(() {
      _generating = true;
      _statusText = 'Collecting evidence data...';
    });

    try {
      final int caseId = widget.caseEntity.id ?? 0;

      // Fetch evidence and audit logs.
      final List<EvidenceEntity> evidence =
          await ref.read(evidenceRepositoryProvider).getEvidenceForCase(caseId);

      setState(() => _statusText = 'Collecting audit trail...');
      final List<AuditLogEntity> auditLogs =
          await ref.read(auditRepositoryProvider).getAuditLogsForCase(caseId);

      // Log the export action.
      final DateTime now = TimestampUtils.nowUtc();
      final String timestamp = TimestampUtils.toIso8601(now);
      final String previousHash =
          await ref.read(auditRepositoryProvider).getLastHash(caseId);
      final String hash = HashUtils.computeAuditHash(
        action: AppConstants.actionReportExported,
        timestamp: timestamp,
        details: 'PDF report generated with ${evidence.length} evidence items',
        previousHash: previousHash,
      );

      await ref.read(auditRepositoryProvider).insertAuditLog(
            AuditLogEntity(
              caseId: caseId,
              action: AppConstants.actionReportExported,
              details:
                  'PDF report generated with ${evidence.length} evidence items',
              performedBy: widget.caseEntity.officerName,
              utcTimestamp: now,
              sha256Hash: hash,
              previousHash: previousHash,
            ),
          );

      setState(() => _statusText = 'Generating PDF...');

      final Uint8List bytes = await PdfExportService.generateReport(
        caseData: widget.caseEntity,
        evidenceItems: evidence,
        auditLogs: auditLogs,
      );

      setState(() {
        _pdfBytes = bytes;
        _generated = true;
        _generating = false;
        _statusText =
            'Report generated (${(bytes.length / 1024).toStringAsFixed(1)} KB)';
      });
    } catch (e) {
      setState(() {
        _generating = false;
        _statusText = 'Error: $e';
      });
    }
  }

  Future<void> _shareOrPrint() async {
    if (_pdfBytes == null) return;

    await Printing.layoutPdf(
      onLayout: (_) async => _pdfBytes!,
      name: 'DFEI_Report_${widget.caseEntity.caseNumber}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Export Report'),
            Text(
              widget.caseEntity.caseNumber,
              style: TacticalTheme.monoDataSmall,
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Icon(
                _generated
                    ? Icons.check_circle_outline
                    : Icons.picture_as_pdf_outlined,
                size: 72,
                color: _generated
                    ? TacticalTheme.success
                    : TacticalTheme.neonBlue,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                _generated
                    ? 'REPORT READY'
                    : 'FORENSIC EVIDENCE REPORT',
                style: TacticalTheme.monoDataBold.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 8),

              // Case info
              Text(
                'Case: ${widget.caseEntity.caseNumber}',
                style: TacticalTheme.monoData,
              ),
              Text(
                'Crime Type: ${widget.caseEntity.crimeType}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Status
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: TacticalTheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_generating)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Icon(
                        _generated ? Icons.check : Icons.info_outline,
                        size: 16,
                        color: _generated
                            ? TacticalTheme.success
                            : TacticalTheme.textMuted,
                      ),
                    const SizedBox(width: 10),
                    Text(
                      _statusText,
                      style: TacticalTheme.monoDataSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Generate button
              if (!_generated)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _generating ? null : _generateReport,
                    icon: _generating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.build_outlined),
                    label: Text(
                      _generating ? 'GENERATING...' : 'GENERATE REPORT',
                    ),
                  ),
                ),

              // Share/Print button
              if (_generated) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _shareOrPrint,
                    icon: const Icon(Icons.print_outlined),
                    label: const Text('PRINT / SHARE PDF'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _generateReport,
                    icon: const Icon(Icons.refresh),
                    label: const Text('REGENERATE'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
