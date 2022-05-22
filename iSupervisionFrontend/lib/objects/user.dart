import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int? id;
  String name;
  String email;
  String password;
  UserRole userRole;
  List<Project>? projects;

  User({
    this.id,
    required this.userRole,
    required this.email,
    required this.name,
    required this.password,
    this.projects,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
