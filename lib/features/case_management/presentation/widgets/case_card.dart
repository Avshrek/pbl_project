import 'package:flutter/material.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/case_management/domain/entities/case_entity.dart';

/// Card widget displaying a single case summary in the case list.
class CaseCard extends StatelessWidget {
  const CaseCard({
    super.key,
    required this.caseEntity,
    required this.onTap,
  });

  final CaseEntity caseEntity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool isActive = caseEntity.isActive;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: case number + status badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      caseEntity.caseNumber,
                      style: TacticalTheme.monoDataBold.copyWith(
                        color: TacticalTheme.neonBlue,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? TacticalTheme.success.withValues(alpha: 0.15)
                          : TacticalTheme.textMuted.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isActive
                            ? TacticalTheme.success
                            : TacticalTheme.textMuted,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      caseEntity.status.toUpperCase(),
                      style: TacticalTheme.monoDataSmall.copyWith(
                        color: isActive
                            ? TacticalTheme.success
                            : TacticalTheme.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Crime type
              Row(
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 14,
                    color: TacticalTheme.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    caseEntity.crimeType,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Location
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: TacticalTheme.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      caseEntity.location,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Footer: officer + timestamp
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    caseEntity.officerName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    TimestampUtils.timeAgo(caseEntity.createdAt),
                    style: TacticalTheme.monoDataSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
