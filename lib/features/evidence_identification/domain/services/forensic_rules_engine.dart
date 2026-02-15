import 'package:dfei_opus/core/constants/app_constants.dart';
import 'package:dfei_opus/core/utils/timestamp_utils.dart';
import 'package:dfei_opus/features/evidence_identification/domain/entities/evidence_entity.dart';

/// A single rule in the forensic knowledge graph.
///
/// Maps a keyword (or set of keywords) to an evidence type with volatility
/// scoring and actionable recommendations.
class EvidenceRule {
  const EvidenceRule({
    required this.keywords,
    required this.evidenceName,
    required this.description,
    required this.category,
    required this.volatilityScore,
    required this.recommendations,
    this.crimeTypeBoost = const <String, int>{},
  });

  /// Keywords that trigger this rule (all lowercase).
  final List<String> keywords;

  /// Human-readable name for the evidence type.
  final String evidenceName;

  /// Brief description of why this evidence matters.
  final String description;

  /// Evidence category (Computer, Network, IoT, etc.).
  final String category;

  /// Base volatility score (1-10).
  final int volatilityScore;

  /// Actionable steps the officer should take.
  final List<String> recommendations;

  /// Crime types that increase this item's priority.
  /// Key = crime type, Value = additional score boost (capped at 10).
  final Map<String, int> crimeTypeBoost;
}

/// The Forensic Rules Engine (Identification Engine).
///
/// This is the core USP of DFEI. It functions as a local, offline
/// rule-based "knowledge graph" that:
///
/// 1. Parses a free-text scene description.
/// 2. Matches keywords against a hardcoded evidence rule set.
/// 3. Applies crime-type sensitivity boosting.
/// 4. Returns a de-duplicated, volatility-sorted list of evidence items.
class ForensicRulesEngine {
  ForensicRulesEngine._();

  // ---------------------------------------------------------------------------
  // Knowledge Graph: Hardcoded Evidence Rules
  // ---------------------------------------------------------------------------

