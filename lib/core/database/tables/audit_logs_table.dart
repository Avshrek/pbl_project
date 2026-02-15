import 'package:drift/drift.dart';

import 'package:dfei_opus/core/database/tables/cases_table.dart';
import 'package:dfei_opus/core/database/tables/evidence_items_table.dart';

/// Immutable audit log for chain-of-custody tracking.
///
/// Every action on evidence (found, photographed, seized, exported)
/// is recorded with a UTC timestamp and a SHA-256 hash linking to the
/// previous entry, forming a tamper-evident hash chain.
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to [Cases].
  IntColumn get caseId =>
      integer().references(Cases, #id)();

  /// Foreign key to [EvidenceItems]. Nullable for case-level actions.
  IntColumn get evidenceItemId =>
      integer().nullable().references(EvidenceItems, #id)();

  /// Action type: item_found, item_photographed, item_seized,
  /// item_released, case_created, case_closed, report_exported
  TextColumn get action => text().withLength(min: 1, max: 64)();

  /// Free-text details of the action.
  TextColumn get details => text().withDefault(const Constant(''))();

  /// Officer who performed the action.
  TextColumn get performedBy => text().withLength(min: 1, max: 256)();

  /// Precise UTC timestamp (ISO 8601).
  DateTimeColumn get utcTimestamp => dateTime()();

  /// SHA-256 hash of (action + timestamp + previousHash + details).
  TextColumn get sha256Hash => text().withLength(min: 64, max: 64)();

  /// Hash of the previous audit log entry (empty string for the first entry).
  TextColumn get previousHash =>
      text().withDefault(const Constant(''))();
}
