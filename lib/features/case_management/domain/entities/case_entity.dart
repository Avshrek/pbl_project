/// Domain entity representing a forensic case.
///
/// This is a pure data class independent of any persistence layer.
/// It maps 1:1 with the Drift [Cases] table but exists in the domain
/// layer to maintain clean architecture boundaries.
class CaseEntity {
  const CaseEntity({
    this.id,
    required this.caseNumber,
    required this.crimeType,
    required this.location,
    required this.officerName,
    this.gpsLatitude,
    this.gpsLongitude,
    this.notes = '',
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String caseNumber;
  final String crimeType;
  final String location;
  final String officerName;
  final double? gpsLatitude;
  final double? gpsLongitude;
  final String notes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CaseEntity copyWith({
    int? id,
    String? caseNumber,
    String? crimeType,
    String? location,
    String? officerName,
    double? gpsLatitude,
    double? gpsLongitude,
    String? notes,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CaseEntity(
      id: id ?? this.id,
      caseNumber: caseNumber ?? this.caseNumber,
      crimeType: crimeType ?? this.crimeType,
      location: location ?? this.location,
      officerName: officerName ?? this.officerName,
      gpsLatitude: gpsLatitude ?? this.gpsLatitude,
      gpsLongitude: gpsLongitude ?? this.gpsLongitude,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Whether this case is currently active.
  bool get isActive => status == 'active';

  @override
  String toString() => 'CaseEntity(id: $id, case: $caseNumber, type: $crimeType)';
}
