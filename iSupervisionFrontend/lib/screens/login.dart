import 'package:flutter/material.dart';
import 'package:isupervision/customWidgets/custom_textfield.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/objects/role.dart';
import 'package:isupervision/screens/admin_main.dart';
import 'package:isupervision/screens/user_main.dart';
import 'package:isupervision/service/database_service.dart';

import '../objects/user.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFee707d), Color(0xFF74b5d8)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: width,
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 150,
                    height: 150,
                    color: Colors.white),
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    "Hello There.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 65,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
                  height: 500,
                  constraints: const BoxConstraints(maxWidth: 720),
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xFF1e1d23),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 72.0, horizontal: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Center(
                                    child: Text(
                                      "Member Login",
                                      style: TextStyle(
                                        color: Color(0xFFee707d),
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextField(
                                  hintText: "Email",
                                  icon: const Icon(
                                    Icons.email,
                                  ),
                                  controller: _emailController,
                                  width: 300,
                                  isEmail: true,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required"),
                                    EmailValidator(
                                        errorText:
                                            "Please enter a valid email address"),
                                  ]),
                                  onSaved: (String? val) {
                                    setState(() {
                                      email = val!;
                                    });
                                  },
                                ),
                                CustomTextField(
                                  hintText: "Password",
                                  icon: const Icon(
                                    Icons.password,
                                  ),
                                  controller: _passwordController,
                                  width: 300,
                                  isPassword: true,
                                  onSaved: (String? val) {
                                    setState(() {
                                      password = val!;
                                    });
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required"),
                                    MinLengthValidator(6,
                                        errorText:
                                            "Password must contain atleast 6 charachters"),
                                    PatternValidator(r'(?=.*?[#?!@$%^&*-/])',
                                        errorText:
                                            "Password must have atleast one special charachter")
                                  ]),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 24),
                                  constraints: const BoxConstraints(
                                    minHeight: 40,
                                  ),
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFee707d),
                                          Color(0xFF74b5d8)
                                        ]),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        User user = await DatabaseService()
                                            .loginUser(email, password);

                                        switch (user.userRole) {
                                          case UserRole.Student:
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: ((context) =>
                                                  UserMain(user: user)),
                                            ));
                                            break;
                                          case UserRole.Admin:
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: ((context) =>
                                                  AdminMain(admin: user)),
                                            ));
                                            break;
                                          case UserRole.Assistant:
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: ((context) =>
                                                  UserMain(user: user)),
                                            ));
                                            break;
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        )),
                                    child: const Text(
                                      'LOGIN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/panorama.jpg"),
                              fit: BoxFit.cover,
                              opacity: 0.5),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
