// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      userRole: $enumDecode(_$RoleEnumMap, json['userRole']),
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      projects: (json['projects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      bachelorProjects: (json['bachelorProjects'] as List<dynamic>)
          .map((e) => BachelorProject.fromJson(e as Map<String, dynamic>))
          .toList(),
      masterProjects: (json['masterProjects'] as List<dynamic>)
          .map((e) => MasterProject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'userRole': _$RoleEnumMap[instance.userRole],
      'projects': instance.projects.map((e) => e.toJson()).toList(),
      'bachelorProjects':
          instance.bachelorProjects.map((e) => e.toJson()).toList(),
      'masterProjects': instance.masterProjects.map((e) => e.toJson()).toList(),
    };

const _$RoleEnumMap = {
  Role.student: 'student',
  Role.admin: 'admin',
  Role.assistant: 'assistant',
};
