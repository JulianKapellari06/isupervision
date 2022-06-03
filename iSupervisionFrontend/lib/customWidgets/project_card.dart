import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isupervision/objects/project.dart';

import '../service/database_service.dart';
import 'custom_textstyle.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int userId;
  const ProjectCard({required this.userId, required this.project, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFee707d),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.work),
            title: Text(project.title, style: CustomTextStyles.headerText()),
            subtitle: Text(
              "Deadline: ${DateFormat("yyyy-MM-dd").format(project.deadline)}",
              style: CustomTextStyles.standardText(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              project.user == null ? "No students..." : project.user.toString(),
              style: CustomTextStyles.standardText(),
            ),
          ),
          if (project.description != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                project.description!,
                style: CustomTextStyles.standardText(),
              ),
            ),
          if (project.examDate != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Exam Date: ${DateFormat("yyyy-MM-dd").format(project.examDate!)}",
                style: CustomTextStyles.standardText(),
              ),
            ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  confirmationDialog(context);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void confirmationDialog(BuildContext context) {
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
                    DatabaseService()
                        .deleteProjectsFromUser(userId, List.of([project.id!]));
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
