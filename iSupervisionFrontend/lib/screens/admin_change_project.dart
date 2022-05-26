import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/project.dart';

import '../service/database_service.dart';

class AdminChangeProject extends StatefulWidget {
  late Project project;

  AdminChangeProject({required this.project, Key? key}) : super(key: key);

  @override
  State<AdminChangeProject> createState() => _AdminChangeProjectState();
}

class _AdminChangeProjectState extends State<AdminChangeProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _examDateController = TextEditingController();

  bool _changes = false;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    //TODO Could be better
    _idController.text = widget.project.id.toString();
    _titleController.text = widget.project.title;
    _deadlineController.text = widget.project.deadline;

    if (widget.project.projectRole == ProjectRole.Bachelor) {
      if (widget.project.description == null) {
        _descriptionController.text = "";
      } else {
        _descriptionController.text = widget.project.description!;
      }
    } else if (widget.project.projectRole == ProjectRole.Master) {
      if (widget.project.examDate == null) {
        _examDateController.text = "";
      } else {
        _examDateController.text = widget.project.examDate!;
        _descriptionController.text = widget.project.description!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Edit User with Id: " + widget.project.id.toString())),
        actions: [
          IconButton(
              onPressed: () {
                DatabaseService().deleteProject(widget.project.id);
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
                            "Title: ",
                            style: CustomTextStyles.standardText(),
                          ),
                          trailing: CustomTextField(
                            controller: _titleController,
                            width: 300,
                            validator: RequiredValidator(errorText: "Required"),
                            onSaved: (String? val) {
                              if (widget.project.title != val) {
                                widget.project.title = val!;
                                _changes = true;
                              }
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
                              DateValidator("dd-MM-yyyy",
                                  errorText: "Wrong Date Format"),
                              RequiredValidator(errorText: "Required"),
                            ]),
                            onSaved: (String? val) {
                              if (widget.project.deadline != val) {
                                widget.project.deadline = val!;
                                _changes = true;
                              }
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Description: ",
                            style: CustomTextStyles.standardText(),
                          ),
                          trailing: CustomTextField(
                            enabled: widget.project.projectRole ==
                                    ProjectRole.Bachelor ||
                                widget.project.projectRole ==
                                    ProjectRole.Master,
                            controller: _descriptionController,
                            width: 300,
                            validator: RequiredValidator(errorText: "Required"),
                            onSaved: (String? val) {
                              if (widget.project.description != val) {
                                widget.project.description = val!;
                                _changes = true;
                              }
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
                            enabled: widget.project.projectRole ==
                                ProjectRole.Master,
                            width: 300,
                            validator: MultiValidator([
                              DateValidator("dd-MM-yyyy",
                                  errorText: "Wrong Date Format"),
                              RequiredValidator(errorText: "Required"),
                            ]),
                            onSaved: (String? val) {
                              if (widget.project.examDate != val) {
                                widget.project.examDate = val!;
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
                                  for (var value in ProjectRole.values)
                                    Expanded(
                                      child: RadioListTile(
                                          title: Text(value.name,
                                              style: CustomTextStyles
                                                  .standardText()),
                                          activeColor: const Color(0xFFee707d),
                                          value: value,
                                          groupValue:
                                              widget.project.projectRole,
                                          onChanged: (ProjectRole? value) {
                                            setState(() {
                                              if (widget.project.projectRole !=
                                                  value) {
                                                widget.project.projectRole =
                                                    value!;
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
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("Students:",
                            style: CustomTextStyles.standardText()),
                        /* ListView.builder(
                          itemBuilder: ((context, index) {
                            return Row(children: [
                              Text(widget.project.user![index].name),
                              Text(widget.project.user![index].email),
                              IconButton(
                                  onPressed: () {
                                    //TODO DELETE
                                  },
                                  icon: const Icon(Icons.delete))
                            ]);
                          }),
                          shrinkWrap: true,
                          itemCount: widget.project.user!.length,
                        ),*/
                      ],
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
                          DatabaseService().updateProject(widget.project);
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
