import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';
import 'package:use_case_manager/model/flow_step.dart';

enum FlowType { basic, alternate, exception }

class UseCaseFlow implements Comparable<UseCaseFlow> {

  String? documentId;
  String _title;
  final List<FlowStep> _steps = List.empty(growable: true);
  int _currentStep = 0;
  final FlowType type;
  String parentId;

  UseCaseFlow({required String title, required this.type, required this.parentId, this.documentId}) : _title = title {
    if (documentId != null) {
      UseCaseDocumentMngr.instance.getAllStepsFromParent(docId: documentId!).then((steps) {
        if (steps.isEmpty) return;
        steps.sort((a, b) => a.compareTo(b));
      });
    }
  }
  UseCaseFlow.fromFirestore({required DocumentSnapshot doc}):
    this(
      documentId: doc.id,
      title: FirestoreModelUtils.getStringField(doc, fsFlows_FlowName),
      type: stringToType(FirestoreModelUtils.getStringField(doc, fsFlows_FlowType)),
      parentId: FirestoreModelUtils.getStringField(doc, fsParentId)
    );

  Map<String, Object> toMap() => {
    documentId!: documentId!,
    fsFlows_FlowName: _title,
    fsFlows_FlowType: typeToString(type),
  };

  String get title => _title;
  List<String> get steps => List.from(_steps);

  void addStep(String step) {
    UseCaseDocumentMngr.instance.addFlowStep(step: step, index: _currentStep);
    _steps.insert(_currentStep, FlowStep(contents: step, parentId: documentId!, index: _currentStep));
    _currentStep++;
    shiftStepsFrom(_currentStep);
    selectStep(_steps[_currentStep].documentId ?? "");
  }

  void shiftStepsFrom(int index) {
    for (int i = index; i < _steps.length; i++) {
      _steps[i].setIndex(i);
    }
  }

  // TODO: Might introduce a race condition (line 53/55)
  void removeStep() {
    FlowStep step = _steps.removeAt(_currentStep);
    shiftStepsFrom(_currentStep + 1);
    UseCaseDocumentMngr.instance.removeStep(docId: step.documentId!);
    prevStep();
  }

  void prevStep() {
    if (_currentStep == 0) {
      selectStep(_steps[_currentStep].documentId ?? "");
      return;
    } 
    _currentStep--;
    selectStep(_steps[_currentStep].documentId ?? "");
  }

  void nextStep() {
    if (_currentStep == _steps.length) {
      selectStep(_steps[_currentStep].documentId ?? "");
    } 
    _currentStep++;
    selectStep(_steps[_currentStep].documentId ?? "");
  }

  void setTitle(String newTitle) {
    UseCaseDocumentMngr.instance.updateFlow(docId: documentId!, type: type, title: newTitle).then((success) {
      if (success) _title = newTitle;
    });
  }

  void selectStep(String docId) {
    UseCaseDocumentMngr.instance.selectFlowStep(docId);
  }

  @override
  int compareTo(UseCaseFlow other) {
    switch (type) {
      case FlowType.basic:
        return other.type == FlowType.basic ? 0 : -1;
      case FlowType.alternate:
        return other.type == FlowType.basic
            ? 1
            : other.type == FlowType.alternate
                ? 0
                : -1;
      case FlowType.exception:
        return other.type == FlowType.exception ? 0 : 1;
    }
  }

  static String typeToString(FlowType type) {
    switch (type) {
      case FlowType.alternate:
        return 'alternate';
      case FlowType.basic:
        return 'basic';
      case FlowType.exception:
        return 'exception';
    }
  }

  static FlowType stringToType(String datum) {
    switch (datum) {
      case 'alternate':
        return FlowType.alternate;
      case 'basic':
        return FlowType.basic;
      case 'exception':
        return FlowType.exception;
      default:
        return FlowType.basic;  
    }
  }
}
