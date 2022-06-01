import 'package:isupervision/objects/role.dart';
import 'package:isupervision/objects/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  ProjectRole projectRole;
  String? description;
  DateTime? examDate;
  String title;
  DateTime deadline;
  int? id;
  List<User>? user;

  Project(
      {this.user,
      this.description,
      this.examDate,
      required this.projectRole,
      required this.title,
      required this.deadline,
      this.id});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is Project && id == other.id;
  }
}
