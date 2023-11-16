import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/model/project.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projects;
  const ProjectList({super.key, required this.projects});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
                    itemCount: projects.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (ct, n) {
                      return ListTile(
                        onTap: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tileColor: UCMColorScheme.babyGray,
                        hoverColor: UCMColorScheme.darkGray,
                        title: Center(
                          child: Text(
                            projects.isNotEmpty ? projects[n].title : "Proj $n",
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
                    onPressed: () {},
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
}