  static final List<EvidenceRule> _rules = [
    // ── Volatile Data (CRITICAL) ──────────────────────────────────────────
    const EvidenceRule(
      keywords: ['ram', 'memory', 'running', 'live system'],
      evidenceName: 'RAM / Live Memory',
      description: 'Volatile data lost on shutdown. Contains running processes, '
          'encryption keys, chat sessions, and network connections.',
      category: AppConstants.categoryVolatile,
      volatilityScore: 10,
      recommendations: [
        'DO NOT power off the device',
        'Use forensic RAM capture tool (e.g., FTK Imager, Belkasoft RAM Capturer)',
        'Document running processes before capture',
        'Photograph the screen state',
      ],
    ),
    const EvidenceRule(
      keywords: ['network connection', 'active session', 'logged in'],
      evidenceName: 'Active Network Sessions',
      description: 'Live network connections and authenticated sessions.',
      category: AppConstants.categoryVolatile,
      volatilityScore: 9,
      recommendations: [
        'Run netstat / network capture before disconnecting',
        'Document all active connections',
        'Note remote IPs and ports',
        'Capture browser session tokens if visible',
      ],
    ),
    const EvidenceRule(
      keywords: ['clipboard', 'temp files', 'temporary'],
      evidenceName: 'Clipboard & Temp Files',
      description: 'Ephemeral data that may be overwritten or cleared.',
      category: AppConstants.categoryVolatile,
      volatilityScore: 8,
      recommendations: [
        'Capture clipboard contents immediately',
        'Image the temp directories before any changes',
        'Do not open/close applications on the system',
      ],
    ),

    // ── Computers ──────────────────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['desktop', 'pc', 'computer', 'tower', 'workstation'],
      evidenceName: 'Desktop Computer',
      description: 'Full computer system that may contain storage, RAM, and user data.',
      category: AppConstants.categoryComputer,
      volatilityScore: 7,
      recommendations: [
        'If powered ON: capture RAM first, then image the drive',
        'If powered OFF: do NOT turn it on; image the drive directly',
        'Photograph cable connections before disconnecting',
        'Check for encrypted volumes (BitLocker, VeraCrypt)',
        'Document BIOS/UEFI time if accessible',
      ],
      crimeTypeBoost: {
        'Child Safety': 2,
        'Intrusion / Hacking': 2,
        'Intellectual Property': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['gaming pc', 'gaming setup', 'gaming computer', 'gaming rig'],
      evidenceName: 'Gaming PC',
      description: 'High-performance system often with crypto wallets, '
          'encrypted volumes, and communication tools.',
      category: AppConstants.categoryComputer,
      volatilityScore: 8,
      recommendations: [
        'Check for cryptocurrency wallets and mining software',
        'Look for encrypted volumes and virtual machines',
        'Document Steam/Discord/communication app sessions',
        'Check for VPN software and anonymization tools',
        'Capture RAM — gaming PCs often have extensive RAM',
      ],
      crimeTypeBoost: {
        'Fraud': 2,
        'Child Safety': 2,
        'Intrusion / Hacking': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['laptop', 'notebook'],
      evidenceName: 'Laptop Computer',
      description: 'Portable computer. Check if lid state affects sleep/hibernate.',
      category: AppConstants.categoryComputer,
      volatilityScore: 7,
      recommendations: [
        'If open and running: capture RAM, do NOT close the lid',
        'Closing the lid may trigger sleep/hibernate and lose volatile data',
        'Check for full-disk encryption',
        'Note battery level — low battery may cause shutdown',
        'Photograph screen contents',
      ],
    ),
    const EvidenceRule(
      keywords: ['server', 'rack', 'data center'],
      evidenceName: 'Server / Rack System',
      description: 'Enterprise system. Likely contains critical data and logs.',
      category: AppConstants.categoryComputer,
      volatilityScore: 8,
      recommendations: [
        'Do NOT shut down — capture RAM and network state first',
        'Identify RAID configuration before imaging',
        'Document all running services and connected clients',
        'Check for virtual machines and containers',
        'Coordinate with IT personnel for safe imaging',
      ],
      crimeTypeBoost: {
        'Intrusion / Hacking': 2,
        'Fraud': 1,
        'Terrorism': 1,
      },
    ),

    // ── Network Devices ────────────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['router', 'gateway', 'modem'],
      evidenceName: 'Router / Gateway',
      description: 'Network routing device. Contains logs, DHCP leases, '
          'connected device history.',
      category: AppConstants.categoryNetwork,
      volatilityScore: 6,
      recommendations: [
        'Photograph the router label (model, serial, default credentials)',
        'Check for attached USB storage devices',
        'Document all connected devices via admin panel if accessible',
        'Capture DHCP lease table and routing logs',
        'Note the WAN IP address',
      ],
    ),
    const EvidenceRule(
      keywords: ['switch', 'network switch', 'hub'],
      evidenceName: 'Network Switch',
      description: 'Layer 2/3 device. May have port mirroring or VLAN configs.',
      category: AppConstants.categoryNetwork,
      volatilityScore: 5,
      recommendations: [
        'Document port connections and cable layout',
        'Check for managed switch admin interface',
        'Note MAC address tables if accessible',
      ],
    ),
    const EvidenceRule(
      keywords: ['access point', 'wifi', 'wi-fi', 'wireless'],
      evidenceName: 'Wireless Access Point',
      description: 'Wi-Fi device. Log of connected clients may be available.',
      category: AppConstants.categoryNetwork,
      volatilityScore: 5,
      recommendations: [
        'Document SSID and security type',
        'Check for connected client logs',
        'Note signal range and coverage area',
        'Look for hidden SSIDs',
      ],
    ),
    const EvidenceRule(
      keywords: ['firewall', 'ids', 'ips', 'intrusion detection'],
      evidenceName: 'Firewall / IDS',
      description: 'Security appliance with extensive traffic logs.',
      category: AppConstants.categoryNetwork,
      volatilityScore: 7,
      recommendations: [
        'Export all logs before any changes',
        'Document current rule set and policies',
        'Check for blocked connection attempts',
        'Preserve alert and incident logs',
      ],
      crimeTypeBoost: {'Intrusion / Hacking': 2},
    ),

    // ── Mobile Devices ─────────────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['phone', 'smartphone', 'iphone', 'android', 'mobile'],
      evidenceName: 'Smartphone',
      description: 'Mobile device with communications, GPS, photos, and app data.',
      category: AppConstants.categoryMobile,
      volatilityScore: 7,
      recommendations: [
        'Enable airplane mode to prevent remote wipe',
        'Do NOT let the battery die',
        'If unlocked, keep it unlocked (disable auto-lock if possible)',
        'Place in Faraday bag if available',
        'Document lock screen state and visible notifications',
      ],
      crimeTypeBoost: {
        'Narcotics': 2,
        'Child Safety': 2,
        'Cyberstalking': 2,
        'Terrorism': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['tablet', 'ipad'],
      evidenceName: 'Tablet Device',
      description: 'Tablet with apps, browser history, and media.',
      category: AppConstants.categoryMobile,
      volatilityScore: 6,
      recommendations: [
        'Same handling as smartphone — airplane mode, keep charged',
        'Document installed apps visible on home screen',
        'Check for child profiles or parental controls',
      ],
    ),
    const EvidenceRule(
      keywords: ['smartwatch', 'wearable', 'fitness tracker', 'fitbit'],
      evidenceName: 'Wearable Device',
      description: 'Wearable with health data, GPS tracks, and notifications.',
      category: AppConstants.categoryMobile,
      volatilityScore: 5,
      recommendations: [
        'Document current display state',
        'Collect with paired phone if possible',
        'GPS and health data may establish timelines',
      ],
    ),

    // ── Storage Devices ────────────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['usb', 'flash drive', 'thumb drive', 'usb stick', 'pendrive'],
      evidenceName: 'USB Flash Drive',
      description: 'Portable storage. May contain transferred/exfiltrated data.',
      category: AppConstants.categoryStorage,
      volatilityScore: 4,
      recommendations: [
        'Do NOT insert into any computer',
        'Bag and label with location found',
        'Use write-blocker for forensic imaging',
        'Check for encryption (e.g., hardware-encrypted drives)',
      ],
    ),
    const EvidenceRule(
      keywords: ['external hard drive', 'external drive', 'external hdd', 'external ssd'],
      evidenceName: 'External Hard Drive',
      description: 'External storage with potentially large data volumes.',
      category: AppConstants.categoryStorage,
      volatilityScore: 4,
      recommendations: [
        'Do NOT connect to any system',
        'Use write-blocker for imaging',
        'Document make, model, and serial number',
        'Check for encryption indicators',
      ],
    ),
    const EvidenceRule(
      keywords: ['sd card', 'memory card', 'micro sd', 'cf card'],
      evidenceName: 'Memory Card',
      description: 'Small-form storage from cameras, phones, or drones.',
      category: AppConstants.categoryStorage,
      volatilityScore: 4,
      recommendations: [
        'Document which device it was removed from',
        'Handle with anti-static precautions',
        'Use write-blocker for imaging',
      ],
    ),
    const EvidenceRule(
      keywords: ['nas', 'network attached storage', 'synology', 'qnap'],
      evidenceName: 'NAS Device',
      description: 'Network storage with RAID. May contain shared files and backups.',
      category: AppConstants.categoryStorage,
      volatilityScore: 6,
      recommendations: [
        'Document RAID configuration before seizure',
        'Do NOT remove individual drives from a RAID array',
        'Check for shared folders and access permissions',
        'Export user access logs if available',
      ],
      crimeTypeBoost: {
        'Child Safety': 2,
        'Intellectual Property': 2,
      },
    ),

