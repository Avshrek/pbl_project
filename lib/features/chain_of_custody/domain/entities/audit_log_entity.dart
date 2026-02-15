/// Domain entity for a single chain-of-custody audit log entry.
///
/// Each entry records an action performed on evidence or a case,
/// with a SHA-256 hash linking to the previous entry to form a
/// tamper-evident chain.
class AuditLogEntity {
  const AuditLogEntity({
    this.id,
    required this.caseId,
    this.evidenceItemId,
    required this.action,
    this.details = '',
    required this.performedBy,
    required this.utcTimestamp,
    required this.sha256Hash,
    this.previousHash = '',
  });

  final int? id;
  final int caseId;
  final int? evidenceItemId;
  final String action;
  final String details;
  final String performedBy;
  final DateTime utcTimestamp;
  final String sha256Hash;
  final String previousHash;

  AuditLogEntity copyWith({
    int? id,
    int? caseId,
    int? evidenceItemId,
    String? action,
    String? details,
    String? performedBy,
    DateTime? utcTimestamp,
    String? sha256Hash,
    String? previousHash,
  }) {
    return AuditLogEntity(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      evidenceItemId: evidenceItemId ?? this.evidenceItemId,
      action: action ?? this.action,
      details: details ?? this.details,
      performedBy: performedBy ?? this.performedBy,
      utcTimestamp: utcTimestamp ?? this.utcTimestamp,
      sha256Hash: sha256Hash ?? this.sha256Hash,
      previousHash: previousHash ?? this.previousHash,
    );
  }

  @override
  String toString() =>
      'AuditLogEntity(action: $action, time: $utcTimestamp, hash: ${sha256Hash.substring(0, 8)}...)';
}
