import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/use_case.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

const fsUseCase_Collection = "UseCases";
const fsUseCase_Actors = "actors";
const fsUseCase_Title = "uc-name";
const fsUseCase_ProcessName = "uc-process";

class UseCaseCollectionMngr {
  final CollectionReference _ref;
  static final UseCaseCollectionMngr instance =
      UseCaseCollectionMngr._privateConstructor();

  UseCaseCollectionMngr._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection(fsUseCase_Collection);

  Future<bool> add({required String title, required String processName}) async {
    if (await instance.hasUseCase(title: title) == false) {
      instance._ref.add({
        fsUseCase_Title: title,
        fsUseCase_ProcessName: processName,
        fsParentId: ProjectCollectionManager.instance.selectedId,
      }).then((value) {
        UseCaseDocumentMngr.instance.addFlow(
            type: FlowType.basic, name: "Basic Flow", parentId: value.id);
      });
      return true;
    }
    return false;
  }

  Future<bool> hasUseCase({required String title, String docId = ""}) async {
    return _ref
        .where(fsParentId,
            isEqualTo: ProjectCollectionManager.instance.selectedId)
        .where(fsUseCase_Title, isEqualTo: title)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UseCase.fromFirestore(doc: snapshot),
            toFirestore: (useCase, _) => useCase.toMap())
        .get()
        .then(
      (value) {
        return value.size > 0 && value.docs.first.id != docId;
      },
    );
  }

  Stream<List<UseCase>> getAllCasesFromParent({required String docId}) {
    return _ref
        .where(fsParentId, isEqualTo: docId)
        .withConverter(
            fromFirestore: (doc, _) => UseCase.fromFirestore(doc: doc),
            toFirestore: (flow, _) => flow.toMap())
        .snapshots()
        .map((query) => query.docs.map((snap) => snap.data()).toList());
  }

  Stream<List<UseCase>> get useCasesForCurrentProject => _ref
      .where(fsParentId,
          isEqualTo: ProjectCollectionManager.instance.selectedId)
      .withConverter(
          fromFirestore: (snapshot, _) => UseCase.fromFirestore(doc: snapshot),
          toFirestore: (useCase, _) => useCase.toMap())
      .snapshots()
      .map((query) => query.docs.map((snap) => snap.data()).toList());

  Stream<UseCase> get currentUseCaseDocument => _ref
      .doc(UseCaseDocumentMngr.instance.selectedUseCase.value)
      .withConverter(
          fromFirestore: (snapshot, _) => UseCase.fromFirestore(doc: snapshot),
          toFirestore: (useCase, _) => useCase.toMap())
      .snapshots()
      .map((event) => event.data()!);
}
