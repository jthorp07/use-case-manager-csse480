import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';
import 'package:use_case_manager/components/use_case_control.dart';
import 'package:use_case_manager/components/use_case_list.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/use_case.dart';

class UseCasePage extends StatefulWidget {
  const UseCasePage({super.key});

  @override
  State<UseCasePage> createState() => _UseCasePageState();
}

class _UseCasePageState extends State<UseCasePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: UCMColorScheme.darkGray,
        child: const Row(
          children: [
            Flexible(
              flex: 1,
              child: UseCaseList(),
            ),
            Flexible(
              flex: 3,
              child: UseCaseControl(),
            )
          ],
        ),
      ),
    );
  }
}
