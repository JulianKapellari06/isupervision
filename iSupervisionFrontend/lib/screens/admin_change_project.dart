import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/project.dart';

import '../service/database_service.dart';

class AdminChangeProject extends StatefulWidget {
  late Project project;
  TextEditingController? _idController;
  TextEditingController? _titleController;
  TextEditingController? _deadlineController;
  TextEditingController? _descriptionController;
  TextEditingController? _examDateController;

  AdminChangeProject({required this.project, Key? key}) : super(key: key) {
    _idController = TextEditingController(text: project.id.toString());
    _titleController = TextEditingController(text: project.title);
    _deadlineController =
        TextEditingController(text: project.deadline.toString());

    //If attribute is null set text empty string
    _descriptionController =
        TextEditingController(text: project.description ?? "");
    _examDateController =
        TextEditingController(text: project.examDate.toString());
  }

  @override
  State<AdminChangeProject> createState() => _AdminChangeProjectState();
}

class _AdminChangeProjectState extends State<AdminChangeProject> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _changes = false;

  List<int> deleteList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Edit User with Id: " + widget.project.id.toString())),
        actions: [
          IconButton(
              //Deletes the actual project and navigates back to admin main screen
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
                            controller: widget._idController,
                            width: 300,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Title: ",
                            style: CustomTextStyles.standardText(),
                          ),
                          trailing: CustomTextField(
                            controller: widget._titleController,
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
                            controller: widget._deadlineController,
                            width: 300,
                            validator: MultiValidator([
                              DateValidator("dd-MM-yyyy",
                                  errorText: "Wrong Date Format"),
                              RequiredValidator(errorText: "Required"),
                            ]),
                            onSaved: (String? val) {
                              if (widget.project.deadline != val) {
                                widget.project.deadline = DateTime.parse(val!);
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
                            controller: widget._descriptionController,
                            width: 300,
                            validator: widget.project.projectRole !=
                                    ProjectRole.Project
                                ? RequiredValidator(errorText: "Required")
                                : MinLengthValidator(0, errorText: ""),
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
                            controller: widget._examDateController,
                            enabled: widget.project.projectRole ==
                                ProjectRole.Master,
                            width: 300,
                            validator: widget.project.projectRole ==
                                    ProjectRole.Master
                                ? MultiValidator([
                                    DateValidator("dd-MM-yyyy",
                                        errorText: "Wrong Date Format"),
                                    RequiredValidator(errorText: "Required"),
                                  ])
                                : MinLengthValidator(0, errorText: ""),
                            onSaved: (String? val) {
                              if (widget.project.examDate != val) {
                                widget.project.examDate = DateTime.parse(val!);
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
                                        widget.project.user![index].id)
                                    ? Colors.red
                                    : Colors.transparent,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.project.user![index].name,
                                        style: CustomTextStyles.standardText(),
                                      ),
                                      Text(widget.project.user![index].email,
                                          style:
                                              CustomTextStyles.standardText()),
                                      Text(
                                          widget.project.user![index].userRole
                                              .name,
                                          style:
                                              CustomTextStyles.standardText()),
                                      IconButton(
                                        onPressed: () {
                                          /*
                                            Adds or removes the id from that project into deleting list. 
                                          */
                                          setState(() {
                                            if (deleteList.contains(widget
                                                .project.user![index].id!)) {
                                              deleteList.remove(widget
                                                  .project.user![index].id!);
                                            } else {
                                              deleteList.add(widget
                                                  .project.user![index].id!);
                                            }
                                          });
                                        },
                                        icon: Icon(deleteList.contains(
                                                widget.project.user![index].id!)
                                            ? Icons.add_task
                                            : Icons.delete),
                                        color: Colors.white,
                                      )
                                    ]),
                              );
                            }),
                            shrinkWrap: true,
                            itemCount: widget.project.user?.length,
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
                    /*
                      Checks wether the input is valid or not.
                      If changes has been made update the database
                      Check role of object to set the expected null values;
                    */
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (_changes) {
                          switch (widget.project.projectRole) {
                            case ProjectRole.Project:
                              widget.project.description = null;
                              widget.project.examDate = null;
                              break;
                            case ProjectRole.Bachelor:
                              widget.project.examDate = null;
                              break;
                            case ProjectRole.Master:
                              break;
                          }
                          DatabaseService().updateProject(widget.project);
                        }
                        if (deleteList.isNotEmpty) {
                          DatabaseService().deleteUserFromProjects(
                              widget.project.id!, deleteList);
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
