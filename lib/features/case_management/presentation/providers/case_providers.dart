import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/database/database.dart';
import 'package:dfei_opus/features/case_management/data/repositories/case_repository_impl.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/domain/repositories/case_repository.dart';

/// Singleton database provider.
final databaseProvider = Provider<DfeiDatabase>((ref) {
  final DfeiDatabase db = DfeiDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Case repository provider.
final caseRepositoryProvider = Provider<CaseRepository>((ref) {
  final DfeiDatabase db = ref.watch(databaseProvider);
  return CaseRepositoryImpl(db);
});

/// Watches active cases as a stream.
final activeCasesProvider = StreamProvider<List<CaseEntity>>((ref) {
  final CaseRepository repo = ref.watch(caseRepositoryProvider);
  return repo.watchActiveCases();
});

/// Fetches all cases (including closed).
final allCasesProvider = FutureProvider<List<CaseEntity>>((ref) {
  final CaseRepository repo = ref.watch(caseRepositoryProvider);
  return repo.getAllCases();
});

/// Gets a single case by ID.
final caseByIdProvider =
    FutureProvider.family<CaseEntity?, int>((ref, id) {
  final CaseRepository repo = ref.watch(caseRepositoryProvider);
  return repo.getCaseById(id);
});

/// Tracks the currently selected case ID for navigation context.
final selectedCaseIdProvider = StateProvider<int?>((ref) => null);
