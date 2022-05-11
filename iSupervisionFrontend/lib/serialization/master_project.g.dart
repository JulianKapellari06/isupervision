// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../objects/master_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterProject _$MasterProjectFromJson(Map<String, dynamic> json) =>
    MasterProject(
      title: json['title'] as String,
      description: json['description'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      examDate: DateTime.parse(json['examDate'] as String),
    );

Map<String, dynamic> _$MasterProjectToJson(MasterProject instance) =>
    <String, dynamic>{
      'title': instance.title,
      'deadline': instance.deadline.toIso8601String(),
      'description': instance.description,
      'examDate': instance.examDate.toIso8601String(),
    };
