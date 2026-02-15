import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/case_management/presentation/providers/case_providers.dart';
import 'package:dfei_opus/features/case_management/presentation/widgets/case_card.dart';
import 'package:dfei_opus/features/case_management/presentation/pages/new_case_page.dart';

/// Main listing page for all forensic cases.
class CaseListPage extends ConsumerWidget {
  const CaseListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<CaseEntity>> casesAsync =
        ref.watch(activeCasesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.shield, color: TacticalTheme.neonBlue, size: 22),
            const SizedBox(width: 8),
            const Text('DFEI — Cases'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_outline),
            tooltip: 'Lock App',
            onPressed: () {
              // TODO: lock the app via authProvider
            },
          ),
        ],
      ),
      body: casesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Error loading cases:\n$error',
            style: TextStyle(color: TacticalTheme.critical),
            textAlign: TextAlign.center,
          ),
        ),
        data: (List<CaseEntity> cases) {
          if (cases.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_off_outlined,
                    size: 64,
                    color: TacticalTheme.textMuted,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active cases',
                    style: TacticalTheme.monoDataBold.copyWith(
                      color: TacticalTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create a new incident',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: cases.length,
            itemBuilder: (BuildContext context, int index) {
              final CaseEntity caseItem = cases[index];
              return CaseCard(
                caseEntity: caseItem,
                onTap: () {
                  ref.read(selectedCaseIdProvider.notifier).state =
                      caseItem.id;
                  // Navigate to triage dashboard
                  Navigator.pushNamed(context, '/triage', arguments: caseItem);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const NewCasePage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('NEW INCIDENT'),
      ),
    );
  }
}
