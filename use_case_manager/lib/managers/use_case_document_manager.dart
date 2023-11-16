import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/model/flow_step.dart';
import 'package:use_case_manager/model/use_case.dart';
import 'package:use_case_manager/model/use_case_actor.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

// General Fields
const fsParentId = "parentId";
const fsOwnerId = "ownerUid";

// Actors Collection Fields
const fsActorsCollection = "Actors";
const fsActors_Name = "name";

// Flows Collection Fields
const fsFlowsCollection = "Flows";
const fsFlows_FlowType = "type";
const fsFlows_FlowName = "name";

// Flow Steps Collection Fields
const fsFlowStepsCollection = "FlowSteps";
const fsFlowSteps_Index = "stepIndex";
const fsFlowSteps_Step = "step";

class UseCaseDocumentMngr {
  static final instance = UseCaseDocumentMngr._privateConstructor();

  // Collection References
  final CollectionReference _ucRef;
  final CollectionReference _actorRef;
  final CollectionReference _flowRef;
  final CollectionReference _flowStepRef;

  // Current Selections
  final ValueNotifier<String> _selectedUseCase = ValueNotifier('');
  final ValueNotifier<String> _selectedFlow = ValueNotifier('');
  final ValueNotifier<String> _selectedFlowStep = ValueNotifier('');

  void selectCase(String docId) {
    _selectedUseCase.value = docId;
  }

  void selectFlow(String docId) {
    _selectedFlow.value = docId;
  }

  void selectFlowStep(String docId) {
    _selectedFlowStep.value = docId;
  }

  UseCaseDocumentMngr._privateConstructor()
      : _ucRef = FirebaseFirestore.instance.collection(fsUseCase_Collection),
        _actorRef = FirebaseFirestore.instance.collection(fsActorsCollection),
        _flowRef = FirebaseFirestore.instance.collection(fsFlowsCollection),
        _flowStepRef =
            FirebaseFirestore.instance.collection(fsFlowStepsCollection);

  // Use Case methods
  Future<bool> updateUseCase(
      {required String docId,
      required String title,
      required String processName}) async {
    if (await UseCaseCollectionMngr.instance.hasUseCase(title: title)) {
      return false;
    }
    _ucRef.doc(docId).update({
      fsUseCase_Title: title,
      fsUseCase_ProcessName: processName,
    });
    return true;
  }

  void removeUseCase({required String docId}) async {
    _ucRef.doc(docId).delete();
    getAllActorsFromParent(docId: docId).then((actorList) {
      for (Actor a in actorList) {
        removeActor(docId: a.documentId!);
      }
    });
    Stream<List<UseCaseFlow>> stream = getAllFlowsFromParent(docId: docId);
    stream.forEach((flowList) {
      for (UseCaseFlow f in flowList) {
        removeFlow(docId: f.documentId!);
      }
    });
  }

  // Actor methods
  void addActor({required String name}) {
    _actorRef.add({
      fsActors_Name: name,
      fsParentId: _selectedUseCase,
    });
  }

  Future<List<Actor>> get ucActors {
    return _actorRef
        .where(fsParentId, isEqualTo: _selectedUseCase)
        .withConverter(
            fromFirestore: (doc, _) => Actor.fromFirestore(doc: doc),
            toFirestore: (actor, _) => actor.toMap())
        .get()
        .then((query) {
      return query.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  void removeActor({required String docId}) {
    _actorRef.doc(docId).delete();
  }

  Future<List<Actor>> getAllActorsFromParent({required String docId}) {
    return _actorRef
        .where(fsParentId, isEqualTo: docId)
        .withConverter(
            fromFirestore: (doc, _) => Actor.fromFirestore(doc: doc),
            toFirestore: (step, _) => step.toMap())
        .get()
        .then((query) => query.docs.map((doc) => doc.data()).toList());
  }

  // Flow methods
  void addFlow({required FlowType type, required String name}) async {
    _flowRef.add({
      fsFlows_FlowName: name,
      fsFlows_FlowType: type.toString(),
      fsParentId: _selectedUseCase
    });
  }

  Future<bool> updateFlow(
      {required String docId,
      required FlowType type,
      required String title}) async {
    if (await _hasFlow(title: title)) {
      return false;
    }
    _flowRef.doc(docId).update({
      fsFlows_FlowName: title,
      fsFlows_FlowType: UseCaseFlow.typeToString(type),
    });
    return true;
  }

  void removeFlow({required String docId}) {
    _flowRef.doc(docId).delete();
    removeAllStepsFromParent(docId: docId);
  }

  void removeAllFlowsFromParent({required String docId}) async {
    Stream<List<UseCaseFlow>> stream = getAllFlowsFromParent(docId: docId);
    stream.forEach((flows) {
      for (UseCaseFlow flow in flows) {
        removeFlow(docId: flow.documentId!);
      }
    });
  }

  // Future<List<UseCaseFlow>> getAllFlowsFromParent({required String docId}) {
  //   return _flowRef
  //       .where(fsParentId, isEqualTo: docId)
  //       .withConverter(
  //           fromFirestore: (doc, _) => UseCaseFlow.fromFirestore(doc: doc),
  //           toFirestore: (step, _) => step.toMap())
  //       .get()
  //       .then((query) => query.docs.map((doc) => doc.data()).toList());
  // }

  Future<bool> _hasFlow({required String title}) {
    bool ret = false;
    Stream<List<UseCaseFlow>> stream =
        getAllFlowsFromParent(docId: _selectedUseCase.value!);
    return stream.forEach((flows) {
      for (UseCaseFlow f in flows) {
        if (f.title == title) {
          ret = true;
        }
      }
    }).then((value) => ret);
  }

  // Flow step methods
  void addFlowStep({required String step, required int index}) {
    _flowStepRef.add({
      fsFlowSteps_Index: index,
      fsFlowSteps_Step: step,
      fsParentId: _selectedFlow
    });
  }

  void updateFlowStep(
      {required String docId, required String contents, required int index}) {
    _flowStepRef.doc(docId).update({
      fsFlowSteps_Index: index,
      fsFlowSteps_Step: contents,
    });
  }

  void removeAllStepsFromParent({required String docId}) async {
    List<FlowStep> steps = await getAllStepsFromParent(docId: docId);
    for (FlowStep s in steps) {
      removeStep(docId: s.documentId!);
    }
  }

  void removeStep({required String docId}) {
    _flowStepRef.doc(docId).delete();
  }

  Future<List<FlowStep>> getAllStepsFromParent({required String docId}) {
    return _flowStepRef
        .where(fsParentId, isEqualTo: docId)
        .withConverter(
            fromFirestore: (doc, _) => FlowStep.fromFirestore(doc: doc),
            toFirestore: (step, _) => step.toMap())
        .get()
        .then((query) => query.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<UseCaseFlow>> getAllFlowsFromParent({required String docId}) {
    return _flowRef
        .where(fsParentId, isEqualTo: docId)
        .withConverter(
            fromFirestore: (doc, _) => UseCaseFlow.fromFirestore(doc: doc),
            toFirestore: (flow, _) => flow.toMap())
        .snapshots()
        .map((query) => query.docs.map((snap) => snap.data()).toList());
  }

  ValueNotifier<String?> get selectedUseCase => _selectedUseCase;
}
