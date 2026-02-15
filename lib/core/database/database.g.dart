// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CasesTable extends Cases with TableInfo<$CasesTable, Case> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _caseNumberMeta =
      const VerificationMeta('caseNumber');
  @override
  late final GeneratedColumn<String> caseNumber = GeneratedColumn<String>(
      'case_number', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _crimeTypeMeta =
      const VerificationMeta('crimeType');
  @override
  late final GeneratedColumn<String> crimeType = GeneratedColumn<String>(
      'crime_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 512),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _officerNameMeta =
      const VerificationMeta('officerName');
  @override
  late final GeneratedColumn<String> officerName = GeneratedColumn<String>(
      'officer_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 256),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _gpsLatitudeMeta =
      const VerificationMeta('gpsLatitude');
  @override
  late final GeneratedColumn<double> gpsLatitude = GeneratedColumn<double>(
      'gps_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLongitudeMeta =
      const VerificationMeta('gpsLongitude');
  @override
  late final GeneratedColumn<double> gpsLongitude = GeneratedColumn<double>(
      'gps_longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        caseNumber,
        crimeType,
        location,
        officerName,
        gpsLatitude,
        gpsLongitude,
        notes,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cases';
  @override
  VerificationContext validateIntegrity(Insertable<Case> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('case_number')) {
      context.handle(
          _caseNumberMeta,
          caseNumber.isAcceptableOrUnknown(
              data['case_number']!, _caseNumberMeta));
    } else if (isInserting) {
      context.missing(_caseNumberMeta);
    }
    if (data.containsKey('crime_type')) {
      context.handle(_crimeTypeMeta,
          crimeType.isAcceptableOrUnknown(data['crime_type']!, _crimeTypeMeta));
    } else if (isInserting) {
      context.missing(_crimeTypeMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('officer_name')) {
      context.handle(
          _officerNameMeta,
          officerName.isAcceptableOrUnknown(
              data['officer_name']!, _officerNameMeta));
    } else if (isInserting) {
      context.missing(_officerNameMeta);
    }
    if (data.containsKey('gps_latitude')) {
      context.handle(
          _gpsLatitudeMeta,
          gpsLatitude.isAcceptableOrUnknown(
              data['gps_latitude']!, _gpsLatitudeMeta));
    }
    if (data.containsKey('gps_longitude')) {
      context.handle(
          _gpsLongitudeMeta,
          gpsLongitude.isAcceptableOrUnknown(
              data['gps_longitude']!, _gpsLongitudeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Case map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Case(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      caseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}case_number'])!,
      crimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crime_type'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      officerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}officer_name'])!,
      gpsLatitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_latitude']),
      gpsLongitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_longitude']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CasesTable createAlias(String alias) {
    return $CasesTable(attachedDatabase, alias);
  }
}

class Case extends DataClass implements Insertable<Case> {
  final int id;
  final String caseNumber;
  final String crimeType;
  final String location;
  final String officerName;
  final double? gpsLatitude;
  final double? gpsLongitude;
  final String notes;

  /// One of: active, closed, exported
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Case(
      {required this.id,
      required this.caseNumber,
      required this.crimeType,
      required this.location,
      required this.officerName,
      this.gpsLatitude,
      this.gpsLongitude,
      required this.notes,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['case_number'] = Variable<String>(caseNumber);
    map['crime_type'] = Variable<String>(crimeType);
    map['location'] = Variable<String>(location);
    map['officer_name'] = Variable<String>(officerName);
    if (!nullToAbsent || gpsLatitude != null) {
      map['gps_latitude'] = Variable<double>(gpsLatitude);
    }
    if (!nullToAbsent || gpsLongitude != null) {
      map['gps_longitude'] = Variable<double>(gpsLongitude);
    }
    map['notes'] = Variable<String>(notes);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CasesCompanion toCompanion(bool nullToAbsent) {
    return CasesCompanion(
      id: Value(id),
      caseNumber: Value(caseNumber),
      crimeType: Value(crimeType),
      location: Value(location),
      officerName: Value(officerName),
      gpsLatitude: gpsLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLatitude),
      gpsLongitude: gpsLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLongitude),
      notes: Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Case.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Case(
      id: serializer.fromJson<int>(json['id']),
      caseNumber: serializer.fromJson<String>(json['caseNumber']),
      crimeType: serializer.fromJson<String>(json['crimeType']),
      location: serializer.fromJson<String>(json['location']),
      officerName: serializer.fromJson<String>(json['officerName']),
      gpsLatitude: serializer.fromJson<double?>(json['gpsLatitude']),
      gpsLongitude: serializer.fromJson<double?>(json['gpsLongitude']),
      notes: serializer.fromJson<String>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'caseNumber': serializer.toJson<String>(caseNumber),
      'crimeType': serializer.toJson<String>(crimeType),
      'location': serializer.toJson<String>(location),
      'officerName': serializer.toJson<String>(officerName),
      'gpsLatitude': serializer.toJson<double?>(gpsLatitude),
      'gpsLongitude': serializer.toJson<double?>(gpsLongitude),
      'notes': serializer.toJson<String>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Case copyWith(
          {int? id,
          String? caseNumber,
          String? crimeType,
          String? location,
          String? officerName,
          Value<double?> gpsLatitude = const Value.absent(),
          Value<double?> gpsLongitude = const Value.absent(),
          String? notes,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Case(
        id: id ?? this.id,
        caseNumber: caseNumber ?? this.caseNumber,
        crimeType: crimeType ?? this.crimeType,
        location: location ?? this.location,
        officerName: officerName ?? this.officerName,
        gpsLatitude: gpsLatitude.present ? gpsLatitude.value : this.gpsLatitude,
        gpsLongitude:
            gpsLongitude.present ? gpsLongitude.value : this.gpsLongitude,
        notes: notes ?? this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Case copyWithCompanion(CasesCompanion data) {
    return Case(
      id: data.id.present ? data.id.value : this.id,
      caseNumber:
          data.caseNumber.present ? data.caseNumber.value : this.caseNumber,
      crimeType: data.crimeType.present ? data.crimeType.value : this.crimeType,
      location: data.location.present ? data.location.value : this.location,
      officerName:
          data.officerName.present ? data.officerName.value : this.officerName,
      gpsLatitude:
          data.gpsLatitude.present ? data.gpsLatitude.value : this.gpsLatitude,
      gpsLongitude: data.gpsLongitude.present
          ? data.gpsLongitude.value
          : this.gpsLongitude,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Case(')
          ..write('id: $id, ')
          ..write('caseNumber: $caseNumber, ')
          ..write('crimeType: $crimeType, ')
          ..write('location: $location, ')
          ..write('officerName: $officerName, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      caseNumber,
      crimeType,
      location,
      officerName,
      gpsLatitude,
      gpsLongitude,
      notes,
      status,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Case &&
          other.id == this.id &&
          other.caseNumber == this.caseNumber &&
          other.crimeType == this.crimeType &&
          other.location == this.location &&
          other.officerName == this.officerName &&
          other.gpsLatitude == this.gpsLatitude &&
          other.gpsLongitude == this.gpsLongitude &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CasesCompanion extends UpdateCompanion<Case> {
  final Value<int> id;
  final Value<String> caseNumber;
  final Value<String> crimeType;
  final Value<String> location;
  final Value<String> officerName;
  final Value<double?> gpsLatitude;
  final Value<double?> gpsLongitude;
  final Value<String> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CasesCompanion({
    this.id = const Value.absent(),
    this.caseNumber = const Value.absent(),
    this.crimeType = const Value.absent(),
    this.location = const Value.absent(),
    this.officerName = const Value.absent(),
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CasesCompanion.insert({
    this.id = const Value.absent(),
    required String caseNumber,
    required String crimeType,
    required String location,
    required String officerName,
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : caseNumber = Value(caseNumber),
        crimeType = Value(crimeType),
        location = Value(location),
        officerName = Value(officerName);
  static Insertable<Case> custom({
    Expression<int>? id,
    Expression<String>? caseNumber,
    Expression<String>? crimeType,
    Expression<String>? location,
    Expression<String>? officerName,
    Expression<double>? gpsLatitude,
    Expression<double>? gpsLongitude,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseNumber != null) 'case_number': caseNumber,
      if (crimeType != null) 'crime_type': crimeType,
      if (location != null) 'location': location,
      if (officerName != null) 'officer_name': officerName,
      if (gpsLatitude != null) 'gps_latitude': gpsLatitude,
      if (gpsLongitude != null) 'gps_longitude': gpsLongitude,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CasesCompanion copyWith(
      {Value<int>? id,
      Value<String>? caseNumber,
      Value<String>? crimeType,
      Value<String>? location,
      Value<String>? officerName,
      Value<double?>? gpsLatitude,
      Value<double?>? gpsLongitude,
      Value<String>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CasesCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (caseNumber.present) {
      map['case_number'] = Variable<String>(caseNumber.value);
    }
    if (crimeType.present) {
      map['crime_type'] = Variable<String>(crimeType.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (officerName.present) {
      map['officer_name'] = Variable<String>(officerName.value);
    }
    if (gpsLatitude.present) {
      map['gps_latitude'] = Variable<double>(gpsLatitude.value);
    }
    if (gpsLongitude.present) {
      map['gps_longitude'] = Variable<double>(gpsLongitude.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CasesCompanion(')
          ..write('id: $id, ')
          ..write('caseNumber: $caseNumber, ')
          ..write('crimeType: $crimeType, ')
          ..write('location: $location, ')
          ..write('officerName: $officerName, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EvidenceItemsTable extends EvidenceItems
    with TableInfo<$EvidenceItemsTable, EvidenceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EvidenceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<int> caseId = GeneratedColumn<int>(
      'case_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cases (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 256),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _volatilityScoreMeta =
      const VerificationMeta('volatilityScore');
  @override
  late final GeneratedColumn<int> volatilityScore = GeneratedColumn<int>(
      'volatility_score', aliasedName, false,
      check: () => ComparableExpr(volatilityScore).isBetweenValues(1, 10),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _volatilityLevelMeta =
      const VerificationMeta('volatilityLevel');
  @override
  late final GeneratedColumn<String> volatilityLevel = GeneratedColumn<String>(
      'volatility_level', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _recommendationsMeta =
      const VerificationMeta('recommendations');
  @override
  late final GeneratedColumn<String> recommendations = GeneratedColumn<String>(
      'recommendations', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('found'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('rules_engine'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        caseId,
        name,
        description,
        category,
        volatilityScore,
        volatilityLevel,
        recommendations,
        status,
        source,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'evidence_items';
  @override
  VerificationContext validateIntegrity(Insertable<EvidenceItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('case_id')) {
      context.handle(_caseIdMeta,
          caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta));
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('volatility_score')) {
      context.handle(
          _volatilityScoreMeta,
          volatilityScore.isAcceptableOrUnknown(
              data['volatility_score']!, _volatilityScoreMeta));
    } else if (isInserting) {
      context.missing(_volatilityScoreMeta);
    }
    if (data.containsKey('volatility_level')) {
      context.handle(
          _volatilityLevelMeta,
          volatilityLevel.isAcceptableOrUnknown(
              data['volatility_level']!, _volatilityLevelMeta));
    } else if (isInserting) {
      context.missing(_volatilityLevelMeta);
    }
    if (data.containsKey('recommendations')) {
      context.handle(
          _recommendationsMeta,
          recommendations.isAcceptableOrUnknown(
              data['recommendations']!, _recommendationsMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EvidenceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EvidenceItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      caseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}case_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      volatilityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volatility_score'])!,
      volatilityLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}volatility_level'])!,
      recommendations: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recommendations'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $EvidenceItemsTable createAlias(String alias) {
    return $EvidenceItemsTable(attachedDatabase, alias);
  }
}

class EvidenceItem extends DataClass implements Insertable<EvidenceItem> {
  final int id;

  /// Foreign key to [Cases].
  final int caseId;
  final String name;
  final String description;

  /// Category: e.g., "Computer", "Network", "IoT", "Mobile", "Storage", "Peripheral"
  final String category;

  /// Numeric volatility score 1-10 (10 = most volatile / urgent).
  final int volatilityScore;

  /// Human-readable level: CRITICAL, HIGH, MEDIUM, LOW
  final String volatilityLevel;

  /// Actionable recommendations from the rules engine (JSON-encoded list).
  final String recommendations;

  /// Status: found, photographed, seized, released
  final String status;

  /// Source of identification: rules_engine, manual, sniffer
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EvidenceItem(
      {required this.id,
      required this.caseId,
      required this.name,
      required this.description,
      required this.category,
      required this.volatilityScore,
      required this.volatilityLevel,
      required this.recommendations,
      required this.status,
      required this.source,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['case_id'] = Variable<int>(caseId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['volatility_score'] = Variable<int>(volatilityScore);
    map['volatility_level'] = Variable<String>(volatilityLevel);
    map['recommendations'] = Variable<String>(recommendations);
    map['status'] = Variable<String>(status);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EvidenceItemsCompanion toCompanion(bool nullToAbsent) {
    return EvidenceItemsCompanion(
      id: Value(id),
      caseId: Value(caseId),
      name: Value(name),
      description: Value(description),
      category: Value(category),
      volatilityScore: Value(volatilityScore),
      volatilityLevel: Value(volatilityLevel),
      recommendations: Value(recommendations),
      status: Value(status),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EvidenceItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EvidenceItem(
      id: serializer.fromJson<int>(json['id']),
      caseId: serializer.fromJson<int>(json['caseId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      volatilityScore: serializer.fromJson<int>(json['volatilityScore']),
      volatilityLevel: serializer.fromJson<String>(json['volatilityLevel']),
      recommendations: serializer.fromJson<String>(json['recommendations']),
      status: serializer.fromJson<String>(json['status']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'caseId': serializer.toJson<int>(caseId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'volatilityScore': serializer.toJson<int>(volatilityScore),
      'volatilityLevel': serializer.toJson<String>(volatilityLevel),
      'recommendations': serializer.toJson<String>(recommendations),
      'status': serializer.toJson<String>(status),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EvidenceItem copyWith(
          {int? id,
          int? caseId,
          String? name,
          String? description,
          String? category,
          int? volatilityScore,
          String? volatilityLevel,
          String? recommendations,
          String? status,
          String? source,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      EvidenceItem(
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
  EvidenceItem copyWithCompanion(EvidenceItemsCompanion data) {
    return EvidenceItem(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      volatilityScore: data.volatilityScore.present
          ? data.volatilityScore.value
          : this.volatilityScore,
      volatilityLevel: data.volatilityLevel.present
          ? data.volatilityLevel.value
          : this.volatilityLevel,
      recommendations: data.recommendations.present
          ? data.recommendations.value
          : this.recommendations,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceItem(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('volatilityScore: $volatilityScore, ')
          ..write('volatilityLevel: $volatilityLevel, ')
          ..write('recommendations: $recommendations, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      caseId,
      name,
      description,
      category,
      volatilityScore,
      volatilityLevel,
      recommendations,
      status,
      source,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EvidenceItem &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.volatilityScore == this.volatilityScore &&
          other.volatilityLevel == this.volatilityLevel &&
          other.recommendations == this.recommendations &&
          other.status == this.status &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EvidenceItemsCompanion extends UpdateCompanion<EvidenceItem> {
  final Value<int> id;
  final Value<int> caseId;
  final Value<String> name;
  final Value<String> description;
  final Value<String> category;
  final Value<int> volatilityScore;
  final Value<String> volatilityLevel;
  final Value<String> recommendations;
  final Value<String> status;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EvidenceItemsCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.volatilityScore = const Value.absent(),
    this.volatilityLevel = const Value.absent(),
    this.recommendations = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EvidenceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int caseId,
    required String name,
    this.description = const Value.absent(),
    required String category,
    required int volatilityScore,
    required String volatilityLevel,
    this.recommendations = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : caseId = Value(caseId),
        name = Value(name),
        category = Value(category),
        volatilityScore = Value(volatilityScore),
        volatilityLevel = Value(volatilityLevel);
  static Insertable<EvidenceItem> custom({
    Expression<int>? id,
    Expression<int>? caseId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? volatilityScore,
    Expression<String>? volatilityLevel,
    Expression<String>? recommendations,
    Expression<String>? status,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (volatilityScore != null) 'volatility_score': volatilityScore,
      if (volatilityLevel != null) 'volatility_level': volatilityLevel,
      if (recommendations != null) 'recommendations': recommendations,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EvidenceItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? caseId,
      Value<String>? name,
      Value<String>? description,
      Value<String>? category,
      Value<int>? volatilityScore,
      Value<String>? volatilityLevel,
      Value<String>? recommendations,
      Value<String>? status,
      Value<String>? source,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return EvidenceItemsCompanion(
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<int>(caseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (volatilityScore.present) {
      map['volatility_score'] = Variable<int>(volatilityScore.value);
    }
    if (volatilityLevel.present) {
      map['volatility_level'] = Variable<String>(volatilityLevel.value);
    }
    if (recommendations.present) {
      map['recommendations'] = Variable<String>(recommendations.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EvidenceItemsCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('volatilityScore: $volatilityScore, ')
          ..write('volatilityLevel: $volatilityLevel, ')
          ..write('recommendations: $recommendations, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _caseIdMeta = const VerificationMeta('caseId');
  @override
  late final GeneratedColumn<int> caseId = GeneratedColumn<int>(
      'case_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cases (id)'));
  static const VerificationMeta _evidenceItemIdMeta =
      const VerificationMeta('evidenceItemId');
  @override
  late final GeneratedColumn<int> evidenceItemId = GeneratedColumn<int>(
      'evidence_item_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES evidence_items (id)'));
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _performedByMeta =
      const VerificationMeta('performedBy');
  @override
  late final GeneratedColumn<String> performedBy = GeneratedColumn<String>(
      'performed_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 256),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _utcTimestampMeta =
      const VerificationMeta('utcTimestamp');
  @override
  late final GeneratedColumn<DateTime> utcTimestamp = GeneratedColumn<DateTime>(
      'utc_timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sha256HashMeta =
      const VerificationMeta('sha256Hash');
  @override
  late final GeneratedColumn<String> sha256Hash = GeneratedColumn<String>(
      'sha256_hash', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 64, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _previousHashMeta =
      const VerificationMeta('previousHash');
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
      'previous_hash', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        caseId,
        evidenceItemId,
        action,
        details,
        performedBy,
        utcTimestamp,
        sha256Hash,
        previousHash
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('case_id')) {
      context.handle(_caseIdMeta,
          caseId.isAcceptableOrUnknown(data['case_id']!, _caseIdMeta));
    } else if (isInserting) {
      context.missing(_caseIdMeta);
    }
    if (data.containsKey('evidence_item_id')) {
      context.handle(
          _evidenceItemIdMeta,
          evidenceItemId.isAcceptableOrUnknown(
              data['evidence_item_id']!, _evidenceItemIdMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    if (data.containsKey('performed_by')) {
      context.handle(
          _performedByMeta,
          performedBy.isAcceptableOrUnknown(
              data['performed_by']!, _performedByMeta));
    } else if (isInserting) {
      context.missing(_performedByMeta);
    }
    if (data.containsKey('utc_timestamp')) {
      context.handle(
          _utcTimestampMeta,
          utcTimestamp.isAcceptableOrUnknown(
              data['utc_timestamp']!, _utcTimestampMeta));
    } else if (isInserting) {
      context.missing(_utcTimestampMeta);
    }
    if (data.containsKey('sha256_hash')) {
      context.handle(
          _sha256HashMeta,
          sha256Hash.isAcceptableOrUnknown(
              data['sha256_hash']!, _sha256HashMeta));
    } else if (isInserting) {
      context.missing(_sha256HashMeta);
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
          _previousHashMeta,
          previousHash.isAcceptableOrUnknown(
              data['previous_hash']!, _previousHashMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      caseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}case_id'])!,
      evidenceItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}evidence_item_id']),
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      performedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}performed_by'])!,
      utcTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}utc_timestamp'])!,
      sha256Hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha256_hash'])!,
      previousHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}previous_hash'])!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;

  /// Foreign key to [Cases].
  final int caseId;

  /// Foreign key to [EvidenceItems]. Nullable for case-level actions.
  final int? evidenceItemId;

  /// Action type: item_found, item_photographed, item_seized,
  /// item_released, case_created, case_closed, report_exported
  final String action;

  /// Free-text details of the action.
  final String details;

  /// Officer who performed the action.
  final String performedBy;

  /// Precise UTC timestamp (ISO 8601).
  final DateTime utcTimestamp;

  /// SHA-256 hash of (action + timestamp + previousHash + details).
  final String sha256Hash;

  /// Hash of the previous audit log entry (empty string for the first entry).
  final String previousHash;
  const AuditLog(
      {required this.id,
      required this.caseId,
      this.evidenceItemId,
      required this.action,
      required this.details,
      required this.performedBy,
      required this.utcTimestamp,
      required this.sha256Hash,
      required this.previousHash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['case_id'] = Variable<int>(caseId);
    if (!nullToAbsent || evidenceItemId != null) {
      map['evidence_item_id'] = Variable<int>(evidenceItemId);
    }
    map['action'] = Variable<String>(action);
    map['details'] = Variable<String>(details);
    map['performed_by'] = Variable<String>(performedBy);
    map['utc_timestamp'] = Variable<DateTime>(utcTimestamp);
    map['sha256_hash'] = Variable<String>(sha256Hash);
    map['previous_hash'] = Variable<String>(previousHash);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      caseId: Value(caseId),
      evidenceItemId: evidenceItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(evidenceItemId),
      action: Value(action),
      details: Value(details),
      performedBy: Value(performedBy),
      utcTimestamp: Value(utcTimestamp),
      sha256Hash: Value(sha256Hash),
      previousHash: Value(previousHash),
    );
  }

  factory AuditLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      caseId: serializer.fromJson<int>(json['caseId']),
      evidenceItemId: serializer.fromJson<int?>(json['evidenceItemId']),
      action: serializer.fromJson<String>(json['action']),
      details: serializer.fromJson<String>(json['details']),
      performedBy: serializer.fromJson<String>(json['performedBy']),
      utcTimestamp: serializer.fromJson<DateTime>(json['utcTimestamp']),
      sha256Hash: serializer.fromJson<String>(json['sha256Hash']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'caseId': serializer.toJson<int>(caseId),
      'evidenceItemId': serializer.toJson<int?>(evidenceItemId),
      'action': serializer.toJson<String>(action),
      'details': serializer.toJson<String>(details),
      'performedBy': serializer.toJson<String>(performedBy),
      'utcTimestamp': serializer.toJson<DateTime>(utcTimestamp),
      'sha256Hash': serializer.toJson<String>(sha256Hash),
      'previousHash': serializer.toJson<String>(previousHash),
    };
  }

  AuditLog copyWith(
          {int? id,
          int? caseId,
          Value<int?> evidenceItemId = const Value.absent(),
          String? action,
          String? details,
          String? performedBy,
          DateTime? utcTimestamp,
          String? sha256Hash,
          String? previousHash}) =>
      AuditLog(
        id: id ?? this.id,
        caseId: caseId ?? this.caseId,
        evidenceItemId:
            evidenceItemId.present ? evidenceItemId.value : this.evidenceItemId,
        action: action ?? this.action,
        details: details ?? this.details,
        performedBy: performedBy ?? this.performedBy,
        utcTimestamp: utcTimestamp ?? this.utcTimestamp,
        sha256Hash: sha256Hash ?? this.sha256Hash,
        previousHash: previousHash ?? this.previousHash,
      );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      caseId: data.caseId.present ? data.caseId.value : this.caseId,
      evidenceItemId: data.evidenceItemId.present
          ? data.evidenceItemId.value
          : this.evidenceItemId,
      action: data.action.present ? data.action.value : this.action,
      details: data.details.present ? data.details.value : this.details,
      performedBy:
          data.performedBy.present ? data.performedBy.value : this.performedBy,
      utcTimestamp: data.utcTimestamp.present
          ? data.utcTimestamp.value
          : this.utcTimestamp,
      sha256Hash:
          data.sha256Hash.present ? data.sha256Hash.value : this.sha256Hash,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('evidenceItemId: $evidenceItemId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('performedBy: $performedBy, ')
          ..write('utcTimestamp: $utcTimestamp, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('previousHash: $previousHash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, caseId, evidenceItemId, action, details,
      performedBy, utcTimestamp, sha256Hash, previousHash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.caseId == this.caseId &&
          other.evidenceItemId == this.evidenceItemId &&
          other.action == this.action &&
          other.details == this.details &&
          other.performedBy == this.performedBy &&
          other.utcTimestamp == this.utcTimestamp &&
          other.sha256Hash == this.sha256Hash &&
          other.previousHash == this.previousHash);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<int> caseId;
  final Value<int?> evidenceItemId;
  final Value<String> action;
  final Value<String> details;
  final Value<String> performedBy;
  final Value<DateTime> utcTimestamp;
  final Value<String> sha256Hash;
  final Value<String> previousHash;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.caseId = const Value.absent(),
    this.evidenceItemId = const Value.absent(),
    this.action = const Value.absent(),
    this.details = const Value.absent(),
    this.performedBy = const Value.absent(),
    this.utcTimestamp = const Value.absent(),
    this.sha256Hash = const Value.absent(),
    this.previousHash = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required int caseId,
    this.evidenceItemId = const Value.absent(),
    required String action,
    this.details = const Value.absent(),
    required String performedBy,
    required DateTime utcTimestamp,
    required String sha256Hash,
    this.previousHash = const Value.absent(),
  })  : caseId = Value(caseId),
        action = Value(action),
        performedBy = Value(performedBy),
        utcTimestamp = Value(utcTimestamp),
        sha256Hash = Value(sha256Hash);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<int>? caseId,
    Expression<int>? evidenceItemId,
    Expression<String>? action,
    Expression<String>? details,
    Expression<String>? performedBy,
    Expression<DateTime>? utcTimestamp,
    Expression<String>? sha256Hash,
    Expression<String>? previousHash,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caseId != null) 'case_id': caseId,
      if (evidenceItemId != null) 'evidence_item_id': evidenceItemId,
      if (action != null) 'action': action,
      if (details != null) 'details': details,
      if (performedBy != null) 'performed_by': performedBy,
      if (utcTimestamp != null) 'utc_timestamp': utcTimestamp,
      if (sha256Hash != null) 'sha256_hash': sha256Hash,
      if (previousHash != null) 'previous_hash': previousHash,
    });
  }

  AuditLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? caseId,
      Value<int?>? evidenceItemId,
      Value<String>? action,
      Value<String>? details,
      Value<String>? performedBy,
      Value<DateTime>? utcTimestamp,
      Value<String>? sha256Hash,
      Value<String>? previousHash}) {
    return AuditLogsCompanion(
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
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (caseId.present) {
      map['case_id'] = Variable<int>(caseId.value);
    }
    if (evidenceItemId.present) {
      map['evidence_item_id'] = Variable<int>(evidenceItemId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (performedBy.present) {
      map['performed_by'] = Variable<String>(performedBy.value);
    }
    if (utcTimestamp.present) {
      map['utc_timestamp'] = Variable<DateTime>(utcTimestamp.value);
    }
    if (sha256Hash.present) {
      map['sha256_hash'] = Variable<String>(sha256Hash.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('caseId: $caseId, ')
          ..write('evidenceItemId: $evidenceItemId, ')
          ..write('action: $action, ')
          ..write('details: $details, ')
          ..write('performedBy: $performedBy, ')
          ..write('utcTimestamp: $utcTimestamp, ')
          ..write('sha256Hash: $sha256Hash, ')
          ..write('previousHash: $previousHash')
          ..write(')'))
        .toString();
  }
}

abstract class _$DfeiDatabase extends GeneratedDatabase {
  _$DfeiDatabase(QueryExecutor e) : super(e);
  $DfeiDatabaseManager get managers => $DfeiDatabaseManager(this);
  late final $CasesTable cases = $CasesTable(this);
  late final $EvidenceItemsTable evidenceItems = $EvidenceItemsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cases, evidenceItems, auditLogs];
}

typedef $$CasesTableCreateCompanionBuilder = CasesCompanion Function({
  Value<int> id,
  required String caseNumber,
  required String crimeType,
  required String location,
  required String officerName,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<String> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CasesTableUpdateCompanionBuilder = CasesCompanion Function({
  Value<int> id,
  Value<String> caseNumber,
  Value<String> crimeType,
  Value<String> location,
  Value<String> officerName,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<String> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$CasesTableReferences
    extends BaseReferences<_$DfeiDatabase, $CasesTable, Case> {
  $$CasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EvidenceItemsTable, List<EvidenceItem>>
      _evidenceItemsRefsTable(_$DfeiDatabase db) =>
          MultiTypedResultKey.fromTable(db.evidenceItems,
              aliasName:
                  $_aliasNameGenerator(db.cases.id, db.evidenceItems.caseId));

  $$EvidenceItemsTableProcessedTableManager get evidenceItemsRefs {
    final manager = $$EvidenceItemsTableTableManager($_db, $_db.evidenceItems)
        .filter((f) => f.caseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_evidenceItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AuditLogsTable, List<AuditLog>>
      _auditLogsRefsTable(_$DfeiDatabase db) => MultiTypedResultKey.fromTable(
          db.auditLogs,
          aliasName: $_aliasNameGenerator(db.cases.id, db.auditLogs.caseId));

  $$AuditLogsTableProcessedTableManager get auditLogsRefs {
    final manager = $$AuditLogsTableTableManager($_db, $_db.auditLogs)
        .filter((f) => f.caseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CasesTableFilterComposer extends Composer<_$DfeiDatabase, $CasesTable> {
  $$CasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caseNumber => $composableBuilder(
      column: $table.caseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get crimeType => $composableBuilder(
      column: $table.crimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get officerName => $composableBuilder(
      column: $table.officerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> evidenceItemsRefs(
      Expression<bool> Function($$EvidenceItemsTableFilterComposer f) f) {
    final $$EvidenceItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.evidenceItems,
        getReferencedColumn: (t) => t.caseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EvidenceItemsTableFilterComposer(
              $db: $db,
              $table: $db.evidenceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> auditLogsRefs(
      Expression<bool> Function($$AuditLogsTableFilterComposer f) f) {
    final $$AuditLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.auditLogs,
        getReferencedColumn: (t) => t.caseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuditLogsTableFilterComposer(
              $db: $db,
              $table: $db.auditLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CasesTableOrderingComposer
    extends Composer<_$DfeiDatabase, $CasesTable> {
  $$CasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caseNumber => $composableBuilder(
      column: $table.caseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get crimeType => $composableBuilder(
      column: $table.crimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get officerName => $composableBuilder(
      column: $table.officerName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CasesTableAnnotationComposer
    extends Composer<_$DfeiDatabase, $CasesTable> {
  $$CasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get caseNumber => $composableBuilder(
      column: $table.caseNumber, builder: (column) => column);

  GeneratedColumn<String> get crimeType =>
      $composableBuilder(column: $table.crimeType, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get officerName => $composableBuilder(
      column: $table.officerName, builder: (column) => column);

  GeneratedColumn<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => column);

  GeneratedColumn<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> evidenceItemsRefs<T extends Object>(
      Expression<T> Function($$EvidenceItemsTableAnnotationComposer a) f) {
    final $$EvidenceItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.evidenceItems,
        getReferencedColumn: (t) => t.caseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EvidenceItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.evidenceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> auditLogsRefs<T extends Object>(
      Expression<T> Function($$AuditLogsTableAnnotationComposer a) f) {
    final $$AuditLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.auditLogs,
        getReferencedColumn: (t) => t.caseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuditLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.auditLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CasesTableTableManager extends RootTableManager<
    _$DfeiDatabase,
    $CasesTable,
    Case,
    $$CasesTableFilterComposer,
    $$CasesTableOrderingComposer,
    $$CasesTableAnnotationComposer,
    $$CasesTableCreateCompanionBuilder,
    $$CasesTableUpdateCompanionBuilder,
    (Case, $$CasesTableReferences),
    Case,
    PrefetchHooks Function({bool evidenceItemsRefs, bool auditLogsRefs})> {
  $$CasesTableTableManager(_$DfeiDatabase db, $CasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> caseNumber = const Value.absent(),
            Value<String> crimeType = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> officerName = const Value.absent(),
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CasesCompanion(
            id: id,
            caseNumber: caseNumber,
            crimeType: crimeType,
            location: location,
            officerName: officerName,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String caseNumber,
            required String crimeType,
            required String location,
            required String officerName,
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CasesCompanion.insert(
            id: id,
            caseNumber: caseNumber,
            crimeType: crimeType,
            location: location,
            officerName: officerName,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            notes: notes,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CasesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {evidenceItemsRefs = false, auditLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (evidenceItemsRefs) db.evidenceItems,
                if (auditLogsRefs) db.auditLogs
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (evidenceItemsRefs)
                    await $_getPrefetchedData<Case, $CasesTable, EvidenceItem>(
                        currentTable: table,
                        referencedTable:
                            $$CasesTableReferences._evidenceItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CasesTableReferences(db, table, p0)
                                .evidenceItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.caseId == item.id),
                        typedResults: items),
                  if (auditLogsRefs)
                    await $_getPrefetchedData<Case, $CasesTable, AuditLog>(
                        currentTable: table,
                        referencedTable:
                            $$CasesTableReferences._auditLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CasesTableReferences(db, table, p0).auditLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.caseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CasesTableProcessedTableManager = ProcessedTableManager<
    _$DfeiDatabase,
    $CasesTable,
    Case,
    $$CasesTableFilterComposer,
    $$CasesTableOrderingComposer,
    $$CasesTableAnnotationComposer,
    $$CasesTableCreateCompanionBuilder,
    $$CasesTableUpdateCompanionBuilder,
    (Case, $$CasesTableReferences),
    Case,
    PrefetchHooks Function({bool evidenceItemsRefs, bool auditLogsRefs})>;
typedef $$EvidenceItemsTableCreateCompanionBuilder = EvidenceItemsCompanion
    Function({
  Value<int> id,
  required int caseId,
  required String name,
  Value<String> description,
  required String category,
  required int volatilityScore,
  required String volatilityLevel,
  Value<String> recommendations,
  Value<String> status,
  Value<String> source,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$EvidenceItemsTableUpdateCompanionBuilder = EvidenceItemsCompanion
    Function({
  Value<int> id,
  Value<int> caseId,
  Value<String> name,
  Value<String> description,
  Value<String> category,
  Value<int> volatilityScore,
  Value<String> volatilityLevel,
  Value<String> recommendations,
  Value<String> status,
  Value<String> source,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$EvidenceItemsTableReferences
    extends BaseReferences<_$DfeiDatabase, $EvidenceItemsTable, EvidenceItem> {
  $$EvidenceItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$DfeiDatabase db) => db.cases
      .createAlias($_aliasNameGenerator(db.evidenceItems.caseId, db.cases.id));

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<int>('case_id')!;

    final manager = $$CasesTableTableManager($_db, $_db.cases)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AuditLogsTable, List<AuditLog>>
      _auditLogsRefsTable(_$DfeiDatabase db) =>
          MultiTypedResultKey.fromTable(db.auditLogs,
              aliasName: $_aliasNameGenerator(
                  db.evidenceItems.id, db.auditLogs.evidenceItemId));

  $$AuditLogsTableProcessedTableManager get auditLogsRefs {
    final manager = $$AuditLogsTableTableManager($_db, $_db.auditLogs)
        .filter((f) => f.evidenceItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EvidenceItemsTableFilterComposer
    extends Composer<_$DfeiDatabase, $EvidenceItemsTable> {
  $$EvidenceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get volatilityScore => $composableBuilder(
      column: $table.volatilityScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get volatilityLevel => $composableBuilder(
      column: $table.volatilityLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recommendations => $composableBuilder(
      column: $table.recommendations,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableFilterComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> auditLogsRefs(
      Expression<bool> Function($$AuditLogsTableFilterComposer f) f) {
    final $$AuditLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.auditLogs,
        getReferencedColumn: (t) => t.evidenceItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuditLogsTableFilterComposer(
              $db: $db,
              $table: $db.auditLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EvidenceItemsTableOrderingComposer
    extends Composer<_$DfeiDatabase, $EvidenceItemsTable> {
  $$EvidenceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get volatilityScore => $composableBuilder(
      column: $table.volatilityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get volatilityLevel => $composableBuilder(
      column: $table.volatilityLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recommendations => $composableBuilder(
      column: $table.recommendations,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableOrderingComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EvidenceItemsTableAnnotationComposer
    extends Composer<_$DfeiDatabase, $EvidenceItemsTable> {
  $$EvidenceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get volatilityScore => $composableBuilder(
      column: $table.volatilityScore, builder: (column) => column);

  GeneratedColumn<String> get volatilityLevel => $composableBuilder(
      column: $table.volatilityLevel, builder: (column) => column);

  GeneratedColumn<String> get recommendations => $composableBuilder(
      column: $table.recommendations, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableAnnotationComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> auditLogsRefs<T extends Object>(
      Expression<T> Function($$AuditLogsTableAnnotationComposer a) f) {
    final $$AuditLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.auditLogs,
        getReferencedColumn: (t) => t.evidenceItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AuditLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.auditLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EvidenceItemsTableTableManager extends RootTableManager<
    _$DfeiDatabase,
    $EvidenceItemsTable,
    EvidenceItem,
    $$EvidenceItemsTableFilterComposer,
    $$EvidenceItemsTableOrderingComposer,
    $$EvidenceItemsTableAnnotationComposer,
    $$EvidenceItemsTableCreateCompanionBuilder,
    $$EvidenceItemsTableUpdateCompanionBuilder,
    (EvidenceItem, $$EvidenceItemsTableReferences),
    EvidenceItem,
    PrefetchHooks Function({bool caseId, bool auditLogsRefs})> {
  $$EvidenceItemsTableTableManager(_$DfeiDatabase db, $EvidenceItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EvidenceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EvidenceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EvidenceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> caseId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int> volatilityScore = const Value.absent(),
            Value<String> volatilityLevel = const Value.absent(),
            Value<String> recommendations = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              EvidenceItemsCompanion(
            id: id,
            caseId: caseId,
            name: name,
            description: description,
            category: category,
            volatilityScore: volatilityScore,
            volatilityLevel: volatilityLevel,
            recommendations: recommendations,
            status: status,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int caseId,
            required String name,
            Value<String> description = const Value.absent(),
            required String category,
            required int volatilityScore,
            required String volatilityLevel,
            Value<String> recommendations = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              EvidenceItemsCompanion.insert(
            id: id,
            caseId: caseId,
            name: name,
            description: description,
            category: category,
            volatilityScore: volatilityScore,
            volatilityLevel: volatilityLevel,
            recommendations: recommendations,
            status: status,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EvidenceItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({caseId = false, auditLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (auditLogsRefs) db.auditLogs],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (caseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.caseId,
                    referencedTable:
                        $$EvidenceItemsTableReferences._caseIdTable(db),
                    referencedColumn:
                        $$EvidenceItemsTableReferences._caseIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (auditLogsRefs)
                    await $_getPrefetchedData<EvidenceItem, $EvidenceItemsTable,
                            AuditLog>(
                        currentTable: table,
                        referencedTable: $$EvidenceItemsTableReferences
                            ._auditLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EvidenceItemsTableReferences(db, table, p0)
                                .auditLogsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.evidenceItemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EvidenceItemsTableProcessedTableManager = ProcessedTableManager<
    _$DfeiDatabase,
    $EvidenceItemsTable,
    EvidenceItem,
    $$EvidenceItemsTableFilterComposer,
    $$EvidenceItemsTableOrderingComposer,
    $$EvidenceItemsTableAnnotationComposer,
    $$EvidenceItemsTableCreateCompanionBuilder,
    $$EvidenceItemsTableUpdateCompanionBuilder,
    (EvidenceItem, $$EvidenceItemsTableReferences),
    EvidenceItem,
    PrefetchHooks Function({bool caseId, bool auditLogsRefs})>;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required int caseId,
  Value<int?> evidenceItemId,
  required String action,
  Value<String> details,
  required String performedBy,
  required DateTime utcTimestamp,
  required String sha256Hash,
  Value<String> previousHash,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<int> caseId,
  Value<int?> evidenceItemId,
  Value<String> action,
  Value<String> details,
  Value<String> performedBy,
  Value<DateTime> utcTimestamp,
  Value<String> sha256Hash,
  Value<String> previousHash,
});

final class $$AuditLogsTableReferences
    extends BaseReferences<_$DfeiDatabase, $AuditLogsTable, AuditLog> {
  $$AuditLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CasesTable _caseIdTable(_$DfeiDatabase db) => db.cases
      .createAlias($_aliasNameGenerator(db.auditLogs.caseId, db.cases.id));

  $$CasesTableProcessedTableManager get caseId {
    final $_column = $_itemColumn<int>('case_id')!;

    final manager = $$CasesTableTableManager($_db, $_db.cases)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_caseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EvidenceItemsTable _evidenceItemIdTable(_$DfeiDatabase db) =>
      db.evidenceItems.createAlias($_aliasNameGenerator(
          db.auditLogs.evidenceItemId, db.evidenceItems.id));

  $$EvidenceItemsTableProcessedTableManager? get evidenceItemId {
    final $_column = $_itemColumn<int>('evidence_item_id');
    if ($_column == null) return null;
    final manager = $$EvidenceItemsTableTableManager($_db, $_db.evidenceItems)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_evidenceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AuditLogsTableFilterComposer
    extends Composer<_$DfeiDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get utcTimestamp => $composableBuilder(
      column: $table.utcTimestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sha256Hash => $composableBuilder(
      column: $table.sha256Hash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previousHash => $composableBuilder(
      column: $table.previousHash, builder: (column) => ColumnFilters(column));

  $$CasesTableFilterComposer get caseId {
    final $$CasesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableFilterComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EvidenceItemsTableFilterComposer get evidenceItemId {
    final $$EvidenceItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.evidenceItemId,
        referencedTable: $db.evidenceItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EvidenceItemsTableFilterComposer(
              $db: $db,
              $table: $db.evidenceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$DfeiDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action => $composableBuilder(
      column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get utcTimestamp => $composableBuilder(
      column: $table.utcTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sha256Hash => $composableBuilder(
      column: $table.sha256Hash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previousHash => $composableBuilder(
      column: $table.previousHash,
      builder: (column) => ColumnOrderings(column));

  $$CasesTableOrderingComposer get caseId {
    final $$CasesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableOrderingComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EvidenceItemsTableOrderingComposer get evidenceItemId {
    final $$EvidenceItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.evidenceItemId,
        referencedTable: $db.evidenceItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EvidenceItemsTableOrderingComposer(
              $db: $db,
              $table: $db.evidenceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$DfeiDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get performedBy => $composableBuilder(
      column: $table.performedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get utcTimestamp => $composableBuilder(
      column: $table.utcTimestamp, builder: (column) => column);

  GeneratedColumn<String> get sha256Hash => $composableBuilder(
      column: $table.sha256Hash, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
      column: $table.previousHash, builder: (column) => column);

  $$CasesTableAnnotationComposer get caseId {
    final $$CasesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.caseId,
        referencedTable: $db.cases,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CasesTableAnnotationComposer(
              $db: $db,
              $table: $db.cases,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EvidenceItemsTableAnnotationComposer get evidenceItemId {
    final $$EvidenceItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.evidenceItemId,
        referencedTable: $db.evidenceItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EvidenceItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.evidenceItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AuditLogsTableTableManager extends RootTableManager<
    _$DfeiDatabase,
    $AuditLogsTable,
    AuditLog,
    $$AuditLogsTableFilterComposer,
    $$AuditLogsTableOrderingComposer,
    $$AuditLogsTableAnnotationComposer,
    $$AuditLogsTableCreateCompanionBuilder,
    $$AuditLogsTableUpdateCompanionBuilder,
    (AuditLog, $$AuditLogsTableReferences),
    AuditLog,
    PrefetchHooks Function({bool caseId, bool evidenceItemId})> {
  $$AuditLogsTableTableManager(_$DfeiDatabase db, $AuditLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> caseId = const Value.absent(),
            Value<int?> evidenceItemId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> details = const Value.absent(),
            Value<String> performedBy = const Value.absent(),
            Value<DateTime> utcTimestamp = const Value.absent(),
            Value<String> sha256Hash = const Value.absent(),
            Value<String> previousHash = const Value.absent(),
          }) =>
              AuditLogsCompanion(
            id: id,
            caseId: caseId,
            evidenceItemId: evidenceItemId,
            action: action,
            details: details,
            performedBy: performedBy,
            utcTimestamp: utcTimestamp,
            sha256Hash: sha256Hash,
            previousHash: previousHash,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int caseId,
            Value<int?> evidenceItemId = const Value.absent(),
            required String action,
            Value<String> details = const Value.absent(),
            required String performedBy,
            required DateTime utcTimestamp,
            required String sha256Hash,
            Value<String> previousHash = const Value.absent(),
          }) =>
              AuditLogsCompanion.insert(
            id: id,
            caseId: caseId,
            evidenceItemId: evidenceItemId,
            action: action,
            details: details,
            performedBy: performedBy,
            utcTimestamp: utcTimestamp,
            sha256Hash: sha256Hash,
            previousHash: previousHash,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AuditLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({caseId = false, evidenceItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (caseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.caseId,
                    referencedTable:
                        $$AuditLogsTableReferences._caseIdTable(db),
                    referencedColumn:
                        $$AuditLogsTableReferences._caseIdTable(db).id,
                  ) as T;
                }
                if (evidenceItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.evidenceItemId,
                    referencedTable:
                        $$AuditLogsTableReferences._evidenceItemIdTable(db),
                    referencedColumn:
                        $$AuditLogsTableReferences._evidenceItemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AuditLogsTableProcessedTableManager = ProcessedTableManager<
    _$DfeiDatabase,
    $AuditLogsTable,
    AuditLog,
    $$AuditLogsTableFilterComposer,
    $$AuditLogsTableOrderingComposer,
    $$AuditLogsTableAnnotationComposer,
    $$AuditLogsTableCreateCompanionBuilder,
    $$AuditLogsTableUpdateCompanionBuilder,
    (AuditLog, $$AuditLogsTableReferences),
    AuditLog,
    PrefetchHooks Function({bool caseId, bool evidenceItemId})>;

class $DfeiDatabaseManager {
  final _$DfeiDatabase _db;
  $DfeiDatabaseManager(this._db);
  $$CasesTableTableManager get cases =>
      $$CasesTableTableManager(_db, _db.cases);
  $$EvidenceItemsTableTableManager get evidenceItems =>
      $$EvidenceItemsTableTableManager(_db, _db.evidenceItems);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
}
