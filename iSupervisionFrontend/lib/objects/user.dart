import 'dart:collection';

import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/master_project.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';

class User {
  String name;
  String email;
  String password;
  Role role;
  List<Project> projects = List.empty(growable: true);
  List<BachelorProject> bachelorProject = List.empty(growable: true);
  List<MasterProject> masterProject = List.empty(growable: true);

  User(
      {required this.role,
      required this.email,
      required this.name,
      required this.password});
}
