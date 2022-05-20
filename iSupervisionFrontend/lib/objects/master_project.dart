import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part 'master_project.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterProject extends Work {
  String description;
  String examDate;

  MasterProject(
      {int? id,
      required String title,
      required this.description,
      required String deadline,
      required this.examDate})
      : super(title: title, deadline: deadline, id: id);

  factory MasterProject.fromJson(Map<String, dynamic> json) =>
      _$MasterProjectFromJson(json);

  Map<String, dynamic> toJson() => _$MasterProjectToJson(this);
}
