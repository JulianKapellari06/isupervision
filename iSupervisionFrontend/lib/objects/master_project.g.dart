// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterProject _$MasterProjectFromJson(Map<String, dynamic> json) =>
    MasterProject(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: json['deadline'] as String,
      examDate: json['examDate'] as String,
    );

Map<String, dynamic> _$MasterProjectToJson(MasterProject instance) =>
    <String, dynamic>{
      'title': instance.title,
      'deadline': instance.deadline,
      'id': instance.id,
      'description': instance.description,
      'examDate': instance.examDate,
    };
