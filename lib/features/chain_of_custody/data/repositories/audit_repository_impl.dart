import 'package:drift/drift.dart';

import 'package:dfei_opus/core/database/database.dart';
import 'package:dfei_opus/features/chain_of_custody/domain/entities/audit_log_entity.dart';

/// Abstract interface for audit log operations.
abstract class AuditRepository {
  Future<int> insertAuditLog(AuditLogEntity entity);
  Future<List<AuditLogEntity>> getAuditLogsForCase(int caseId);
  Stream<List<AuditLogEntity>> watchAuditLogsForCase(int caseId);
  Future<String> getLastHash(int caseId);
}

/// Drift-backed implementation of [AuditRepository].
class AuditRepositoryImpl implements AuditRepository {
  AuditRepositoryImpl(this._db);

  final DfeiDatabase _db;

  // ---------------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------------

  AuditLogEntity _toDomain(AuditLog row) {
    return AuditLogEntity(
      id: row.id,
      caseId: row.caseId,
      evidenceItemId: row.evidenceItemId,
      action: row.action,
      details: row.details,
      performedBy: row.performedBy,
      utcTimestamp: row.utcTimestamp,
      sha256Hash: row.sha256Hash,
      previousHash: row.previousHash,
    );
  }

  AuditLogsCompanion _toCompanion(AuditLogEntity entity) {
    return AuditLogsCompanion(
      caseId: Value(entity.caseId),
      evidenceItemId: Value(entity.evidenceItemId),
      action: Value(entity.action),
      details: Value(entity.details),
      performedBy: Value(entity.performedBy),
      utcTimestamp: Value(entity.utcTimestamp),
      sha256Hash: Value(entity.sha256Hash),
      previousHash: Value(entity.previousHash),
    );
  }

  // ---------------------------------------------------------------------------
  // AuditRepository implementation
  // ---------------------------------------------------------------------------

  @override
  Future<int> insertAuditLog(AuditLogEntity entity) {
    return _db.insertAuditLog(_toCompanion(entity));
  }

  @override
  Future<List<AuditLogEntity>> getAuditLogsForCase(int caseId) async {
    final List<AuditLog> rows = await _db.getAuditLogsForCase(caseId);
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<List<AuditLogEntity>> watchAuditLogsForCase(int caseId) {
    return _db.watchAuditLogsForCase(caseId).map(
          (List<AuditLog> rows) => rows.map(_toDomain).toList(),
        );
  }

  @override
  Future<String> getLastHash(int caseId) async {
    final AuditLog? last = await _db.getLastAuditLog(caseId);
    return last?.sha256Hash ?? '';
  }
}
