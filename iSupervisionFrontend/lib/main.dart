import 'package:flutter/material.dart';
import 'package:isupervision/objects/role.dart';
import 'package:isupervision/screens/login.dart';
import 'package:isupervision/screens/user_add_project.dart';
import 'package:isupervision/screens/user_main.dart';

import 'objects/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ISupervision',
        theme: ThemeData(
          //TODO Change Color to Custom Red
          primarySwatch: Colors.red,
        ),
        home: //UserMain(
            // user: User(
            // role: Role.student,
            // email: "j.k@gmail.com",
            // password: "123345/",
            // name: "Julian Kapellari",
            // ),
            //),
            LogIn());
  }
}
