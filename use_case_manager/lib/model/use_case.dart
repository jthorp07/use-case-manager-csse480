import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';
import 'package:use_case_manager/model/use_case_actor.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

class UseCase {
  List<UseCaseFlow> _flows = List.empty(growable: true);
  String parentId;
  String? documentId;
  int _currentFlow = 0;
  String _title;
  String _processName;
  final Set<Actor> _actors;

  UseCase(
      {this.documentId,
      required this.parentId,
      required String title,
      required String processName,
      Set<Actor>? actors})
      : _title = title,
        _actors = actors ?? <Actor>{},
        _processName = processName {
    if (documentId != null) {
      UseCaseDocumentMngr.instance
          .getAllActorsFromParent(docId: documentId!)
          .then((actors) {
        _actors.addAll(actors);
      });
      UseCaseDocumentMngr.instance
          .getAllFlowsFromParent(docId: documentId!)
          .then((flows) {
        _flows.addAll(flows);
        sortFlows();
        if (_flows.isEmpty) {
          _flows.add(UseCaseFlow(
              title: "Basic Flow",
              type: FlowType.basic,
              parentId: documentId!));
        }
      });
    }
  }

  UseCase.fromFirestore({required DocumentSnapshot doc})
      : this(
          documentId: doc.id,
          title: FirestoreModelUtils.getStringField(doc, fsUseCase_Title),
          processName:
              FirestoreModelUtils.getStringField(doc, fsUseCase_ProcessName),
          parentId: FirestoreModelUtils.getStringField(doc, fsParentId),
        );

  // ************************************
  //
  // Getters
  //
  // ************************************

  String get title => _title;
  String get processName => _processName;
  List<Actor> get actors => List.from(_actors);
  UseCaseFlow get currentFlow => _flows[_currentFlow];
  List<String> get currentFlowSteps => currentFlow.steps;

  // ************************************
  //
  // Public Methods
  //
  // ************************************

  bool addFlow({required String flowName, required FlowType type}) {
    if (_hasFlow(flowName)) return false;
    UseCaseDocumentMngr.instance.addFlow(type: type, name: flowName);
    _flows.add(UseCaseFlow(title: title, type: type, parentId: documentId!));
    sortFlows();
    return true;
  }

  void addActor(Actor a) {
    _actors.add(a);
  }

  void removeActor(Actor a) {
    _actors.remove(a);
  }

  void nextFlow() {
    if (_currentFlow == _flows.length) {
      UseCaseDocumentMngr.instance.selectFlow(_flows[_currentFlow].documentId!);
      return;
    }
    _currentFlow++;
    UseCaseDocumentMngr.instance.selectFlow(_flows[_currentFlow].documentId!);
  }

  void prevFlow() {
    if (_currentFlow == 0) {
      UseCaseDocumentMngr.instance.selectFlow(_flows[_currentFlow].documentId!);
      return;
    }
    _currentFlow--;
    UseCaseDocumentMngr.instance.selectFlow(_flows[_currentFlow].documentId!);
  }

  void nextStep() {
    _flows[_currentFlow].nextStep();
  }

  void prevStep() {
    _flows[_currentFlow].nextStep();
  }

  void setTitle(String newTitle) async {
    UseCaseDocumentMngr.instance
        .updateUseCase(
            docId: documentId!, title: newTitle, processName: _processName)
        .then((success) {
      if (success) _title = newTitle;
    });
  }

  Future<void> setProcessName(String newName) async {
    await UseCaseDocumentMngr.instance
        .updateUseCase(docId: documentId!, title: _title, processName: newName)
        .then((success) {
      if (success) _processName = newName;
    });
  }

  void addStep(String step) {
    _flows[_currentFlow].addStep(step);
  }

  void removeStep() {
    _flows[_currentFlow].removeStep();
  }

  void changeFlowTitle(String newTitle) {
    _flows[_currentFlow].setTitle(newTitle);
  }

  Map<String, Object> toMap() => {
        documentId!: documentId!,
        fsParentId: parentId,
        fsUseCase_Title: _title,
        fsUseCase_ProcessName: _processName,
      };

  // ************************************
  //
  // Private Methods
  //
  // ************************************
  void sortFlows() {
    _flows.sort((a, b) => a.compareTo(b));
  }

  bool _hasFlow(String flowTitle) {
    for (UseCaseFlow flow in _flows) {
      if (flow.title == flowTitle) return true;
    }
    return false;
  }

  set setFlow(List<UseCaseFlow> newFLows) {
    _flows.clear();
    _flows.addAll(newFLows);
  }
}
