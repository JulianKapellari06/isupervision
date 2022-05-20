import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isupervision/customWidgets/custom_textfield.dart';
import 'package:isupervision/customWidgets/custom_textstyle.dart';
import 'package:isupervision/objects/bachelor_project.dart';
import 'package:isupervision/objects/master_project.dart';
import 'package:isupervision/objects/project.dart';
import 'package:isupervision/service/database_service.dart';

import '../objects/user.dart';
import 'admin_change_user.dart';
import 'login.dart';

class AdminMain extends StatefulWidget {
  User admin;
  AdminMain({required this.admin, Key? key}) : super(key: key);

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  // Timer? _timer;
  Future<List<User>> userList = DatabaseService().getAllUser();
  Future<List<Project>> projectsList = DatabaseService().getAllProject();
  Future<List<BachelorProject>> bachelorList =
      DatabaseService().getAllBachelorProjects();
  Future<List<MasterProject>> masterList =
      DatabaseService().getAllMasterProject();

/*  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        projectsList = DatabaseService().getAllProject();
        userList = DatabaseService().getAllUser();
        bachelorList = DatabaseService().getAllBachelorProjects();
        masterList = DatabaseService().getAllMasterProject();
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _searchController = TextEditingController();
    String filter = "";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  projectsList = DatabaseService().getAllProject();
                  userList = DatabaseService().getAllUser();
                  bachelorList = DatabaseService().getAllBachelorProjects();
                  masterList = DatabaseService().getAllMasterProject();
                });
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF1e1d23),
          constraints: BoxConstraints(minHeight: height - 56),
          padding: const EdgeInsets.symmetric(vertical: 25),
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
                          userList =
                              DatabaseService().getAllUserFiltered(filter);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(children: [
                        Text(
                          "User",
                          style: CustomTextStyles.headerText(),
                        ),
                        FutureBuilder(
                            future: userList,
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
                                    itemBuilder: (ctx, index) {
                                      User user = snapshot.data[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              user.name,
                                              style: CustomTextStyles
                                                  .standardText(),
                                            ),
                                            Text(
                                              user.email,
                                              style: CustomTextStyles
                                                  .standardText(),
                                            ),
                                            Text(
                                              user.userRole.name,
                                              style: CustomTextStyles
                                                  .standardText(),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminChangeUser(
                                                              user: user),
                                                    ));
                                              },
                                              icon: const Icon(Icons.settings),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text(
                            "Projects",
                            style: CustomTextStyles.headerText(),
                          ),
                          FutureBuilder(
                              future: projectsList,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('${snapshot.error} occured'));
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) {
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
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              Text(
                                                project.deadline,
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.settings))
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Bachelor Projects",
                            style: CustomTextStyles.headerText(),
                          ),
                          FutureBuilder(
                              future: bachelorList,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('${snapshot.error} occured'));
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) {
                                        BachelorProject bachelor =
                                            snapshot.data[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                bachelor.title,
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              Text(
                                                bachelor.deadline,
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.settings))
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Master Projects",
                            style: CustomTextStyles.headerText(),
                          ),
                          FutureBuilder(
                              future: masterList,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('${snapshot.error} occured'));
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (ctx, index) {
                                        MasterProject master =
                                            snapshot.data[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                master.title,
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              Text(
                                                master.deadline,
                                                style: CustomTextStyles
                                                    .standardText(),
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      Icons.settings))
                                            ],
                                          ),
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
