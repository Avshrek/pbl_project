import 'dart:convert';

import 'package:drift/drift.dart';

import 'package:dfei_opus/core/database/database.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/domain/repositories/evidence_repository.dart';

/// Drift-backed implementation of [EvidenceRepository].
class EvidenceRepositoryImpl implements EvidenceRepository {
  EvidenceRepositoryImpl(this._db);

  final DfeiDatabase _db;

  // ---------------------------------------------------------------------------
  // Mapping helpers
  // ---------------------------------------------------------------------------

  EvidenceEntity _toDomain(EvidenceItem row) {
    List<String> recs = const <String>[];
    try {
      final dynamic decoded = jsonDecode(row.recommendations);
      if (decoded is List) {
        recs = decoded.cast<String>();
      }
    } catch (_) {
      // Ignore JSON parse errors; default to empty list.
    }

    return EvidenceEntity(
      id: row.id,
      caseId: row.caseId,
      name: row.name,
      description: row.description,
      category: row.category,
      volatilityScore: row.volatilityScore,
      volatilityLevel: row.volatilityLevel,
      recommendations: recs,
      status: row.status,
      source: row.source,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  EvidenceItemsCompanion _toCompanion(EvidenceEntity entity) {
    return EvidenceItemsCompanion(
      caseId: Value(entity.caseId),
      name: Value(entity.name),
      description: Value(entity.description),
      category: Value(entity.category),
      volatilityScore: Value(entity.volatilityScore),
      volatilityLevel: Value(entity.volatilityLevel),
      recommendations: Value(jsonEncode(entity.recommendations)),
      status: Value(entity.status),
      source: Value(entity.source),
    );
  }

  // ---------------------------------------------------------------------------
  // EvidenceRepository implementation
  // ---------------------------------------------------------------------------

  @override
  Future<int> insertEvidence(EvidenceEntity entity) {
    return _db.insertEvidenceItem(_toCompanion(entity));
  }

  @override
  Future<void> insertEvidenceBatch(List<EvidenceEntity> entities) {
    return _db.insertEvidenceItemsBatch(
      entities.map(_toCompanion).toList(),
    );
  }

  @override
  Future<List<EvidenceEntity>> getEvidenceForCase(int caseId) async {
    final List<EvidenceItem> rows = await _db.getEvidenceForCase(caseId);
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<List<EvidenceEntity>> watchEvidenceForCase(int caseId) {
    return _db.watchEvidenceForCase(caseId).map(
          (List<EvidenceItem> rows) => rows.map(_toDomain).toList(),
        );
  }

  @override
  Future<void> updateEvidenceStatus(int itemId, String newStatus) {
    return _db.updateEvidenceStatus(itemId, newStatus).then((_) {});
  }
}
