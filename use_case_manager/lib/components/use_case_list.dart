import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  List<Widget> useCases = [
    const Text("Use Cases", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
    const Divider(color: UCMColorScheme.darkGray),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: useCases,
        )
      )
    );
  }
}