/// Domain entity for an identified piece of digital evidence.
///
/// Produced by the [ForensicRulesEngine] or added manually by the officer.
/// Carries volatility scoring for triage prioritization.
class EvidenceEntity {
  const EvidenceEntity({
    this.id,
    required this.caseId,
    required this.name,
    this.description = '',
    required this.category,
    required this.volatilityScore,
    required this.volatilityLevel,
    this.recommendations = const <String>[],
    this.status = 'found',
    this.source = 'rules_engine',
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int caseId;
  final String name;
  final String description;
  final String category;

  /// 1-10 scale. 10 = most volatile / urgent.
  final int volatilityScore;

  /// CRITICAL, HIGH, MEDIUM, LOW
  final String volatilityLevel;

  /// Actionable recommendations from the rules engine.
  final List<String> recommendations;

  /// found, photographed, seized, released
  final String status;

  /// rules_engine, manual, sniffer
  final String source;

  final DateTime createdAt;
  final DateTime updatedAt;

  EvidenceEntity copyWith({
    int? id,
    int? caseId,
    String? name,
    String? description,
    String? category,
    int? volatilityScore,
    String? volatilityLevel,
    List<String>? recommendations,
    String? status,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EvidenceEntity(
      id: id ?? this.id,
      caseId: caseId ?? this.caseId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      volatilityScore: volatilityScore ?? this.volatilityScore,
      volatilityLevel: volatilityLevel ?? this.volatilityLevel,
      recommendations: recommendations ?? this.recommendations,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Whether this item is in the highest urgency tier.
  bool get isCritical => volatilityLevel == 'CRITICAL';

  /// Whether this item has been fully secured.
  bool get isSecured => status == 'seized';

  @override
  String toString() =>
      'EvidenceEntity(name: $name, volatility: $volatilityScore/$volatilityLevel)';
}
