import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
          child: const Row(
            children: [],
          ),
        ),
      ),
      backgroundColor: UCMColorScheme.lightGray,
      drawer: UCMDrawer(navigateHome: () {}, navigateToProject: () {}),
      
    );
  }
}