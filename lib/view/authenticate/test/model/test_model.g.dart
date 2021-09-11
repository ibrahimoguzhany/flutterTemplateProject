// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );

Map<String, Object> _$TestModelToJson(TestModel instance) => <String, Object>{
      'userId': instance.userId!,
      'id': instance.id!,
      'title': instance.title!,
      'completed': instance.completed!,
    };
