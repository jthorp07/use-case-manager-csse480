import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';

class UseCaseManagerLandingPage extends StatefulWidget {
  const UseCaseManagerLandingPage({super.key});

  @override
  State<UseCaseManagerLandingPage> createState() =>
      _UseCaseManagerLandingPageState();
}

class _UseCaseManagerLandingPageState extends State<UseCaseManagerLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: UCMColorScheme.roseRed,
                ),
              child: IconButton(
                icon: const Icon(Icons.menu_rounded),
                color: UCMColorScheme.darkGray,
                onPressed: () { 
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          }
        ),
        title: const Text("Use Case Manager"),
        centerTitle: true,
        backgroundColor: UCMColorScheme.darkGray,
      ),
      body: Center(
        child: Container(
          color: UCMColorScheme.darkGray,
          child: Column(
            children: [

            ],
          ),
        ),
      ),
      backgroundColor: UCMColorScheme.lightGray,
      drawer: UCMDrawer(navigateHome: () {}, navigateToProject: () {}),
      
    );
  }
}
