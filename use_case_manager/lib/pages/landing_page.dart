import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/login_window.dart';
import 'package:use_case_manager/components/project_list_window.dart';
import 'package:use_case_manager/managers/auth_manager.dart';

class UseCaseManagerLandingPage extends StatefulWidget {
  const UseCaseManagerLandingPage({super.key});

  @override
  State<UseCaseManagerLandingPage> createState() =>
      _UseCaseManagerLandingPageState();
}

class _UseCaseManagerLandingPageState extends State<UseCaseManagerLandingPage> {
  bool signedIn = false;
  List<String> projNames = [
    "Project 1",
    "Project 2",
    "Project 3",
    "Project 4",
    "Project 5"
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth / 15,
              vertical: AuthManager.instance.isSignedIn
                  ? constraints.maxHeight / 10
                  : constraints.maxHeight / 5),
          child: Container(
            decoration: const BoxDecoration(
              color: UCMColorScheme.darkGray,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: UCMColorScheme.lightGray,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            AuthManager.instance.isSignedIn
                                ? "Select a Project"
                                : "Welcome to Use Case Manager",
                            style: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w600,
                                color: UCMColorScheme.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Flexible(flex: 1, child: SizedBox()),
                  Flexible(
                    flex: 4,
                    child: AuthManager.instance.isSignedIn
                        ? ProjectList(projNames: projNames)
                        : const LoginWindow(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
