import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/objects/project.dart';

import '../customWidgets/custom_textfield.dart';
import '../customWidgets/custom_textstyle.dart';
import '../objects/role.dart';
import '../objects/user.dart';
import '../service/database_service.dart';

class AdminAdd extends StatefulWidget {
  AdminAdd({Key? key}) : super(key: key);

  @override
  State<AdminAdd> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  final GlobalKey<FormState> _formKeyUser = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyProject = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _examDateController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  User user =
      User(userRole: UserRole.Student, email: "", name: "", password: "");
  Project project = Project(
      projectRole: ProjectRole.Master, title: "", deadline: DateTime.now());

  int? _projectLimits;
  int? _bachelorLimits;
  int? _masterLimits;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add User / Project")),
      ),
      body: Container(
        color: const Color(0xFF1e1d23),
        constraints: BoxConstraints(minHeight: _height - 56),
        width: _width,
        child: Row(
          children: [
            Form(
              key: _formKeyUser,
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "User",
                        style: CustomTextStyles.headerText(),
                      ),
                      ListTile(
                        title: Text(
                          "Name: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _nameController,
                          width: 300,
                          validator: RequiredValidator(errorText: "Required"),
                          onSaved: (String? val) {
                            user.name = val!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Email: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _emailController,
                          width: 300,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            EmailValidator(
                                errorText:
                                    "Please enter a valid email address"),
                          ]),
                          onSaved: (String? val) {
                            user.email = val!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Password: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _passwordController,
                          width: 300,
                          isPassword: true,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password must contain atleast 6 charachters"),
                            PatternValidator(r'(?=.*?[#?!@$%^&*-/])',
                                errorText:
                                    "Password must have atleast one special charachter")
                          ]),
                          onSaved: (String? val) {
                            user.password = val!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Re-enter Password: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          isPassword: true,
                          controller: _repasswordController,
                          width: 300,
                          validator: (String? value) {
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("Role: ",
                            style: CustomTextStyles.standardText()),
                        trailing: SizedBox(
                          width: 500,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var value in UserRole.values)
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text(value.name,
                                            style: CustomTextStyles
                                                .standardText()),
                                        activeColor: const Color(0xFFee707d),
                                        value: value,
                                        groupValue: user.userRole,
                                        onChanged: (UserRole? value) {
                                          setState(() {
                                            user.userRole = value!;
                                          });
                                        }),
                                  )
                              ]),
                        ),
                      ),
                      if (user.userRole == UserRole.Assistant)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Limits: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            Text(
                              "Projects: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            CustomNumberPicker(
                              valueTextStyle: CustomTextStyles.standardText(),
                              initialValue: 10,
                              maxValue: 20,
                              minValue: 1,
                              step: 1,
                              onValue: (value) {
                                _projectLimits = value as int?;
                              },
                            ),
                            Text(
                              "Bachelors: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            CustomNumberPicker(
                              valueTextStyle: CustomTextStyles.standardText(),
                              initialValue: 3,
                              maxValue: 5,
                              minValue: 1,
                              step: 1,
                              onValue: (value) {
                                _bachelorLimits = value as int?;
                              },
                            ),
                            Text(
                              "Masters: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            CustomNumberPicker(
                              valueTextStyle: CustomTextStyles.standardText(),
                              initialValue: 3,
                              maxValue: 5,
                              minValue: 1,
                              step: 1,
                              onValue: (value) {
                                _masterLimits = value as int?;
                              },
                            ),
                          ],
                        ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        width: _width * 0.25,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKeyUser.currentState!.validate()) {
                              _formKeyUser.currentState!.save();
                              if (user.userRole == UserRole.Assistant) {
                                user.bachelorLimit = _bachelorLimits;
                                user.masterLimit = _masterLimits;
                                user.projectLimit = _projectLimits;
                              }
                              DatabaseService().addUser(user);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Inserted user to database...')),
                              );
                              clearTextInput(true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          )),
                          child: const Text(
                            'ADD',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 1,
              color: Colors.white,
            ),
            Form(
              key: _formKeyProject,
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Project",
                        style: CustomTextStyles.headerText(),
                      ),
                      ListTile(
                        title: Text(
                          "Title: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _titleController,
                          width: 300,
                          validator: RequiredValidator(errorText: "Required"),
                          onSaved: (String? val) {
                            project.title = val!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Deadline: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _deadlineController,
                          width: 300,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            DateValidator("dd-MM-yyyy",
                                errorText: "Wrong Date Format"),
                          ]),
                          onSaved: (String? val) {
                            project.deadline = DateTime.parse(val!);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Description: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          enabled:
                              project.projectRole == ProjectRole.Bachelor ||
                                  project.projectRole == ProjectRole.Master,
                          controller: _descriptionController,
                          width: 300,
                          validator: RequiredValidator(errorText: "Required"),
                          onSaved: (String? val) {
                            project.description = val!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Exam Date: ",
                          style: CustomTextStyles.standardText(),
                        ),
                        trailing: CustomTextField(
                          controller: _examDateController,
                          enabled: project.projectRole == ProjectRole.Master,
                          width: 300,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            DateValidator("dd-MM-yyyy",
                                errorText: "Wrong Date Format"),
                          ]),
                          onSaved: (String? val) {
                            project.examDate = DateTime.parse(val!);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text("Role: ",
                            style: CustomTextStyles.standardText()),
                        trailing: SizedBox(
                          width: 500,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var value in ProjectRole.values)
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text(value.name,
                                            style: CustomTextStyles
                                                .standardText()),
                                        activeColor: const Color(0xFFee707d),
                                        value: value,
                                        groupValue: project.projectRole,
                                        onChanged: (ProjectRole? value) {
                                          setState(() {
                                            project.projectRole = value!;
                                          });
                                        }),
                                  )
                              ]),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        constraints: const BoxConstraints(
                          minHeight: 40,
                        ),
                        width: _width * 0.25,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKeyProject.currentState!.validate()) {
                              _formKeyProject.currentState!.save();

                              DatabaseService().addProject(project);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Inserted project to database...')),
                              );
                              clearTextInput(false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          )),
                          child: const Text(
                            'ADD',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  clearTextInput(bool user) {
    if (!user) {
      _titleController.clear();
      _deadlineController.clear();
      _descriptionController.clear();
      _examDateController.clear();
    } else {
      _emailController.clear();
      _nameController.clear();
      _passwordController.clear();
      _repasswordController.clear();
    }
  }
}
