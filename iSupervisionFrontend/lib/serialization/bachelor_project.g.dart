// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../objects/bachelor_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BachelorProject _$BachelorProjectFromJson(Map<String, dynamic> json) =>
    BachelorProject(
      title: json['title'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$BachelorProjectToJson(BachelorProject instance) =>
    <String, dynamic>{
      'title': instance.title,
      'deadline': instance.deadline.toIso8601String(),
      'description': instance.description,
    };
