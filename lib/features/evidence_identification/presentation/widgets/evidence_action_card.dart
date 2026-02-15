import 'package:flutter/material.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';
import 'package:dfei_opus/features/evidence_identification/presentation/widgets/volatility_badge.dart';

/// Card displaying a single evidence item on the triage dashboard.
///
/// Shows volatility badge, category, recommendations, and action buttons
/// for progressing through the evidence lifecycle (Found → Photo → Seized).
class EvidenceActionCard extends StatelessWidget {
  const EvidenceActionCard({
    super.key,
    required this.evidence,
    required this.onStatusChange,
    this.expanded = false,
  });

  final EvidenceEntity evidence;
  final void Function(String newStatus) onStatusChange;
  final bool expanded;

  Color _statusColor() {
    switch (evidence.status) {
      case 'seized':
        return TacticalTheme.success;
      case 'photographed':
        return TacticalTheme.neonBlue;
      default:
        return TacticalTheme.textMuted;
    }
  }

  IconData _statusIcon() {
    switch (evidence.status) {
      case 'seized':
        return Icons.check_circle;
      case 'photographed':
        return Icons.camera_alt;
      default:
        return Icons.radio_button_unchecked;
    }
  }

  String? _nextAction() {
    switch (evidence.status) {
      case 'found':
        return 'photographed';
      case 'photographed':
        return 'seized';
      default:
        return null;
    }
  }

  String _nextActionLabel() {
    switch (evidence.status) {
      case 'found':
        return 'PHOTOGRAPH';
      case 'photographed':
        return 'SEIZE';
      default:
        return 'SECURED';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _statusColor();
    final bool isSecured = evidence.isSecured;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSecured
              ? TacticalTheme.success.withValues(alpha: 0.5)
              : TacticalTheme.volatilityColor(evidence.volatilityLevel)
                  .withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Name + volatility badge
            Row(
              children: [
                Icon(_statusIcon(), color: statusColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    evidence.name,
                    style: TacticalTheme.monoDataBold.copyWith(
                      color: isSecured
                          ? TacticalTheme.success
                          : TacticalTheme.textPrimary,
                      decoration: isSecured
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                VolatilityBadge(
                  level: evidence.volatilityLevel,
                  score: evidence.volatilityScore,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Category + source
            Row(
              children: [
                Chip(
                  label: Text(
                    evidence.category,
                    style: const TextStyle(fontSize: 11),
                  ),
                  backgroundColor: TacticalTheme.surfaceVariant,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 8),
                Text(
                  evidence.status.toUpperCase(),
                  style: TacticalTheme.monoDataSmall.copyWith(
                    color: statusColor,
                  ),
                ),
              ],
            ),

            // Description (if expanded)
            if (expanded && evidence.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                evidence.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            // Recommendations
            if (expanded && evidence.recommendations.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'RECOMMENDATIONS:',
                style: TacticalTheme.monoDataSmall.copyWith(
                  color: TacticalTheme.neonBlue,
                ),
              ),
              const SizedBox(height: 4),
              ...evidence.recommendations.map(
                (String rec) => Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(color: TacticalTheme.textMuted)),
                      Expanded(
                        child: Text(
                          rec,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: TacticalTheme.textSecondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Action button
            if (!isSecured) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final String? next = _nextAction();
                    if (next != null) onStatusChange(next);
                  },
                  icon: Icon(
                    evidence.status == 'found'
                        ? Icons.camera_alt_outlined
                        : Icons.lock_outlined,
                    size: 18,
                  ),
                  label: Text(_nextActionLabel()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
