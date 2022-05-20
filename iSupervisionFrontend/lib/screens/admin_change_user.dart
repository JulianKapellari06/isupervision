import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/user.dart';

class AdminChangeUser extends StatefulWidget {
  User user;

  AdminChangeUser({required this.user, Key? key}) : super(key: key);

  @override
  State<AdminChangeUser> createState() => _AdminChangeUserState();
}

class _AdminChangeUserState extends State<AdminChangeUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _emailController.text = widget.user.email;
    _nameController.text = widget.user.name;
    _idController.text = widget.user.id.toString();
    _passwordController.text = widget.user.password;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: width,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: const [
                  Text("Id: "),
                  Text("Name: "),
                  Text("Email: "),
                  Text("Password: "),
                  Text("Role: ")
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: _idController,
                    width: 300,
                    validator: RequiredValidator(errorText: "Required"),
                  ),
                  CustomTextField(
                    controller: _nameController,
                    width: 300,
                    validator: RequiredValidator(errorText: "Required"),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    width: 300,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(
                          errorText: "Please enter a valid email address"),
                    ]),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    width: 300,
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
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Projects:"),
                    ListView.builder(
                      itemBuilder: ((context, index) {
                        return Row(children: [
                          Text(widget.user.projects[index].title),
                          Text(widget.user.projects[index].deadline),
                          IconButton(
                              onPressed: () {
                                //TODO DELETE
                              },
                              icon: const Icon(Icons.delete))
                        ]);
                      }),
                      shrinkWrap: true,
                      itemCount: widget.user.projects.length,
                    ),
                    Text("Bachelor Project:"),
                    //TODO
                    Text("Master Project:"),
                    //TODO
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
