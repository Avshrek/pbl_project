/// Application-wide constants for DFEI.
class AppConstants {
  AppConstants._();

  // ---------------------------------------------------------------------------
  // App metadata
  // ---------------------------------------------------------------------------

  static const String appName = 'DFEI';
  static const String appFullName = 'Digital Forensic Evidence Identifier';
  static const String appVersion = '1.0.0';

  // ---------------------------------------------------------------------------
  // Crime types (used in case initialization)
  // ---------------------------------------------------------------------------

  static const List<String> crimeTypes = [
    'Fraud',
    'Child Safety',
    'Intrusion / Hacking',
    'Narcotics',
    'Terrorism',
    'Homicide',
    'Theft / Burglary',
    'Domestic Violence',
    'Intellectual Property',
    'Cyberstalking',
    'Other',
  ];

  // ---------------------------------------------------------------------------
  // Evidence statuses (lifecycle)
  // ---------------------------------------------------------------------------

  static const String statusFound = 'found';
  static const String statusPhotographed = 'photographed';
  static const String statusSeized = 'seized';
  static const String statusReleased = 'released';

  static const List<String> evidenceStatuses = [
    statusFound,
    statusPhotographed,
    statusSeized,
    statusReleased,
  ];

  // ---------------------------------------------------------------------------
  // Volatility levels
  // ---------------------------------------------------------------------------

  static const String volatilityCritical = 'CRITICAL';
  static const String volatilityHigh = 'HIGH';
  static const String volatilityMedium = 'MEDIUM';
  static const String volatilityLow = 'LOW';

  /// Map numeric score (1-10) to a human-readable level.
  static String volatilityLevelFromScore(int score) {
    if (score >= 9) return volatilityCritical;
    if (score >= 7) return volatilityHigh;
    if (score >= 4) return volatilityMedium;
    return volatilityLow;
  }

  // ---------------------------------------------------------------------------
  // Audit log action types
  // ---------------------------------------------------------------------------

  static const String actionCaseCreated = 'case_created';
  static const String actionCaseClosed = 'case_closed';
  static const String actionItemFound = 'item_found';
  static const String actionItemPhotographed = 'item_photographed';
  static const String actionItemSeized = 'item_seized';
  static const String actionItemReleased = 'item_released';
  static const String actionReportExported = 'report_exported';
  static const String actionSceneScanned = 'scene_scanned';

  // ---------------------------------------------------------------------------
  // Evidence categories
  // ---------------------------------------------------------------------------

  static const String categoryComputer = 'Computer';
  static const String categoryNetwork = 'Network';
  static const String categoryIoT = 'IoT';
  static const String categoryMobile = 'Mobile';
  static const String categoryStorage = 'Storage';
  static const String categoryPeripheral = 'Peripheral';
  static const String categoryVolatile = 'Volatile Data';

  // ---------------------------------------------------------------------------
  // Case statuses
  // ---------------------------------------------------------------------------

  static const String caseActive = 'active';
  static const String caseClosed = 'closed';
  static const String caseExported = 'exported';

  // ---------------------------------------------------------------------------
  // Secure storage keys
  // ---------------------------------------------------------------------------

  static const String secureKeyPin = 'dfei_officer_pin';
  static const String secureKeyDbEncryption = 'dfei_db_key';
}
