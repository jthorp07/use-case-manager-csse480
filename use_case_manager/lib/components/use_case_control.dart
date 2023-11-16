import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/use_case.dart';

class UseCaseControl extends StatefulWidget {
  const UseCaseControl({super.key});

  @override
  State<UseCaseControl> createState() => _UseCaseControlState();
}

class _UseCaseControlState extends State<UseCaseControl> {
  UseCase? uc;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        children: [
          const Text("Use Case Details"),
          const SizedBox(),
          Row(
            children: [
              Container(),
              const SizedBox(),
              Column(
                children: [
                  Container(),
                  const SizedBox(),
                  const Row(
                    children: [
                      Column(
                        children: [
                          Text("Toggle Flow"),
                          Row(
                            children: [

                            ],
                          ),
                        ],
                      ),
                      SizedBox(),
                      Column(
                        children: [
                          Text("Toggle Flow"),
                          Row(
                            children: [

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
