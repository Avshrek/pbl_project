import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';

/// Abstract repository for case management operations.
///
/// Implementations live in the data layer and handle persistence
/// via Drift/SQLite.
abstract class CaseRepository {
  /// Create a new case and return its generated ID.
  Future<int> createCase(CaseEntity caseEntity);

  /// Get all cases, ordered by most recent first.
  Future<List<CaseEntity>> getAllCases();

  /// Watch active cases as a real-time stream.
  Stream<List<CaseEntity>> watchActiveCases();

  /// Get a single case by its database ID.
  Future<CaseEntity?> getCaseById(int id);

  /// Update case status (active, closed, exported).
  Future<void> updateCaseStatus(int caseId, String newStatus);

  /// Update case details.
  Future<void> updateCase(CaseEntity caseEntity);
}
