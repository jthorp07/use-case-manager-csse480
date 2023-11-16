import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/use_case.dart';

class UseCaseControl extends StatefulWidget {
  const UseCaseControl({super.key});

  @override
  State<UseCaseControl> createState() => _UseCaseControlState();
}

class _UseCaseControlState extends State<UseCaseControl> {
  UseCase? useCase;

  @override
  Widget build(BuildContext context) {
    if (useCase?.documentId !=
        UseCaseDocumentMngr.instance.selectedUseCase.value) {
      useCase = null;
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: UCMColorScheme.lightGray,
          ),
          child: ValueListenableBuilder(
              valueListenable: UseCaseDocumentMngr.instance.selectedUseCase,
              builder: (context, curUC, w) {
                return StreamBuilder(
                    stream: curUC == ""
                        ? null
                        : UseCaseCollectionMngr.instance.currentUseCaseDocument,
                    builder: (context, snap) {
                      UseCase? uc = useCase;
                      if (snap.data != null && uc == null) uc = snap!.data;
                      return StreamBuilder(
                          stream: UseCaseDocumentMngr.instance
                              .getAllFlowsFromParent(docId: curUC!),
                          builder: (context, flowSnaps) {
                            uc?.setFlow = flowSnaps.data ?? [];
                            uc?.sortFlows();
                            final ucNameController =
                                TextEditingController(text: uc?.title);
                            final ucProcessController =
                                TextEditingController(text: uc?.processName);
                            final ucStepController = TextEditingController();
                            final ucAlternateController =
                                TextEditingController();
                            final ucExceptionController =
                                TextEditingController();
                            return StreamBuilder(
                                stream: uc?.currentFlow.documentId == null
                                    ? null
                                    : UseCaseDocumentMngr.instance
                                        .getAllStepsFromParent(
                                            docId: uc!.currentFlow.documentId!),
                                builder: (context, flowSteps) {
                                  if (flowSteps.data != null) {
                                    uc?.currentFlow.setSteps = flowSteps.data!;
                                  }
                                  return Column(
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Use Case Details",
                                          style: TextStyle(
                                            color: UCMColorScheme.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: UCMColorScheme.darkGray,
                                        thickness: 15,
                                      ),
                                      Expanded(
                                        flex: 15,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      enabled: uc != null,
                                                      onFieldSubmitted:
                                                          (newName) {
                                                        UseCaseDocumentMngr
                                                            .instance
                                                            .updateUseCase(
                                                                docId: uc!
                                                                    .documentId!,
                                                                title:
                                                                    ucNameController
                                                                        .text,
                                                                processName: uc
                                                                    .processName);
                                                      },
                                                      style: const TextStyle(
                                                          color: UCMColorScheme
                                                              .white),
                                                      controller:
                                                          ucNameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            "Use Case Name",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                UCMColorScheme
                                                                    .white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      enabled: uc != null,
                                                      style: const TextStyle(
                                                          color: UCMColorScheme
                                                              .white),
                                                      onFieldSubmitted:
                                                          (newProcName) {
                                                        UseCaseDocumentMngr
                                                            .instance
                                                            .updateUseCase(
                                                                docId: uc!
                                                                    .documentId!,
                                                                title: uc.title,
                                                                processName:
                                                                    ucProcessController
                                                                        .text);
                                                      },
                                                      controller:
                                                          ucProcessController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            "Process Name",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                UCMColorScheme
                                                                    .white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      enabled: uc != null,
                                                      controller:
                                                          ucStepController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: "New Step",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                UCMColorScheme
                                                                    .white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      enabled: uc != null,
                                                      controller:
                                                          ucAlternateController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            "New Alternate Flow",
                                                        hintText: "",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                UCMColorScheme
                                                                    .white),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      enabled: uc != null,
                                                      controller:
                                                          ucExceptionController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            "New Exception Flow",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                UCMColorScheme
                                                                    .white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(
                                              color: UCMColorScheme.darkGray,
                                              thickness: 20,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: [
                                                  curUC == ""
                                                      ? const Placeholder()
                                                      : Builder(
                                                          builder: (context) {
                                                          final buff =
                                                              StringBuffer();
                                                          buff.write(
                                                              "Use Case: ${uc?.title ?? ""}\n");
                                                          buff.write(
                                                              "Process: ${uc?.processName ?? ""}\n");
                                                          buff.write(
                                                              "Current Flow: ${uc?.currentFlow.title}\n");
                                                          buff.write(
                                                              "Steps:\n");
                                                          int dex = 0;
                                                          uc?.currentFlow.steps
                                                              .forEach((step) {
                                                            buff.write(
                                                                "\t\t\t\t\t$dex. ${step.contents}\n");
                                                            dex++;
                                                          });
                                                          return RichText(
                                                            text: TextSpan(
                                                              text: buff
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color:
                                                                      UCMColorScheme
                                                                          .white),
                                                            ),
                                                          );
                                                        }),
                                                  //const Divider(thickness: 10),
                                                  // const Expanded(
                                                  //   flex: 2,
                                                  //   child: Row(
                                                  //     children: [],
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: UCMColorScheme.darkGray,
                                        thickness: 20,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      "Toggle Flow",
                                                      style: TextStyle(
                                                        color: UCMColorScheme
                                                            .white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            uc?.prevFlow();
                                                            setState(() {
                                                              useCase = uc;
                                                            });
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                const MaterialStatePropertyAll(
                                                                    UCMColorScheme
                                                                        .roseRed),
                                                            shape:
                                                                MaterialStatePropertyAll(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Prev",
                                                            style: TextStyle(
                                                                color:
                                                                    UCMColorScheme
                                                                        .white),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              uc?.nextFlow();
                                                              setState(() {
                                                                useCase = uc;
                                                              });
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  const MaterialStatePropertyAll(
                                                                      UCMColorScheme
                                                                          .roseRed),
                                                              shape:
                                                                  MaterialStatePropertyAll(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Next",
                                                              style: TextStyle(
                                                                  color:
                                                                      UCMColorScheme
                                                                          .white),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const VerticalDivider(
                                            //   color: UCMColorScheme.darkGray,
                                            //   thickness: 20,
                                            // ),
                                            // Expanded(
                                            //   child: Column(
                                            //     children: [
                                            //       const Expanded(
                                            //         child: Text(
                                            //           "Toggle Step",
                                            //           style: TextStyle(
                                            //             color: UCMColorScheme.white,
                                            //             fontWeight: FontWeight.w700,
                                            //             fontSize: 30,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       Expanded(
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .spaceEvenly,
                                            //           children: [
                                            //             ElevatedButton(
                                            //                 onPressed: () {},
                                            //                 style: ButtonStyle(
                                            //                   backgroundColor:
                                            //                       const MaterialStatePropertyAll(
                                            //                           UCMColorScheme
                                            //                               .roseRed),
                                            //                   shape:
                                            //                       MaterialStatePropertyAll(
                                            //                     RoundedRectangleBorder(
                                            //                       borderRadius:
                                            //                           BorderRadius
                                            //                               .circular(
                                            //                                   5),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //                 child: const Text(
                                            //                   "Prev",
                                            //                   style: TextStyle(
                                            //                       color:
                                            //                           UCMColorScheme
                                            //                               .white),
                                            //                 )),
                                            //             ElevatedButton(
                                            //                 onPressed: () {},
                                            //                 style: ButtonStyle(
                                            //                   backgroundColor:
                                            //                       const MaterialStatePropertyAll(
                                            //                           UCMColorScheme
                                            //                               .roseRed),
                                            //                   shape:
                                            //                       MaterialStatePropertyAll(
                                            //                     RoundedRectangleBorder(
                                            //                       borderRadius:
                                            //                           BorderRadius
                                            //                               .circular(
                                            //                                   5),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //                 child: const Text(
                                            //                   "Next",
                                            //                   style: TextStyle(
                                            //                       color:
                                            //                           UCMColorScheme
                                            //                               .white),
                                            //                 )),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          });
                    });
              }),
        ),
      ),
    );
  }
}
