import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project extends Work {
  Project({required String title, required String deadline, int? id})
      : super(title: title, deadline: deadline, id: id);

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
