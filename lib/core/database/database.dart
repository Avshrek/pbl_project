import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:dfei_opus/core/database/tables/cases_table.dart';
import 'package:dfei_opus/core/database/tables/evidence_items_table.dart';
import 'package:dfei_opus/core/database/tables/audit_logs_table.dart';

part 'database.g.dart';

/// The central Drift database for DFEI.
///
/// Contains all three core tables and their corresponding DAOs.
/// The generated file `database.g.dart` is produced by running:
/// ```
/// dart run build_runner build
/// ```
@DriftDatabase(tables: [Cases, EvidenceItems, AuditLogs])
class DfeiDatabase extends _$DfeiDatabase {
  DfeiDatabase() : super(_openConnection());

  /// Named constructor for testing with an in-memory database.
  DfeiDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Future migrations go here.
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Cases DAO methods
  // ---------------------------------------------------------------------------

  /// Insert a new case and return its generated ID.
  Future<int> insertCase(CasesCompanion entry) {
    return into(cases).insert(entry);
  }

  /// Get all cases ordered by most recent first.
  Future<List<Case>> getAllCases() {
    return (select(cases)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  /// Watch all active cases as a stream.
  Stream<List<Case>> watchActiveCases() {
    return (select(cases)
          ..where((t) => t.status.equals('active'))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  /// Get a single case by ID.
  Future<Case?> getCaseById(int id) {
    return (select(cases)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Update a case by its ID.
  Future<int> updateCaseFields(int caseId, CasesCompanion entry) {
    return (update(cases)..where((t) => t.id.equals(caseId))).write(entry);
  }

  /// Update case status (e.g., active -> closed).
  Future<int> updateCaseStatus(int caseId, String newStatus) {
    return (update(cases)..where((t) => t.id.equals(caseId))).write(
      CasesCompanion(
        status: Value(newStatus),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // EvidenceItems DAO methods
  // ---------------------------------------------------------------------------

  /// Insert a new evidence item.
  Future<int> insertEvidenceItem(EvidenceItemsCompanion entry) {
    return into(evidenceItems).insert(entry);
  }

  /// Insert multiple evidence items in a batch.
  Future<void> insertEvidenceItemsBatch(
    List<EvidenceItemsCompanion> entries,
  ) {
    return batch((b) {
      b.insertAll(evidenceItems, entries);
    });
  }

  /// Get all evidence items for a case, sorted by volatility (highest first).
  Future<List<EvidenceItem>> getEvidenceForCase(int caseId) {
    return (select(evidenceItems)
          ..where((t) => t.caseId.equals(caseId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.volatilityScore,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  /// Watch evidence items for a case (real-time updates).
  Stream<List<EvidenceItem>> watchEvidenceForCase(int caseId) {
    return (select(evidenceItems)
          ..where((t) => t.caseId.equals(caseId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.volatilityScore,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  /// Update evidence item status (found -> photographed -> seized).
  Future<int> updateEvidenceStatus(int itemId, String newStatus) {
    return (update(evidenceItems)..where((t) => t.id.equals(itemId))).write(
      EvidenceItemsCompanion(
        status: Value(newStatus),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // AuditLogs DAO methods
  // ---------------------------------------------------------------------------

  /// Insert a new audit log entry.
  Future<int> insertAuditLog(AuditLogsCompanion entry) {
    return into(auditLogs).insert(entry);
  }

  /// Get all audit logs for a case, ordered chronologically.
  Future<List<AuditLog>> getAuditLogsForCase(int caseId) {
    return (select(auditLogs)
          ..where((t) => t.caseId.equals(caseId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.utcTimestamp,
                  mode: OrderingMode.asc,
                ),
          ]))
        .get();
  }

  /// Watch audit logs for a case.
  Stream<List<AuditLog>> watchAuditLogsForCase(int caseId) {
    return (select(auditLogs)
          ..where((t) => t.caseId.equals(caseId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.utcTimestamp,
                  mode: OrderingMode.asc,
                ),
          ]))
        .watch();
  }

  /// Get the last audit log entry for a case (to retrieve previous hash).
  Future<AuditLog?> getLastAuditLog(int caseId) {
    return (select(auditLogs)
          ..where((t) => t.caseId.equals(caseId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.utcTimestamp,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
  }
}

/// Opens a persistent SQLite connection in the app's documents directory.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(p.join(dbFolder.path, 'dfei_opus.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
