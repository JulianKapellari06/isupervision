// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bachelor_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BachelorProject _$BachelorProjectFromJson(Map<String, dynamic> json) =>
    BachelorProject(
      id: json['id'] as int?,
      title: json['title'] as String,
      deadline: json['deadline'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BachelorProjectToJson(BachelorProject instance) =>
    <String, dynamic>{
      'title': instance.title,
      'deadline': instance.deadline,
      'id': instance.id,
      'description': instance.description,
    };
