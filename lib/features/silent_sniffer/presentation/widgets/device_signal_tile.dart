import 'package:flutter/material.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/silent_sniffer/domain/entities/scanned_device.dart';

/// List tile showing a discovered device with signal strength bar.
class DeviceSignalTile extends StatelessWidget {
  const DeviceSignalTile({super.key, required this.device});

  final ScannedDevice device;

  IconData _deviceIcon() {
    switch (device.type) {
      case 'router':
        return Icons.router;
      case 'camera':
        return Icons.videocam;
      case 'speaker':
        return Icons.speaker;
      case 'phone':
        return Icons.phone_android;
      case 'thermostat':
        return Icons.thermostat;
      case 'wearable':
        return Icons.watch;
      default:
        return Icons.device_unknown;
    }
  }

  Color _signalColor() {
    final int pct = device.signalPercent;
    if (pct >= 70) return TacticalTheme.success;
    if (pct >= 40) return TacticalTheme.warning;
    return TacticalTheme.critical;
  }

  @override
  Widget build(BuildContext context) {
    final Color sigColor = _signalColor();
    final String displayName = device.isHidden
        ? '[HIDDEN DEVICE]'
        : device.name.isEmpty
            ? '[Unknown]'
            : device.name;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Device icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: TacticalTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_deviceIcon(), color: TacticalTheme.neonBlue, size: 22),
            ),
            const SizedBox(width: 12),

            // Device info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          displayName,
                          style: TacticalTheme.monoData.copyWith(
                            color: device.isHidden
                                ? TacticalTheme.warning
                                : TacticalTheme.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (device.isHidden)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: TacticalTheme.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'HIDDEN',
                            style: TacticalTheme.monoDataSmall.copyWith(
                              color: TacticalTheme.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${device.macAddress} • ${device.protocol} • ${device.manufacturer}',
                    style: TacticalTheme.monoDataSmall.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 6),

                  // Signal bar
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: device.signalPercent / 100.0,
                            backgroundColor: TacticalTheme.surfaceVariant,
                            color: sigColor,
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${device.signalStrength} dBm',
                        style: TacticalTheme.monoDataSmall.copyWith(
                          color: sigColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
