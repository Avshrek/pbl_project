import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';
import 'package:dfei_opus/features/evidence_identification/data/repositories/evidence_repository_impl.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/domain/repositories/evidence_repository.dart';

/// Evidence repository provider.
final evidenceRepositoryProvider = Provider<EvidenceRepository>((ref) {
  return EvidenceRepositoryImpl(ref.watch(databaseProvider));
});

/// Watch evidence for the currently selected case.
final evidenceForCaseProvider =
    StreamProvider.family<List<EvidenceEntity>, int>((ref, caseId) {
  final EvidenceRepository repo = ref.watch(evidenceRepositoryProvider);
  return repo.watchEvidenceForCase(caseId);
});

/// Scene description text (for the input page).
final sceneDescriptionProvider = StateProvider<String>((ref) => '');
