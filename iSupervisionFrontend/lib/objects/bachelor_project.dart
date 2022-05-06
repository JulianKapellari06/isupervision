import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/user.dart';

class BachelorProject extends Project {
  String description;

  BachelorProject(
      {required String title,
      required DateTime deadline,
      required this.description})
      : super(title: title, deadline: deadline);
}
