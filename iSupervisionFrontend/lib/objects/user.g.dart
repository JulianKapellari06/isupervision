// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      projectLimit: json['projectLimit'] as int?,
      bachelorLimit: json['bachelorLimit'] as int?,
      masterLimit: json['masterLimit'] as int?,
      id: json['id'] as int?,
      userRole: $enumDecode(_$UserRoleEnumMap, json['userRole']),
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'userRole': _$UserRoleEnumMap[instance.userRole],
      'projects': instance.projects?.map((e) => e.toJson()).toList(),
      'projectLimit': instance.projectLimit,
      'bachelorLimit': instance.bachelorLimit,
      'masterLimit': instance.masterLimit,
    };

const _$UserRoleEnumMap = {
  UserRole.Student: 'Student',
  UserRole.Admin: 'Admin',
  UserRole.Assistant: 'Assistant',
};
