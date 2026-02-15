import 'package:drift/drift.dart';

import 'package:dfei_opus/core/database/tables/cases_table.dart';

/// Drift table for identified evidence items within a case.
///
/// Each item is produced by the ForensicRulesEngine or manually added
/// by the officer. Items carry a volatility score for triage prioritization.
class EvidenceItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to [Cases].
  IntColumn get caseId =>
      integer().references(Cases, #id)();

  TextColumn get name => text().withLength(min: 1, max: 256)();

  TextColumn get description => text().withDefault(const Constant(''))();

  /// Category: e.g., "Computer", "Network", "IoT", "Mobile", "Storage", "Peripheral"
  TextColumn get category => text().withLength(min: 1, max: 64)();

  /// Numeric volatility score 1-10 (10 = most volatile / urgent).
  IntColumn get volatilityScore =>
      integer().check(volatilityScore.isBetweenValues(1, 10))();

  /// Human-readable level: CRITICAL, HIGH, MEDIUM, LOW
  TextColumn get volatilityLevel => text().withLength(min: 1, max: 16)();

  /// Actionable recommendations from the rules engine (JSON-encoded list).
  TextColumn get recommendations =>
      text().withDefault(const Constant('[]'))();

  /// Status: found, photographed, seized, released
  TextColumn get status =>
      text().withDefault(const Constant('found')).withLength(max: 32)();

  /// Source of identification: rules_engine, manual, sniffer
  TextColumn get source =>
      text().withDefault(const Constant('rules_engine')).withLength(max: 32)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
