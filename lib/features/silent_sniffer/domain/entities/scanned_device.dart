/// Represents a device discovered by the Silent Sniffer.
///
/// In production this would come from Bluetooth/Wi-Fi scanning APIs.
/// Currently populated with mock data.
class ScannedDevice {
  const ScannedDevice({
    required this.name,
    required this.macAddress,
    required this.type,
    required this.signalStrength,
    required this.protocol,
    this.manufacturer = 'Unknown',
    this.isHidden = false,
    required this.firstSeen,
    required this.lastSeen,
  });

  /// Display name (may be empty for hidden devices).
  final String name;

  /// MAC address (e.g., "AA:BB:CC:DD:EE:FF").
  final String macAddress;

  /// Device type: router, camera, speaker, phone, unknown, etc.
  final String type;

  /// Signal strength in dBm (e.g., -30 = strong, -80 = weak).
  final int signalStrength;

  /// Protocol: "Wi-Fi", "Bluetooth", "BLE"
  final String protocol;

  /// Manufacturer from OUI lookup.
  final String manufacturer;

  /// Whether this device has a hidden SSID or is not broadcasting a name.
  final bool isHidden;

  final DateTime firstSeen;
  final DateTime lastSeen;

  /// Signal strength as a percentage (0-100).
  int get signalPercent {
    // dBm typically ranges from -100 (weak) to -30 (strong).
    final int clamped = signalStrength.clamp(-100, -30);
    return ((clamped + 100) * 100 ~/ 70).clamp(0, 100);
  }

  /// Human-readable signal quality.
  String get signalQuality {
    final int pct = signalPercent;
    if (pct >= 70) return 'Strong';
    if (pct >= 40) return 'Medium';
    return 'Weak';
  }
}
