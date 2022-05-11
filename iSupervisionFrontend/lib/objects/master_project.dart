import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part '../serialization/master_project.g.dart';

@JsonSerializable(explicitToJson: true)
class MasterProject extends Work {
  String description;
  DateTime examDate;

  MasterProject(
      {required String title,
      required this.description,
      required DateTime deadline,
      required this.examDate})
      : super(title: title, deadline: deadline);

  factory MasterProject.fromJson(Map<String, dynamic> json) =>
      _$MasterProjectFromJson(json);

  Map<String, dynamic> toJson() => _$MasterProjectToJson(this);
}
