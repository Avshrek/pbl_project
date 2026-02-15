import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/domain/services/forensic_rules_engine.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/providers/evidence_providers.dart';

/// Page where the officer describes the crime scene in free text.
///
/// The ForensicRulesEngine analyzes the description and produces
/// a list of identified evidence items.
class SceneInputPage extends ConsumerStatefulWidget {
  const SceneInputPage({super.key, required this.caseEntity});

  final CaseEntity caseEntity;

  @override
  ConsumerState<SceneInputPage> createState() => _SceneInputPageState();
}

class _SceneInputPageState extends ConsumerState<SceneInputPage> {
  final TextEditingController _sceneController = TextEditingController();
  List<EvidenceEntity> _preview = const <EvidenceEntity>[];
  bool _analyzing = false;

  @override
  void dispose() {
    _sceneController.dispose();
    super.dispose();
  }

  void _analyzeScene() {
    final String text = _sceneController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _preview = ForensicRulesEngine.analyzeScene(
        sceneDescription: text,
        crimeType: widget.caseEntity.crimeType,
        caseId: widget.caseEntity.id ?? 0,
      );
    });
  }

  Future<void> _submitEvidence() async {
    if (_preview.isEmpty) return;

    setState(() => _analyzing = true);

    try {
      await ref
          .read(evidenceRepositoryProvider)
          .insertEvidenceBatch(_preview);

      if (mounted) {
        Navigator.pop(context, true); // Signal that evidence was added.
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _analyzing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scene Description'),
      ),
      body: Column(
        children: [
          // Input area
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DESCRIBE THE SCENE',
                  style: TacticalTheme.monoDataSmall.copyWith(
                    color: TacticalTheme.neonBlue,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _sceneController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText:
                        'e.g., "Home office with a locked gaming PC, a router '
                        'on the shelf, and a smart thermostat on the wall"',
                  ),
                  onChanged: (_) => _analyzeScene(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${_preview.length} items identified',
                      style: TacticalTheme.monoData.copyWith(
                        color: _preview.isNotEmpty
                            ? TacticalTheme.neonBlue
                            : TacticalTheme.textMuted,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${ForensicRulesEngine.ruleCount} rules loaded',
                      style: TacticalTheme.monoDataSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Live preview
          Expanded(
            child: _preview.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          size: 48,
                          color: TacticalTheme.textMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Start typing to identify evidence',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 80),
                    itemCount: _preview.length,
                    itemBuilder: (BuildContext context, int index) {
                      final EvidenceEntity item = _preview[index];
                      final Color volColor =
                          TacticalTheme.volatilityColor(item.volatilityLevel);

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: volColor.withValues(alpha: 0.2),
                          child: Text(
                            '${item.volatilityScore}',
                            style: TacticalTheme.monoDataBold.copyWith(
                              color: volColor,
                            ),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: TacticalTheme.monoData,
                        ),
                        subtitle: Text(
                          '${item.category} • ${item.volatilityLevel}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: TacticalTheme.textMuted,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Submit FAB
      floatingActionButton: _preview.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _analyzing ? null : _submitEvidence,
              icon: _analyzing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(
                _analyzing
                    ? 'SAVING...'
                    : 'SAVE ${_preview.length} ITEMS',
              ),
            )
          : null,
    );
  }
}
