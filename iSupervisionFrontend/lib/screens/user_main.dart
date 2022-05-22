import 'package:flutter/material.dart';
import 'package:isupervision/screens/login.dart';
import 'package:isupervision/screens/user_add_project.dart';

import '../objects/user.dart';

class UserMain extends StatefulWidget {
  User user;
  bool projects = false, bachelor = false, master = false;
  UserMain({required this.user, Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
                builder: (context) => UserAddProject(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.projects = !widget.projects;
                    });
                  },
                  icon: Icon(widget.projects
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right),
                ),
                const Text("Projekt"),
              ],
            ),
            if (widget.projects)
              //TODO
              const Text("Projects..."),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.bachelor = !widget.bachelor;
                    });
                  },
                  icon: Icon(widget.bachelor
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right),
                ),
                const Text("Bachelorarbeit"),
              ],
            ),
            if (widget.bachelor)
              //TODO
              const Text("Bachelor..."),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.master = !widget.master;
                    });
                  },
                  icon: Icon(widget.master
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right),
                ),
                const Text("Masterarbeit"),
              ],
            ),
            if (widget.master)
              //TODO
              const Text("Master..."),
          ],
        ),
      ),
    );
  }
}
