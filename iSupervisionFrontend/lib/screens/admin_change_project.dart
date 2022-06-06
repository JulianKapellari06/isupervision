import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textfield.dart';
import '../objects/project.dart';

import '../service/database_service.dart';

// ignore: must_be_immutable
class AdminChangeProject extends StatefulWidget {
  late Project project;
  late TextEditingController _idController;
  late TextEditingController _titleController;
  late TextEditingController _deadlineController;
  late TextEditingController _descriptionController;
  late TextEditingController _examDateController;

  AdminChangeProject({required this.project, Key? key}) : super(key: key) {
    _idController = TextEditingController(text: project.id.toString());
    _titleController = TextEditingController(text: project.title);
    _deadlineController = TextEditingController(
        text: DateFormat("yyyy-MM-dd").format(project.deadline));

    //If attribute is null set text empty string
    _descriptionController =
        TextEditingController(text: project.description ?? "");
    _examDateController = TextEditingController(
        text: project.examDate == null
            ? ""
            : DateFormat("yyyy-MM-dd").format(project.examDate!));
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
                try {
                  DatabaseService().deleteProject(widget.project.id);
                  Navigator.of(context).pop(true);
                } on Exception catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Something went wrong. Please try again!',
                      style: CustomTextStyles.errorText(),
                      textAlign: TextAlign.center,
                    )),
                  );
                }
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
                            icon: const Icon(Icons.edit_calendar),
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: widget.project.deadline,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));

                              if (newDate == null) {
                                return;
                              }
                              setState(() {
                                widget.project.deadline = newDate;
                                widget._deadlineController.text =
                                    "${newDate.day}-${newDate.month}-${newDate.year}";
                              });
                            },
                            controller: widget._deadlineController,
                            readOnly: true,
                            width: 300,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Required"),
                            ]),
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
                              enabled: widget.project.projectRole ==
                                  ProjectRole.Master,
                              icon: const Icon(Icons.edit_calendar),
                              onTap: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: widget.project.examDate ??
                                        DateTime.now(),
                                    firstDate: widget.project.deadline,
                                    lastDate: DateTime(2100));

                                if (newDate == null) {
                                  return;
                                }
                                setState(() {
                                  widget.project.examDate = newDate;
                                  widget._examDateController.text =
                                      "${newDate.day}-${newDate.month}-${newDate.year}";
                                });
                              },
                              controller: widget._examDateController,
                              readOnly: true,
                              width: 300,
                              validator: widget.project.projectRole !=
                                      ProjectRole.Master
                                  ? MinLengthValidator(0, errorText: "")
                                  : RequiredValidator(errorText: "Required")),
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
                                                clearEditingController(value);
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
                          try {
                            DatabaseService().updateProject(widget.project);
                          } on Exception catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                'Something went wrong. Please try again!',
                                style: CustomTextStyles.errorText(),
                                textAlign: TextAlign.center,
                              )),
                            );
                          }
                        }
                        if (deleteList.isNotEmpty) {
                          try {
                            DatabaseService().deleteUserFromProjects(
                                widget.project.id!, deleteList);
                          } on Exception catch (_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                'Something went wrong. Please try again!',
                                style: CustomTextStyles.errorText(),
                                textAlign: TextAlign.center,
                              )),
                            );
                          }
                        }
                        Navigator.of(context).pop(true);
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

  clearEditingController(ProjectRole role) {
    switch (role) {
      case ProjectRole.Bachelor:
        widget._examDateController.clear();
        break;
      case ProjectRole.Project:
        widget._examDateController.clear();
        widget._descriptionController.clear();
        break;
      case ProjectRole.Master:
        break;
    }
  }
}
