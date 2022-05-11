import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/user.dart';
import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part '../serialization/bachelor_project.g.dart';

@JsonSerializable(explicitToJson: true)
class BachelorProject extends Work {
  String description;

  BachelorProject(
      {required String title,
      required DateTime deadline,
      required this.description})
      : super(title: title, deadline: deadline);

  factory BachelorProject.fromJson(Map<String, dynamic> json) =>
      _$BachelorProjectFromJson(json);

  Map<String, dynamic> toJson() => _$BachelorProjectToJson(this);
}
