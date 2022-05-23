import 'dart:convert';

import 'package:http/http.dart';
import 'package:isupervision/objects/project.dart';

import '../objects/user.dart';

class DatabaseService {
  var header = {
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
        "true", // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
    "Accept": "application/json",
    'Content-type': 'application/json'
  };

  String ip = "10.0.0.19";

  Future<User> loginUser(String email, password) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/login/$email/$password');

    final response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<List<Project>> getAllProject() async {
    Uri uri = Uri.parse('http://$ip:8080/api/project/getAllProjects');

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
    Uri uri = Uri.parse('http://$ip:8080/api/user/getAll');
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

//Not Used
  Future<User> getUserById(int id) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/getUserById/$id');
    Response response = await get(uri, headers: header);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      throw "Unable to retrieve";
    }
  }

  Future<List<User>> getAllUserFiltered(String filter) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/searchUser/$filter');

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
    Uri uri = Uri.parse('http://$ip:8080/api/project/searchProject/$filter');

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

  void deleteUser(int? id) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/deleteUser/$id');

    Response response = await delete(uri, headers: header);

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void updateUser(User user) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/updateUser');

    Response response = await put(
      uri,
      headers: header,
      body: json.encode(user.toJson()),
      encoding: Encoding.getByName("utf-8"),
    );

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void updateProject(Project project) async {
    Uri uri = Uri.parse('http://$ip:8080/api/project/updateProject');
    Response response = await put(
      uri,
      headers: header,
      body: json.encode(project.toJson()),
      encoding: Encoding.getByName("utf-8"),
    );

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void deleteProject(int? id) async {
    Uri uri = Uri.parse('http://$ip:8080/api/project/deleteProject/$id');

    Response response = await delete(uri, headers: header);

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void addProject(Project project) async {
    Uri uri = Uri.parse('http://$ip:8080/api/project/addProject');
    Response response = await post(
      uri,
      headers: header,
      body: json.encode(project.toJson()),
      encoding: Encoding.getByName("utf-8"),
    );

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void addUser(User user) async {
    Uri uri = Uri.parse('http://$ip:8080/api/user/register');
    Response response = await post(
      uri,
      headers: header,
      body: json.encode(user.toJson()),
      encoding: Encoding.getByName("utf-8"),
    );

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }

  void deleteProjectsFromUser(int userId, List<int> list) async {
    print(list.toString());
    //TODO trash code
    String convert = "";
    for (int i = 0; i < list.length; i++) {
      if (i == list.length - 1) {
        convert += list[i].toString();
      } else {
        convert += list[i].toString() + ",";
      }
    }
    print(convert);

    Uri uri = Uri.parse(
        'http://$ip:8080/api/user/deleteProjectFromUser/$userId/$convert');

    Response response = await put(
      uri,
      headers: header,
      encoding: Encoding.getByName("utf-8"),
    );

    if (!(response.statusCode == 200)) {
      throw "Unable to retrieve";
    }
  }
}
