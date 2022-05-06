import 'package:flutter/material.dart';
import 'package:isupervision/customWidgets/custom_textfield.dart';

class UserAddProject extends StatefulWidget {
  bool projects = false, bachelor = false, master = false;

  UserAddProject({Key? key}) : super(key: key);

  @override
  State<UserAddProject> createState() => _UserAddProjectState();
}

class _UserAddProjectState extends State<UserAddProject> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomTextField(
                hintText: "Search...",
                icon: const Icon(Icons.search),
                controller: _controller,
                width: 300,
                validator: (val) {
                  //TODO
                }),
            Row(
              children: [
                Container(
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
                      if (widget.projects) const Text("Projects")
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
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
                          const Text("Bachelor"),
                        ],
                      ),
                      if (widget.bachelor) const Text("Bachelor")
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
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
                          const Text("Master"),
                        ],
                      ),
                      if (widget.master) const Text("Master")
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
