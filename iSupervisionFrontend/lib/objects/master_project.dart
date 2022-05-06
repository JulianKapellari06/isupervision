import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/user.dart';

class MasterProject extends Project {
  String description;
  DateTime examDate;

  MasterProject(
      {required String title,
      required DateTime deadline,
      required this.description,
      required this.examDate})
      : super(title: title, deadline: deadline);
}
