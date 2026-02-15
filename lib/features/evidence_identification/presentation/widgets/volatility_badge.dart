import 'package:flutter/material.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';

/// A small color-coded badge showing the volatility level and score.
class VolatilityBadge extends StatelessWidget {
  const VolatilityBadge({
    super.key,
    required this.level,
    required this.score,
  });

  final String level;
  final int score;

  @override
  Widget build(BuildContext context) {
    final Color color = TacticalTheme.volatilityColor(level);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing dot for CRITICAL items
          if (level == 'CRITICAL') ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            '$level ($score)',
            style: TacticalTheme.monoDataSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
