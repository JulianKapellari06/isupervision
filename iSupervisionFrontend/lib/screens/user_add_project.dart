import 'package:flutter/material.dart';
import 'package:isupervision/customWidgets/custom_textfield.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';

import '../customWidgets/custom_textstyle.dart';
import '../objects/user.dart';
import '../service/database_service.dart';

class UserAddProject extends StatefulWidget {
  User user;
  UserAddProject({Key? key, required this.user}) : super(key: key);

  @override
  State<UserAddProject> createState() => _UserAddProjectState();
}

class _UserAddProjectState extends State<UserAddProject> {
  Future<List<Project>> projectList = DatabaseService().getAllProject();

  @override
  Widget build(BuildContext context) {
    String filter = "";
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add Project")),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF1e1d23),
          constraints: BoxConstraints(minHeight: height - 56),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
          width: width,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: CustomTextField(
                    controller: _searchController,
                    width: width,
                    hintText: "Search...",
                    icon: const Icon(
                      Icons.search,
                    ),
                    onTap: () {
                      _formKey.currentState!.save();
                      if (filter.isNotEmpty) {
                        setState(() {
                          projectList =
                              DatabaseService().getAllProjectsFiltered(filter);
                        });
                      }
                    },
                    onSaved: (String? val) {
                      setState(() {
                        filter = val!;
                      });
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: projectList,
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('${snapshot.error} occured'));
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    Project project = snapshot.data[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            project.title,
                                            style:
                                                CustomTextStyles.standardText(),
                                          ),
                                          Text(
                                            project.deadline.toString(),
                                            style:
                                                CustomTextStyles.standardText(),
                                          ),
                                          Text(
                                            project.projectRole.name,
                                            style:
                                                CustomTextStyles.standardText(),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                if (checkAddProject(
                                                    project, context)) {
                                                  confirmationDialog(
                                                      context, project);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.add_task,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkAddProject(Project project, BuildContext context) {
    if (widget.user.projects!.contains(project)) {
      errorDialog(context, "This project is already yours.");
      return false;
    } else {
      if (widget.user.userRole == UserRole.Student) {
        switch (project.projectRole) {
          case ProjectRole.Bachelor:
            if (!widget.user.projects!.any((element) =>
                element.projectRole == ProjectRole.Project &&
                element.deadline.isBefore(DateTime.now()))) {
              errorDialog(context,
                  "Before you can make a Bachelor project you have to be done with a project.");
              return false;
            }

            break;
          case ProjectRole.Master:
            if (!widget.user.projects!.any((element) =>
                element.projectRole == ProjectRole.Bachelor &&
                element.deadline.isBefore(DateTime.now()))) {
              errorDialog(context,
                  "Before you can make a Master project you have to be done with a Bachelor project.");
              return false;
            }

            break;
        }
        return true;
      } else {
        if (project.user!
            .any((element) => element.userRole == UserRole.Assistant)) {
          errorDialog(context, "This project already has an assistant.");
          return false;
        } else {
          switch (project.projectRole) {
            case ProjectRole.Project:
              int projectAmount = widget.user.projects!
                  .where(
                      (element) => element.projectRole == ProjectRole.Project)
                  .length;
              if (projectAmount == widget.user.projectLimit) {
                errorDialog(context, "Limit reached");
                return false;
              }
              break;
            case ProjectRole.Bachelor:
              int projectAmount = widget.user.projects!
                  .where(
                      (element) => element.projectRole == ProjectRole.Bachelor)
                  .length;
              if (projectAmount == widget.user.bachelorLimit) {
                errorDialog(context, "Limit reached");
                return false;
              }
              break;
            case ProjectRole.Master:
              int projectAmount = widget.user.projects!
                  .where((element) => element.projectRole == ProjectRole.Master)
                  .length;
              if (projectAmount == widget.user.masterLimit) {
                errorDialog(context, "Limit reached");
                return false;
              }
              break;
          }
          return true;
        }
      }
    }
  }

  void confirmationDialog(BuildContext context, Project project) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Project: ${project.title}"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    widget.user.projects!.add(project);
                    DatabaseService()
                        .addProjectToUser(widget.user.id!, project.id!);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
            content: const Text("Are you sure you want to add this project?"),
          );
        });
  }

  void errorDialog(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error!"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok")),
            ],
            content: Text(error),
          );
        });
  }
}
