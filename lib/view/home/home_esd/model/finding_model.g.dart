// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindingModel _$FindingModelFromJson(Map<String, dynamic> json) => FindingModel(
      findingType: json['findingType'] as String?,
      category: json['category'] as String?,
      observations: json['observations'] as String?,
      actionsTakenInField: json['actionsTakenInField'] as String?,
      actionsMustBeTaken: json['actionsMustBeTaken'] as String?,
      fieldManagerStatements: json['fieldManagerStatements'] as String?,
      file: json['file'] as String?,
      findingId: json['findingId'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$FindingModelToJson(FindingModel instance) =>
    <String, dynamic>{
      'findingType': instance.findingType,
      'findingId': instance.findingId,
      'category': instance.category,
      'observations': instance.observations,
      'actionsTakenInField': instance.actionsTakenInField,
      'actionsMustBeTaken': instance.actionsMustBeTaken,
      'fieldManagerStatements': instance.fieldManagerStatements,
      'file': instance.file,
      'key': instance.key,
    };
