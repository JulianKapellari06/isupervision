import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/master_project.dart';
import 'package:isupervision/objects/project.dart';

import '../objects/user.dart';

class DatabaseService {
  var header = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
  };

  Future<User> loginUser(String email, password) async {
    final body = {"email": "j.k@gmail.com", "password": "/12345"};

    Uri uri = Uri.parse('http://10.0.0.19:8080/api/user/login');
    uri.replace(queryParameters: body);

    final response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<List<Project>> getAllProject() async {
    Uri uri = Uri.parse('http://10.0.0.19:8080/api/project/getAllProjects');

    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Project> projects = body
          .map(
            (dynamic item) => Project.fromJson(item),
          )
          .toList();

      return projects;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<User>> getAllUser() async {
    Uri uri = Uri.parse('http://10.0.0.19:8080/api/user/getAll');
    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> user = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return user;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<BachelorProject>> getAllBachelorProjects() async {
    Uri uri =
        Uri.parse('http://10.0.0.19:8080/api/project/getAllBachelorProjects');
    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<BachelorProject> bachelor = body
          .map(
            (dynamic item) => BachelorProject.fromJson(item),
          )
          .toList();

      return bachelor;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<MasterProject>> getAllMasterProject() async {
    Uri uri =
        Uri.parse('http://10.0.0.19:8080/api/project/getAllMasterProjects');
    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<MasterProject> master = body
          .map(
            (dynamic item) => MasterProject.fromJson(item),
          )
          .toList();

      return master;
    } else {
      throw "Unable to retrieve";
    }
  }

//Not Used
  Future<User> getUserById(int id) async {
    Uri uri = Uri.parse('http://10.0.0.19:8080/api/user/getUserById/$id');
    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<User>> getAllUserFiltered(String filter) async {
    Uri uri = Uri.parse('http://10.0.0.19:8080/api/user/searchUser/$filter');

    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<User> user = body
          .map(
            (dynamic item) => User.fromJson(item),
          )
          .toList();

      return user;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<Project>> getAllProjectsFiltered(String filter) async {
    Uri uri =
        Uri.parse('http://10.0.0.19:8080/api/project/searchProject/$filter');

    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Project> project = body
          .map(
            (dynamic item) => Project.fromJson(item),
          )
          .toList();

      return project;
    } else {
      throw "Unable to retrieve";
    }
  }
}
