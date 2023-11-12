import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/managers/auth_manager.dart';

class UCMDrawer extends StatelessWidget {
  final void Function() navigateHome;
  final void Function() navigateToProject;

  const UCMDrawer({
    super.key,
    required this.navigateHome,
    required this.navigateToProject,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: const Text(
              "Use Case Manager",
              style: TextStyle(
                  color: UCMColorScheme.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            title: const Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
              navigateHome();
            },
          ),
          ListTile(
            title: const Text(
              "My First Project",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            leading: const Icon(Icons.home_repair_service),
            onTap: () {
              Navigator.of(context).pop();
              navigateToProject();
            },
          ),
          const Spacer(),
          const Divider(
            thickness: 2.0,
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              Navigator.of(context).pop();
              AuthManager.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
