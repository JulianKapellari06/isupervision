import 'dart:collection';

import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/master_project.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';
import 'package:json_annotation/json_annotation.dart';

part '../serialization/user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String name;
  String email;
  String password;
  Role role;
  List<Project> projects;
  List<BachelorProject> bachelorProject;
  List<MasterProject> masterProject;

  User({
    required this.role,
    required this.email,
    required this.name,
    required this.password,
    required this.projects,
    required this.bachelorProject,
    required this.masterProject,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