    // ── IoT Devices ────────────────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['camera', 'security camera', 'cctv', 'webcam', 'ring', 'nest cam'],
      evidenceName: 'Security Camera / CCTV',
      description: 'Video surveillance device. Footage may be time-critical.',
      category: AppConstants.categoryIoT,
      volatilityScore: 7,
      recommendations: [
        'Check recording loop duration — footage may be overwritten',
        'Export footage immediately if accessible',
        'Document camera angles and coverage areas',
        'Note if cloud-synced (may require warrant for cloud data)',
        'Preserve the DVR/NVR unit if present',
      ],
      crimeTypeBoost: {
        'Homicide': 2,
        'Theft / Burglary': 2,
        'Domestic Violence': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['smart speaker', 'alexa', 'echo', 'google home', 'homepod'],
      evidenceName: 'Smart Speaker / Assistant',
      description: 'Voice assistant with command history stored in the cloud.',
      category: AppConstants.categoryIoT,
      volatilityScore: 5,
      recommendations: [
        'Do NOT interact with the device (avoid triggering recording)',
        'Note the make and model',
        'Cloud account warrant may be needed for voice history',
        'Check for linked smart home devices',
      ],
    ),
    const EvidenceRule(
      keywords: ['thermostat', 'smart thermostat', 'nest thermostat'],
      evidenceName: 'Smart Thermostat',
      description: 'IoT device with occupancy patterns and scheduling data.',
      category: AppConstants.categoryIoT,
      volatilityScore: 4,
      recommendations: [
        'Occupancy data may establish presence/absence timelines',
        'Check for connected account and app data',
        'Document current settings and schedule',
      ],
    ),
    const EvidenceRule(
      keywords: ['smart lock', 'keypad lock', 'august lock'],
      evidenceName: 'Smart Lock',
      description: 'Electronic lock with access logs and user codes.',
      category: AppConstants.categoryIoT,
      volatilityScore: 5,
      recommendations: [
        'Access logs show entry/exit times and user codes',
        'Document current lock state',
        'Check for Bluetooth/Wi-Fi connectivity',
        'May require cloud account for full history',
      ],
      crimeTypeBoost: {
        'Theft / Burglary': 2,
        'Homicide': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['drone', 'quadcopter', 'uav'],
      evidenceName: 'Drone / UAV',
      description: 'Unmanned aerial vehicle with flight logs, GPS, and camera.',
      category: AppConstants.categoryIoT,
      volatilityScore: 6,
      recommendations: [
        'Preserve the SD card and internal storage',
        'Document flight logs (GPS waypoints, altitude, timestamps)',
        'Check paired controller and mobile app',
        'Handle propellers carefully — do not activate',
      ],
      crimeTypeBoost: {
        'Terrorism': 2,
        'Narcotics': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['gopro', 'action camera', 'body cam'],
      evidenceName: 'Action Camera',
      description: 'Compact camera that may be hidden. Contains video/photo evidence.',
      category: AppConstants.categoryIoT,
      volatilityScore: 5,
      recommendations: [
        'Check if currently recording',
        'Preserve the memory card',
        'Document where the camera was found/mounted',
        'Check for Wi-Fi connectivity (may be streaming)',
      ],
    ),
    const EvidenceRule(
      keywords: ['printer', 'scanner', 'multifunction'],
      evidenceName: 'Printer / Scanner',
      description: 'May contain print queue, scan history, and internal storage.',
      category: AppConstants.categoryPeripheral,
      volatilityScore: 3,
      recommendations: [
        'Check for internal hard drive (enterprise printers)',
        'Document print queue and recent job history',
        'Note network connectivity (may have been used remotely)',
      ],
      crimeTypeBoost: {'Fraud': 1},
    ),

    // ── Peripherals & Physical ─────────────────────────────────────────────
    const EvidenceRule(
      keywords: ['power cable', 'cable', 'charger', 'adapter'],
      evidenceName: 'Power Cables & Adapters',
      description: 'Physical cables needed to power seized devices.',
      category: AppConstants.categoryPeripheral,
      volatilityScore: 1,
      recommendations: [
        'Collect all power cables and chargers for seized devices',
        'Label each cable with the device it belongs to',
        'Check for proprietary connectors',
      ],
    ),
    const EvidenceRule(
      keywords: ['keyboard', 'mouse', 'monitor', 'display'],
      evidenceName: 'Input/Output Peripherals',
      description: 'Peripherals. Generally low priority unless modified.',
      category: AppConstants.categoryPeripheral,
      volatilityScore: 1,
      recommendations: [
        'Check keyboard for hardware keyloggers (USB inline devices)',
        'Document setup and connected devices',
        'Generally low priority for seizure',
      ],
    ),
    const EvidenceRule(
      keywords: ['gaming console', 'playstation', 'xbox', 'nintendo', 'ps5', 'ps4'],
      evidenceName: 'Gaming Console',
      description: 'Console with user accounts, chat logs, and stored media.',
      category: AppConstants.categoryComputer,
      volatilityScore: 5,
      recommendations: [
        'Check for user accounts and saved messages',
        'Consoles may contain browser history and downloads',
        'Check for external storage devices connected to console',
        'Document network connection (PSN/Xbox Live account)',
      ],
      crimeTypeBoost: {
        'Child Safety': 2,
      },
    ),
    const EvidenceRule(
      keywords: ['vpn', 'tor', 'proxy', 'anonymizer'],
      evidenceName: 'Anonymization Tools',
      description: 'Software/hardware for anonymizing network traffic.',
      category: AppConstants.categoryNetwork,
      volatilityScore: 7,
      recommendations: [
        'Document the tool name and version',
        'Check for VPN configuration files and server lists',
        'Capture connection logs if available',
        'Note if Tor browser bundle is present',
      ],
      crimeTypeBoost: {
        'Child Safety': 2,
        'Intrusion / Hacking': 2,
        'Narcotics': 1,
      },
    ),
    const EvidenceRule(
      keywords: ['crypto', 'bitcoin', 'wallet', 'ledger', 'trezor', 'cryptocurrency'],
      evidenceName: 'Cryptocurrency Wallet / Hardware',
      description: 'Crypto wallet that may contain transaction history and keys.',
      category: AppConstants.categoryStorage,
      volatilityScore: 8,
      recommendations: [
        'Handle hardware wallets with extreme care — do NOT reset',
        'Document wallet addresses visible on screen',
        'Do NOT attempt to unlock — may trigger wipe after failed attempts',
        'Photograph any recovery seed phrases found on paper',
        'Check for related software wallets on computers',
      ],
      crimeTypeBoost: {
        'Fraud': 2,
        'Narcotics': 2,
        'Terrorism': 1,
      },
    ),
  ];

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Analyze a free-text scene description and return identified evidence
  /// items sorted by volatility (highest first).
  ///
  /// [sceneDescription] — the officer's text description of the scene.
  /// [crimeType] — the selected crime type for sensitivity boosting.
  /// [caseId] — the database ID of the case these items belong to.
  static List<EvidenceEntity> analyzeScene({
    required String sceneDescription,
    required String crimeType,
    required int caseId,
  }) {
    final String input = sceneDescription.toLowerCase();
    final DateTime now = TimestampUtils.nowUtc();
    final Set<String> matchedNames = <String>{};
    final List<EvidenceEntity> results = <EvidenceEntity>[];

    for (final EvidenceRule rule in _rules) {
      // Check if any keyword matches the input.
      final bool matched = rule.keywords.any(
        (String kw) => input.contains(kw),
      );
      if (!matched) continue;

      // Deduplicate by evidence name.
      if (matchedNames.contains(rule.evidenceName)) continue;
      matchedNames.add(rule.evidenceName);

      // Apply crime-type boost.
      int adjustedScore = rule.volatilityScore;
      if (rule.crimeTypeBoost.containsKey(crimeType)) {
        adjustedScore += rule.crimeTypeBoost[crimeType]!;
      }
      // Clamp to 1-10.
      adjustedScore = adjustedScore.clamp(1, 10);

      final String level = AppConstants.volatilityLevelFromScore(adjustedScore);

      results.add(
        EvidenceEntity(
          caseId: caseId,
          name: rule.evidenceName,
          description: rule.description,
          category: rule.category,
          volatilityScore: adjustedScore,
          volatilityLevel: level,
          recommendations: rule.recommendations,
          source: 'rules_engine',
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // Sort by volatility score descending (highest priority first).
    results.sort(
      (EvidenceEntity a, EvidenceEntity b) =>
          b.volatilityScore.compareTo(a.volatilityScore),
    );

    return results;
  }

  /// Get the full list of rule keywords for autocomplete / suggestions.
  static List<String> getAllKeywords() {
    final Set<String> keywords = <String>{};
    for (final EvidenceRule rule in _rules) {
      keywords.addAll(rule.keywords);
    }
    return keywords.toList()..sort();
  }

  /// Get the total number of rules in the knowledge graph.
  static int get ruleCount => _rules.length;
}
