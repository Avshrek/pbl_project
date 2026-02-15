import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/features/silent_sniffer/data/mock_sniffer_service.dart';
import 'package:dfei_opus/features/silent_sniffer/domain/entities/scanned_device.dart';

/// Mock sniffer service singleton.
final snifferServiceProvider = Provider<MockSnifferService>((ref) {
  final MockSnifferService service = MockSnifferService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Stream of scanned devices.
final scannedDevicesProvider = StreamProvider<List<ScannedDevice>>((ref) {
  final MockSnifferService service = ref.watch(snifferServiceProvider);
  service.startScan();
  ref.onDispose(() => service.stopScan());
  return service.deviceStream;
});

/// Whether the sniffer is currently scanning.
final isSnifferActiveProvider = StateProvider<bool>((ref) => false);
