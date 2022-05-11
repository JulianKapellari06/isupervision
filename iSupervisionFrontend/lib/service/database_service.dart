import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../objects/user.dart';

class DatabaseService {
  Future<User> loginUser(String email, password) async {
    final body = {"email": "j.k@gmail.com", "password": "/12345"};

    // TODO If wrong input catch Error
    final response = await http.post(
      Uri.parse('http://10.0.0.19:8080/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }
}
