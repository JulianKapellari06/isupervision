import 'package:isupervision/objects/work.dart';
import 'package:json_annotation/json_annotation.dart';

part '../serialization/project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project extends Work {
  Project({required String title, required DateTime deadline})
      : super(title: title, deadline: deadline);

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
