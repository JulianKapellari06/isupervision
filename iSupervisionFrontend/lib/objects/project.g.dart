// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      user: (json['user'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      examDate: json['examDate'] as String?,
      projectRole: $enumDecode(_$ProjectRoleEnumMap, json['projectRole']),
      title: json['title'] as String,
      deadline: json['deadline'] as String,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'projectRole': _$ProjectRoleEnumMap[instance.projectRole],
      'description': instance.description,
      'examDate': instance.examDate,
      'title': instance.title,
      'deadline': instance.deadline,
      'id': instance.id,
      'user': instance.user?.map((e) => e.toJson()).toList(),
    };

const _$ProjectRoleEnumMap = {
  ProjectRole.Project: 'Project',
  ProjectRole.Bachelor: 'Bachelor',
  ProjectRole.Master: 'Master',
};
