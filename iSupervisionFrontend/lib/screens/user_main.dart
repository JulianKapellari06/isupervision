import 'package:flutter/material.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/objects/role.dart';
import 'package:isupervision/screens/login.dart';
import 'package:isupervision/screens/user_add_project.dart';
import 'package:isupervision/service/database_service.dart';

import '../customWidgets/custom_textstyle.dart';
import '../objects/user.dart';

class UserMain extends StatefulWidget {
  User user;

  UserMain({required this.user, Key? key}) : super(key: key);

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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.user.name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              icon: const Icon(Icons.logout))
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
                icon:
                    Icon(projects ? Icons.arrow_drop_down : Icons.arrow_right),
              ),
            ),
            if (projects)
              Container(
                width: width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: projectList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          projectList[index].title,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          projectList[index].deadline,
                          style: CustomTextStyles.standardText(),
                        ),
                        IconButton(
                          onPressed: () {
                            confirmationDialog(
                              context,
                              projectList[index],
                            );
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
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
                icon:
                    Icon(bachelor ? Icons.arrow_drop_down : Icons.arrow_right),
              ),
            ),
            if (bachelor)
              Container(
                width: width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bachelorList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          bachelorList[index].title,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          bachelorList[index].deadline,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          bachelorList[index].description!,
                          style: CustomTextStyles.standardText(),
                        ),
                        IconButton(
                          onPressed: () {
                            confirmationDialog(
                              context,
                              bachelorList[index],
                            );
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ListTile(
              title:
                  Text("Master Projects", style: CustomTextStyles.headerText()),
              leading: IconButton(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    master = !master;
                  });
                },
                icon: Icon(master ? Icons.arrow_drop_down : Icons.arrow_right),
              ),
            ),
            if (master)
              Container(
                width: width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: masterList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          masterList[index].title,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          masterList[index].deadline,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          masterList[index].description!,
                          style: CustomTextStyles.standardText(),
                        ),
                        Text(
                          masterList[index].examDate!,
                          style: CustomTextStyles.standardText(),
                        ),
                        IconButton(
                          onPressed: () {
                            confirmationDialog(context, masterList[index]);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void confirmationDialog(BuildContext context, Project project) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Remove Project: ${project.title}"),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    widget.user.projects!.remove(project);

                    DatabaseService().deleteProjectsFromUser(
                        widget.user.id!, List.of([project.id!]));
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
            content:
                const Text("Are you sure you want to remove this project?"),
          );
        });
  }
}
