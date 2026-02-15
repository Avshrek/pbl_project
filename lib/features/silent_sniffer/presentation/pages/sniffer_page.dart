import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/core/theme/tactical_theme.dart';
import 'package:dfei_opus/features/silent_sniffer/domain/entities/scanned_device.dart';
import 'package:dfei_opus/features/silent_sniffer/presentation/providers/sniffer_providers.dart';
import 'package:dfei_opus/features/silent_sniffer/presentation/widgets/device_signal_tile.dart';

/// Silent Sniffer page — scans for nearby Bluetooth/Wi-Fi devices.
///
/// Displays a live-updating list of detected devices with signal
/// strength, manufacturer, and hidden device indicators.
class SnifferPage extends ConsumerWidget {
  const SnifferPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ScannedDevice>> devicesAsync =
        ref.watch(scannedDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.wifi_tethering, color: TacticalTheme.neonBlue, size: 20),
            const SizedBox(width: 8),
            const Text('Silent Sniffer'),
          ],
        ),
        actions: [
          // Scanning indicator
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: devicesAsync.hasValue
                        ? TacticalTheme.success
                        : TacticalTheme.textMuted,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'SCANNING',
                  style: TacticalTheme.monoDataSmall.copyWith(
                    color: devicesAsync.hasValue
                        ? TacticalTheme.success
                        : TacticalTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: devicesAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Scanning nearby devices...',
                style: TacticalTheme.monoData,
              ),
            ],
          ),
        ),
        error: (Object error, StackTrace stack) => Center(
          child: Text('Scan error: $error'),
        ),
        data: (List<ScannedDevice> devices) {
          final int hiddenCount =
              devices.where((ScannedDevice d) => d.isHidden).length;

          return Column(
            children: [
              // Summary bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                color: TacticalTheme.surface,
                child: Row(
                  children: [
                    Text(
                      '${devices.length} devices found',
                      style: TacticalTheme.monoDataBold,
                    ),
                    const SizedBox(width: 16),
                    if (hiddenCount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: TacticalTheme.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$hiddenCount HIDDEN',
                          style: TacticalTheme.monoDataSmall.copyWith(
                            color: TacticalTheme.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Text(
                      'MOCK DATA',
                      style: TacticalTheme.monoDataSmall.copyWith(
                        color: TacticalTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Device list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemCount: devices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DeviceSignalTile(device: devices[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
