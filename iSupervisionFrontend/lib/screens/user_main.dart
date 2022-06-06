import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:isupervision/customWidgets/project_card.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';
import 'package:isupervision/screens/login.dart';
import 'package:isupervision/screens/user_add_project.dart';
import 'package:isupervision/service/database_service.dart';

import '../customWidgets/custom_textstyle.dart';
import '../objects/user.dart';
import 'assistant_add_project.dart';

class UserMain extends StatefulWidget {
  final User user;

  const UserMain({required this.user, Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  late List<Project> projectList;
  late List<Project> bachelorList;
  late List<Project> masterList;
  @override
  void initState() {
    super.initState();
    projectList = widget.user.projects!
        .where((element) => element.projectRole == ProjectRole.Project)
        .toList();
    bachelorList = widget.user.projects!
        .where((element) => element.projectRole == ProjectRole.Bachelor)
        .toList();
    masterList = widget.user.projects!
        .where((element) => element.projectRole == ProjectRole.Master)
        .toList();
  }

  bool projects = false, bachelor = false, master = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.user.name),
        actions: [
          if (widget.user.userRole == UserRole.Assistant)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const AssistantAddProject())));
                },
                icon: const Icon(Icons.fiber_new)),
          if (widget.user.userRole == UserRole.Assistant)
            IconButton(
                onPressed: () {
                  changeLimitDialog(context);
                },
                icon: const Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserAddProject(
                  user: widget.user,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: const Color(0xFF1e1d23),
        constraints: BoxConstraints(minHeight: height - 56),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Projects",
                      style: CustomTextStyles.headerText(),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        setState(() {
                          projects = !projects;
                        });
                      },
                      color: Colors.white,
                      icon: Icon(
                          projects ? Icons.arrow_drop_down : Icons.arrow_right),
                    ),
                  ),
                  if (projects)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: projectList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ProjectCard(
                                userId: widget.user.id!,
                                project: projectList[index]),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Bachelor Projects",
                        style: CustomTextStyles.headerText()),
                    leading: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          bachelor = !bachelor;
                        });
                      },
                      icon: Icon(
                          bachelor ? Icons.arrow_drop_down : Icons.arrow_right),
                    ),
                  ),
                  if (bachelor)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bachelorList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ProjectCard(
                                userId: widget.user.id!,
                                project: bachelorList[index]),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Master Projects",
                        style: CustomTextStyles.headerText()),
                    leading: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          master = !master;
                        });
                      },
                      icon: Icon(
                          master ? Icons.arrow_drop_down : Icons.arrow_right),
                    ),
                  ),
                  if (master)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: masterList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ProjectCard(
                                userId: widget.user.id!,
                                project: masterList[index]),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeLimitDialog(BuildContext context) {
    bool _changed = false;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Color(0xFFee707d),
              ),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Limits: ",
                    style: CustomTextStyles.headerText(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Projects: ",
                        style: CustomTextStyles.standardText(),
                      ),
                      CustomNumberPicker(
                        valueTextStyle: CustomTextStyles.standardText(),
                        initialValue: widget.user.projectLimit!,
                        maxValue: 20,
                        minValue: 1,
                        step: 1,
                        onValue: (value) {
                          _changed = true;
                          widget.user.projectLimit = value as int?;
                        },
                      ),
                      Text(
                        "Bachelors: ",
                        style: CustomTextStyles.standardText(),
                      ),
                      CustomNumberPicker(
                        valueTextStyle: CustomTextStyles.standardText(),
                        initialValue: widget.user.bachelorLimit!,
                        maxValue: 5,
                        minValue: 1,
                        step: 1,
                        onValue: (value) {
                          _changed = true;
                          widget.user.bachelorLimit = value as int?;
                        },
                      ),
                      Text(
                        "Masters: ",
                        style: CustomTextStyles.standardText(),
                      ),
                      CustomNumberPicker(
                        valueTextStyle: CustomTextStyles.standardText(),
                        initialValue: widget.user.masterLimit!,
                        maxValue: 5,
                        minValue: 1,
                        step: 1,
                        onValue: (value) {
                          _changed = true;
                          widget.user.masterLimit = value as int?;
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_changed) {
                          try {
                            DatabaseService().updateLimits(
                                widget.user.id!,
                                widget.user.projectLimit,
                                widget.user.bachelorLimit,
                                widget.user.masterLimit);
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
                        Navigator.of(context).pop();
                      },
                      child: const Text("Save")),
                ],
              ),
            ),
          );
        });
  }
}
