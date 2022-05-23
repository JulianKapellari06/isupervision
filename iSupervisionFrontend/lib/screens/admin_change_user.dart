import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/user.dart';
import '../service/database_service.dart';

class AdminChangeUser extends StatefulWidget {
  late User user;

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

  bool _changes = false;

  List<int> deleteList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    _emailController.text = widget.user.email;
    _nameController.text = widget.user.name;
    _idController.text = widget.user.id.toString();
    _passwordController.text = widget.user.password;
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
                              controller: _idController,
                              width: 300,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Name: ",
                              style: CustomTextStyles.standardText(),
                            ),
                            trailing: CustomTextField(
                              controller: _nameController,
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
                              controller: _emailController,
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
                              onSaved: (String? val) {
                                if (widget.user.password != val) {
                                  widget.user.password = val!;
                                  _changes = true;
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
                          )
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
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.user.projects![index].title,
                                      style: CustomTextStyles.standardText(),
                                    ),
                                    Text(widget.user.projects![index].deadline,
                                        style: CustomTextStyles.standardText()),
                                    Text(
                                        widget.user.projects![index].projectRole
                                            .name,
                                        style: CustomTextStyles.standardText()),
                                    IconButton(
                                        onPressed: () {
                                          _changes = true;
                                          deleteList.add(
                                              widget.user.projects![index].id!);
                                          setState(() {
                                            widget.user.projects!.remove(
                                                widget.user.projects![index]);
                                          });
                                        },
                                        icon: const Icon(Icons.delete))
                                  ]);
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (_changes) {
                          DatabaseService().updateUser(widget.user);
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
