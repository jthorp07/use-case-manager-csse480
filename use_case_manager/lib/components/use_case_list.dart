import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/use_case.dart';

class UseCaseList extends StatefulWidget {
  const UseCaseList({super.key});

  @override
  State<UseCaseList> createState() => _UseCaseListState();
}

class _UseCaseListState extends State<UseCaseList> {
  List<Widget> _useCases(List<UseCase> ucs) {
    List<Widget> ucButtons = List.generate(ucs.length, (index) {
      UseCase uc = ucs[index];
      return TextButton(
        style: ButtonStyle(
            overlayColor:
                const MaterialStatePropertyAll(UCMColorScheme.darkGray),
            backgroundColor:
                (UseCaseDocumentMngr.instance.selectedUseCase.value ==
                        (uc.documentId ?? ""))
                    ? const MaterialStatePropertyAll(UCMColorScheme.roseRed)
                    : null),
        onPressed: () {
          setState(() {
            UseCaseDocumentMngr.instance.selectCase(uc.documentId ?? "");
          });
        },
        child: Text(
          uc.title,
          style: const TextStyle(
            color: UCMColorScheme.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      );
    });
    return [
      const Text(
        "Use Cases",
        style: TextStyle(
            color: UCMColorScheme.white,
            fontWeight: FontWeight.w700,
            fontSize: 30),
      ),
      const Divider(
        color: UCMColorScheme.darkGray,
        thickness: 15,
      ),
      ...ucButtons
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: UCMColorScheme.lightGray,
        ),
        child: StreamBuilder(
          stream: UseCaseCollectionMngr.instance.useCasesForCurrentProject,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    children: _useCases(snapshot.requireData),
                  )
                : snapshot.hasError
                    ? Center(
                        child: Text(
                        "Error: ${snapshot.error.toString()}",
                      ))
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              color: UCMColorScheme.roseRed,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting Use Cases...'),
                          ),
                        ],
                      );
          },
        ),
      ),
    ));
  }
}
