import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';

/// Abstract repository for evidence item persistence.
abstract class EvidenceRepository {
  /// Insert a single evidence item. Returns the generated ID.
  Future<int> insertEvidence(EvidenceEntity entity);

  /// Insert multiple evidence items in a batch.
  Future<void> insertEvidenceBatch(List<EvidenceEntity> entities);

  /// Get all evidence for a case, sorted by volatility (highest first).
  Future<List<EvidenceEntity>> getEvidenceForCase(int caseId);

  /// Watch evidence for a case as a real-time stream.
  Stream<List<EvidenceEntity>> watchEvidenceForCase(int caseId);

  /// Update the status of an evidence item.
  Future<void> updateEvidenceStatus(int itemId, String newStatus);
}
