import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';
import 'package:use_case_manager/components/use_case_control.dart';
import 'package:use_case_manager/components/use_case_list.dart';

class UseCasePage extends StatefulWidget {
  const UseCasePage({super.key});

  @override
  State<UseCasePage> createState() => _UseCasePageState();
}

class _UseCasePageState extends State<UseCasePage> {
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
            children: [
              UseCaseList(),
              UseCaseControl()
            ],
          ),
        ),
      ),
      backgroundColor: UCMColorScheme.lightGray,
      drawer: UCMDrawer(navigateHome: () {}, navigateToProject: () {}),
      
    );
  }
}