import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';

/// Generates a PDF forensic evidence report for a closed case.
///
/// The report includes:
/// - Case metadata (ID, officer, location, crime type)
/// - Evidence list with volatility scores and statuses
/// - Full chain-of-custody audit trail with hashes
class PdfExportService {
  PdfExportService._();

  static Future<Uint8List> generateReport({
    required CaseEntity caseData,
    required List<EvidenceEntity> evidenceItems,
    required List<AuditLogEntity> auditLogs,
  }) async {
    final pw.Document pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: pw.Font.courier(),
        bold: pw.Font.courierBold(),
      ),
    );

    final DateFormat dateFormat = DateFormat('dd MMM yyyy, HH:mm:ss');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (pw.Context context) => _buildHeader(caseData),
        footer: (pw.Context context) => _buildFooter(context),
        build: (pw.Context context) => [
          // Case metadata section
          _sectionTitle('CASE INFORMATION'),
          _metadataRow('Case Number', caseData.caseNumber),
          _metadataRow('Crime Type', caseData.crimeType),
          _metadataRow('Location', caseData.location),
          _metadataRow('Officer', caseData.officerName),
          _metadataRow(
            'Created',
            '${dateFormat.format(caseData.createdAt.toUtc())} UTC',
          ),
          _metadataRow('Status', caseData.status.toUpperCase()),
          if (caseData.gpsLatitude != null && caseData.gpsLongitude != null)
            _metadataRow(
              'GPS Coordinates',
              '${caseData.gpsLatitude}, ${caseData.gpsLongitude}',
            ),
          pw.SizedBox(height: 20),

          // Evidence items section
          _sectionTitle(
            'IDENTIFIED EVIDENCE (${evidenceItems.length} items)',
          ),
          ...evidenceItems.asMap().entries.map((entry) {
            final int idx = entry.key + 1;
            final EvidenceEntity item = entry.value;
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 10),
              padding: const pw.EdgeInsets.all(8),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey600),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '$idx. ${item.name} [${item.volatilityLevel}]',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text('Category: ${item.category}'),
                  pw.Text(
                    'Volatility Score: ${item.volatilityScore}/10',
                  ),
                  pw.Text('Status: ${item.status.toUpperCase()}'),
                  if (item.description.isNotEmpty)
                    pw.Text('Description: ${item.description}'),
                  if (item.recommendations.isNotEmpty)
                    pw.Text(
                      'Recommendations: ${item.recommendations.join(", ")}',
                    ),
                ],
              ),
            );
          }),
          pw.SizedBox(height: 20),

          // Audit trail section
          _sectionTitle('CHAIN OF CUSTODY AUDIT TRAIL'),
          ...auditLogs.map((AuditLogEntity log) {
            return pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '[${dateFormat.format(log.utcTimestamp)} UTC] '
                    '${log.action.toUpperCase()}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text('By: ${log.performedBy}'),
                  if (log.details.isNotEmpty)
                    pw.Text('Details: ${log.details}'),
                  pw.Text(
                    'Hash: ${log.sha256Hash}',
                    style: const pw.TextStyle(fontSize: 8),
                  ),
                  pw.Divider(thickness: 0.5),
                ],
              ),
            );
          }),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(CaseEntity caseData) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '${AppConstants.appFullName} — FORENSIC REPORT',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'Case: ${caseData.caseNumber}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.Divider(thickness: 2),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount} — '
        'CONFIDENTIAL — LAW ENFORCEMENT SENSITIVE',
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
      ),
    );
  }

  static pw.Widget _sectionTitle(String title) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 10),
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: PdfColors.grey800,
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  static pw.Widget _metadataRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(child: pw.Text(value)),
        ],
      ),
    );
  }
}
