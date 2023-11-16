import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/model/project.dart';

class ProjectList extends StatefulWidget {
  final List<Project> projects;
  const ProjectList({super.key, required this.projects});
  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  final TextEditingController projectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context1, constraints) {
      return Container(
        constraints: BoxConstraints(maxWidth: constraints.maxWidth / 1.5),
        decoration: BoxDecoration(
            color: UCMColorScheme.lightGray,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 3,
                child: Material(
                  type: MaterialType.transparency,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.projects.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (ct, n) {
                      return ListTile(
                        onTap: () {
                          ProjectCollectionManager.instance
                              .selectProject(widget.projects[n], () {
                            Navigator.of(context1).pushNamed("/use_cases");
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tileColor: UCMColorScheme.babyGray,
                        hoverColor: UCMColorScheme.darkGray,
                        title: Center(
                          child: Text(
                            widget.projects.isNotEmpty
                                ? widget.projects[n].title
                                : "Project $n",
                            style: const TextStyle(color: UCMColorScheme.white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize:
                            const MaterialStatePropertyAll(Size.fromHeight(50)),
                        overlayColor: const MaterialStatePropertyAll(
                            UCMColorScheme.darkGray),
                        backgroundColor: const MaterialStatePropertyAll(
                            UCMColorScheme.roseRed),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      showNewProjectDialog(context, () {});
                    },
                    child: const Text(
                      "New Project",
                      style: TextStyle(color: UCMColorScheme.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void showNewProjectDialog(BuildContext context, Function onPressedCallback) {
    debugPrint("new project dialog");
    showDialog(
        context: context,
        builder: (context) {
          projectController.text = "";
          return AlertDialog(
            title: Text("New Project"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: projectController,
                  decoration: const InputDecoration(
                    labelText: "Project Name:",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  ProjectCollectionManager.instance
                      .add(title: projectController.text)
                      .then((success) {
                    onPressedCallback();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              ),
            ],
          );
        });
  }
}
