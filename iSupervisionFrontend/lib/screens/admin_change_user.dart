import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/user.dart';
import '../service/database_service.dart';

class AdminChangeUser extends StatefulWidget {
  User user;

  TextEditingController? _emailController;
  TextEditingController? _nameController;
  TextEditingController? _idController;
  TextEditingController? _passwordController;
  TextEditingController? _repasswordController;

  AdminChangeUser({required this.user, Key? key}) : super(key: key) {
    _emailController = TextEditingController(text: user.email);
    _nameController = TextEditingController(text: user.name);
    _idController = TextEditingController(text: user.id.toString());
    _passwordController = TextEditingController(text: user.password);
    _repasswordController = TextEditingController(text: user.password);
  }

  @override
  State<AdminChangeUser> createState() => _AdminChangeUserState();
}

class _AdminChangeUserState extends State<AdminChangeUser> {
  bool _changes = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<int> deleteList = List.empty(growable: true);

  int? _projectLimits;
  int? _bachelorLimits;
  int? _masterLimits;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Edit User with Id: " + widget.user.id.toString())),
        actions: [
          IconButton(
              onPressed: () {
                DatabaseService().deleteUser(widget.user.id);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: const Color(0xFF1e1d23),
            constraints: BoxConstraints(minHeight: _height - 56),
            width: _width,
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Id: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            trailing: CustomTextField(
                              enabled: false,
                              controller: widget._idController,
                              width: 300,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Name: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            trailing: CustomTextField(
                              controller: widget._nameController,
                              width: 300,
                              validator:
                                  RequiredValidator(errorText: "Required"),
                              onSaved: (String? val) {
                                if (widget.user.name != val) {
                                  widget.user.name = val!;
                                  _changes = true;
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Email: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            trailing: CustomTextField(
                              controller: widget._emailController,
                              width: 300,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Required"),
                                EmailValidator(
                                    errorText:
                                        "Please enter a valid email address"),
                              ]),
                              onSaved: (String? val) {
                                if (widget.user.email != val) {
                                  widget.user.email = val!;
                                  _changes = true;
                                }
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Password: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            trailing: CustomTextField(
                              isPassword: true,
                              controller: widget._passwordController,
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
                              onSaved: (String? val) {
                                if (widget.user.password != val) {
                                  widget.user.password = val!;
                                  _changes = true;
                                }
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
                              controller: widget._repasswordController,
                              width: 300,
                              validator: (String? value) {
                                if (value != widget._passwordController!.text) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (var value in UserRole.values)
                                      Expanded(
                                        child: RadioListTile(
                                            title: Text(value.name,
                                                style: CustomTextStyles
                                                    .standardText()),
                                            activeColor:
                                                const Color(0xFFee707d),
                                            value: value,
                                            groupValue: widget.user.userRole,
                                            onChanged: (UserRole? value) {
                                              setState(() {
                                                if (widget.user.userRole !=
                                                    value) {
                                                  widget.user.userRole = value!;
                                                  _changes = true;
                                                }
                                              });
                                            }),
                                      )
                                  ]),
                            ),
                          ),
                          if (widget.user.userRole == UserRole.Assistant)
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
                                  valueTextStyle:
                                      CustomTextStyles.standardText(),
                                  initialValue: widget.user.projectLimit!,
                                  maxValue: 20,
                                  minValue: 1,
                                  step: 1,
                                  onValue: (value) {
                                    _changes = true;
                                    widget.user.projectLimit = value as int?;
                                  },
                                ),
                                Text(
                                  "Bachelors: ",
                                  style: CustomTextStyles.standardText(),
                                ),
                                CustomNumberPicker(
                                  valueTextStyle:
                                      CustomTextStyles.standardText(),
                                  initialValue: widget.user.bachelorLimit!,
                                  maxValue: 5,
                                  minValue: 1,
                                  step: 1,
                                  onValue: (value) {
                                    _changes = true;
                                    widget.user.bachelorLimit = value as int?;
                                  },
                                ),
                                Text(
                                  "Masters: ",
                                  style: CustomTextStyles.standardText(),
                                ),
                                CustomNumberPicker(
                                  valueTextStyle:
                                      CustomTextStyles.standardText(),
                                  initialValue: widget.user.masterLimit!,
                                  maxValue: 5,
                                  minValue: 1,
                                  step: 1,
                                  onValue: (value) {
                                    _changes = true;
                                    widget.user.masterLimit = value as int?;
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Projects:",
                              style: CustomTextStyles.headerText()),
                          ListView.builder(
                            itemBuilder: ((context, index) {
                              return Container(
                                color: deleteList.contains(
                                        widget.user.projects![index].id)
                                    ? Colors.red
                                    : Colors.transparent,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.user.projects![index].title,
                                        style: CustomTextStyles.standardText(),
                                      ),
                                      Text(
                                          widget.user.projects![index].deadline
                                              .toString(),
                                          style:
                                              CustomTextStyles.standardText()),
                                      Text(
                                          widget.user.projects![index]
                                              .projectRole.name,
                                          style:
                                              CustomTextStyles.standardText()),
                                      IconButton(
                                        onPressed: () {
                                          /*
                                            Adds or removes the id from that project into deleting list. 
                                          */
                                          setState(() {
                                            if (deleteList.contains(widget
                                                .user.projects![index].id!)) {
                                              deleteList.remove(widget
                                                  .user.projects![index].id!);
                                            } else {
                                              deleteList.add(widget
                                                  .user.projects![index].id!);
                                            }
                                          });
                                        },
                                        icon: Icon(deleteList.contains(widget
                                                .user.projects![index].id!)
                                            ? Icons.add_task
                                            : Icons.delete),
                                        color: Colors.white,
                                      )
                                    ]),
                              );
                            }),
                            shrinkWrap: true,
                            itemCount: widget.user.projects?.length,
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  constraints: const BoxConstraints(
                    minHeight: 40,
                  ),
                  width: _width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      /* Checks whether the input is correct or not.
                         Updates the user object and if something has changed updating the database
                         If a project has deleted also updates the relation from user to project
                      */
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (widget.user.userRole != UserRole.Assistant) {
                          widget.user.bachelorLimit = 0;
                          widget.user.masterLimit = 0;
                          widget.user.projectLimit = 0;
                        }
                        if (_changes) {
                          DatabaseService().updateUser(widget.user);
                        }
                        if (deleteList.isNotEmpty) {
                          DatabaseService().deleteProjectsFromUser(
                              widget.user.id!, deleteList);
                        }
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    )),
                    child: const Text(
                      'SAVE',
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
    );
  }
}
