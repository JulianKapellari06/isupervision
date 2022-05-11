// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../objects/project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      title: json['title'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'title': instance.title,
      'deadline': instance.deadline.toIso8601String(),
    };
