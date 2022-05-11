// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../objects/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      role: $enumDecode(_$RoleEnumMap, json['role']),
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      projects: (json['projects'] as List<dynamic>)
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
      bachelorProject: (json['bachelorProject'] as List<dynamic>)
          .map((e) => BachelorProject.fromJson(e as Map<String, dynamic>))
          .toList(),
      masterProject: (json['masterProject'] as List<dynamic>)
          .map((e) => MasterProject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': _$RoleEnumMap[instance.role],
      'projects': instance.projects,
      'bachelorProject': instance.bachelorProject,
      'masterProject': instance.masterProject,
    };

const _$RoleEnumMap = {
  Role.student: 'student',
  Role.admin: 'admin',
  Role.professor: 'professor',
};
