import 'package:drift/drift.dart';

import 'package:dfei_opus/core/database/database.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/domain/repositories/case_repository.dart';

/// Drift-backed implementation of [CaseRepository].
class CaseRepositoryImpl implements CaseRepository {
  CaseRepositoryImpl(this._db);

  final DfeiDatabase _db;

  // ---------------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------------

  CaseEntity _toDomain(Case row) {
    return CaseEntity(
      id: row.id,
      caseNumber: row.caseNumber,
      crimeType: row.crimeType,
      location: row.location,
      officerName: row.officerName,
      gpsLatitude: row.gpsLatitude,
      gpsLongitude: row.gpsLongitude,
      notes: row.notes,
      status: row.status,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  CasesCompanion _toCompanion(CaseEntity entity) {
    return CasesCompanion(
      caseNumber: Value(entity.caseNumber),
      crimeType: Value(entity.crimeType),
      location: Value(entity.location),
      officerName: Value(entity.officerName),
      gpsLatitude: Value(entity.gpsLatitude),
      gpsLongitude: Value(entity.gpsLongitude),
      notes: Value(entity.notes),
      status: Value(entity.status),
    );
  }

  // ---------------------------------------------------------------------------
  // CaseRepository implementation
  // ---------------------------------------------------------------------------

  @override
  Future<int> createCase(CaseEntity caseEntity) {
    return _db.insertCase(_toCompanion(caseEntity));
  }

  @override
  Future<List<CaseEntity>> getAllCases() async {
    final List<Case> rows = await _db.getAllCases();
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<List<CaseEntity>> watchActiveCases() {
    return _db.watchActiveCases().map(
          (List<Case> rows) => rows.map(_toDomain).toList(),
        );
  }

  @override
  Future<CaseEntity?> getCaseById(int id) async {
    final Case? row = await _db.getCaseById(id);
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<void> updateCaseStatus(int caseId, String newStatus) {
    return _db.updateCaseStatus(caseId, newStatus).then((_) {});
  }

  @override
  Future<void> updateCase(CaseEntity caseEntity) async {
    if (caseEntity.id == null) return;
    await _db.updateCaseFields(
      caseEntity.id!,
      _toCompanion(caseEntity),
    );
  }
}
