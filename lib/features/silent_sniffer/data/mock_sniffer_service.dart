import 'dart:async';
import 'dart:math';

import 'package:dfei_opus/features/silent_sniffer/domain/entities/scanned_device.dart';

/// Mock implementation of a BT/Wi-Fi device scanner.
///
/// Generates realistic-looking device scan results at regular intervals.
/// In production this would be replaced by platform-specific
/// Bluetooth/Wi-Fi scanning APIs.
class MockSnifferService {
  MockSnifferService();

  final Random _random = Random();
  Timer? _scanTimer;
  final StreamController<List<ScannedDevice>> _controller =
      StreamController<List<ScannedDevice>>.broadcast();

  /// Stream of discovered devices, updated every scan cycle.
  Stream<List<ScannedDevice>> get deviceStream => _controller.stream;

  /// Start scanning (mock: emits new data every 3 seconds).
  void startScan() {
    _scanTimer?.cancel();
    // Emit immediately, then every 3 seconds with slight variations.
    _emitDevices();
    _scanTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _emitDevices(),
    );
  }

  /// Stop scanning.
  void stopScan() {
    _scanTimer?.cancel();
    _scanTimer = null;
  }

  void dispose() {
    _scanTimer?.cancel();
    _controller.close();
  }

  void _emitDevices() {
    final DateTime now = DateTime.now().toUtc();
    final List<ScannedDevice> devices = [
      ScannedDevice(
        name: 'NETGEAR-5G-Home',
        macAddress: 'A4:2B:8C:DD:11:F3',
        type: 'router',
        signalStrength: -35 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'NETGEAR',
        firstSeen: now.subtract(const Duration(minutes: 12)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'Ring Doorbell Pro',
        macAddress: '68:37:E9:1A:BC:45',
        type: 'camera',
        signalStrength: -52 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'Ring Inc.',
        firstSeen: now.subtract(const Duration(minutes: 10)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: '',
        macAddress: 'F0:18:98:AA:DE:77',
        type: 'unknown',
        signalStrength: -61 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'Apple Inc.',
        isHidden: true,
        firstSeen: now.subtract(const Duration(minutes: 8)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'Echo-Dot-Living',
        macAddress: '34:D2:70:0B:CC:91',
        type: 'speaker',
        signalStrength: -44 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'Amazon',
        firstSeen: now.subtract(const Duration(minutes: 12)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'Galaxy S24',
        macAddress: 'BC:14:EF:55:A7:02',
        type: 'phone',
        signalStrength: -38 + _jitter(),
        protocol: 'Bluetooth',
        manufacturer: 'Samsung',
        firstSeen: now.subtract(const Duration(minutes: 5)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'GoPro-HERO12',
        macAddress: 'D8:96:E0:3C:FA:18',
        type: 'camera',
        signalStrength: -67 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'GoPro',
        isHidden: true,
        firstSeen: now.subtract(const Duration(minutes: 3)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'Nest-Thermostat',
        macAddress: '18:B4:30:CC:12:A9',
        type: 'thermostat',
        signalStrength: -55 + _jitter(),
        protocol: 'Wi-Fi',
        manufacturer: 'Google',
        firstSeen: now.subtract(const Duration(minutes: 12)),
        lastSeen: now,
      ),
      ScannedDevice(
        name: 'Fitbit-Charge5',
        macAddress: '7C:64:56:EE:41:D3',
        type: 'wearable',
        signalStrength: -72 + _jitter(),
        protocol: 'BLE',
        manufacturer: 'Fitbit',
        firstSeen: now.subtract(const Duration(minutes: 7)),
        lastSeen: now,
      ),
    ];

    _controller.add(devices);
  }

  /// Add ±5 dBm jitter to simulate real signal fluctuation.
  int _jitter() => _random.nextInt(11) - 5;
}
