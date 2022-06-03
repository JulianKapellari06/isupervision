import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../customWidgets/custom_textfield.dart';
import '../customWidgets/custom_textstyle.dart';
import '../objects/project.dart';
import '../objects/role.dart';
import '../service/database_service.dart';

class AssistantAddProject extends StatefulWidget {
  AssistantAddProject({Key? key}) : super(key: key);

  @override
  State<AssistantAddProject> createState() => _AssistantAddProjectState();
}

class _AssistantAddProjectState extends State<AssistantAddProject> {
  final GlobalKey<FormState> _formKeyProject = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _examDateController = TextEditingController();

  DateTime deadline = DateTime.now();
  DateTime examDate = DateTime.now();

  Project project = Project(
      projectRole: ProjectRole.Master, title: "", deadline: DateTime.now());

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Create Project"),
        ),
      ),
      body: Container(
        color: const Color(0xFF1e1d23),
        constraints: BoxConstraints(maxHeight: _height - 56),
        width: _width,
        child: Form(
          key: _formKeyProject,
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
                  icon: const Icon(Icons.edit_calendar),
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: deadline,
                        firstDate: deadline,
                        lastDate: DateTime(2100));

                    if (newDate == null) {
                      return;
                    }
                    setState(() {
                      deadline = newDate;
                      _deadlineController.text =
                          "${deadline.day}-${deadline.month}-${deadline.year}";
                      project.deadline = deadline;
                    });
                  },
                  controller: _deadlineController,
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
                  enabled: project.projectRole == ProjectRole.Bachelor ||
                      project.projectRole == ProjectRole.Master,
                  controller: _descriptionController,
                  width: 300,
                  validator: project.projectRole != ProjectRole.Project
                      ? RequiredValidator(errorText: "Required")
                      : MinLengthValidator(0, errorText: ""),
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
                    enabled: project.projectRole == ProjectRole.Master,
                    icon: const Icon(Icons.edit_calendar),
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: deadline,
                          firstDate: deadline,
                          lastDate: DateTime(2100));

                      if (newDate == null) {
                        return;
                      }
                      setState(() {
                        examDate = newDate;
                        _examDateController.text =
                            "${examDate.day}-${examDate.month}-${examDate.year}";
                        project.examDate = examDate;
                      });
                    },
                    controller: _examDateController,
                    readOnly: true,
                    width: 300,
                    validator: project.projectRole != ProjectRole.Master
                        ? MinLengthValidator(0, errorText: "")
                        : RequiredValidator(errorText: "Required")),
              ),
              ListTile(
                title: Text("Role: ", style: CustomTextStyles.standardText()),
                trailing: SizedBox(
                  width: 500,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var value in ProjectRole.values)
                          Expanded(
                            child: RadioListTile(
                                title: Text(value.name,
                                    style: CustomTextStyles.standardText()),
                                activeColor: const Color(0xFFee707d),
                                value: value,
                                groupValue: project.projectRole,
                                onChanged: (ProjectRole? value) {
                                  setState(() {
                                    project.projectRole = value!;
                                    clearEditingController(value);
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
                            content: Text('Inserted project to database...')),
                      );
                      Navigator.pop(context);
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
    );
  }

  clearEditingController(ProjectRole role) {
    switch (role) {
      case ProjectRole.Bachelor:
        _examDateController.clear();
        break;
      case ProjectRole.Project:
        _examDateController.clear();
        _descriptionController.clear();
        break;
    }
  }
}
