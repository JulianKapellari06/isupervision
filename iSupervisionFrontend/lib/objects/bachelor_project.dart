import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/user.dart';
import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bachelor_project.g.dart';

@JsonSerializable(explicitToJson: true)
class BachelorProject extends Work {
  String description;

  BachelorProject(
      {int? id,
      required String title,
      required String deadline,
      required this.description})
      : super(title: title, deadline: deadline, id: id);

  factory BachelorProject.fromJson(Map<String, dynamic> json) =>
      _$BachelorProjectFromJson(json);

  Map<String, dynamic> toJson() => _$BachelorProjectToJson(this);
}
