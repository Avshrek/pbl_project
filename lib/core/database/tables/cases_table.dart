import 'package:drift/drift.dart';

/// Drift table for forensic case records.
///
/// Each row represents a single incident/case initiated by an officer
/// at a crime scene.
class Cases extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get caseNumber => text().withLength(min: 1, max: 64)();

  TextColumn get crimeType => text().withLength(min: 1, max: 128)();

  TextColumn get location => text().withLength(min: 1, max: 512)();

  TextColumn get officerName => text().withLength(min: 1, max: 256)();

  RealColumn get gpsLatitude => real().nullable()();

  RealColumn get gpsLongitude => real().nullable()();

  TextColumn get notes => text().withDefault(const Constant(''))();

  /// One of: active, closed, exported
  TextColumn get status =>
      text().withDefault(const Constant('active')).withLength(max: 32)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
