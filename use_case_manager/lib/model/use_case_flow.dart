import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';

enum FlowType { basic, alternate, exception }

class UseCaseFlow implements Comparable<UseCaseFlow> {

  String? documentId;
  String _title;
  final List<String> _steps = List.empty(growable: true);
  int _currentStep = 0;
  final FlowType type;
  String parentId;

  UseCaseFlow({required String title, required this.type, required this.parentId, this.documentId}) : _title = title;
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
    _steps.insert(_currentStep, step);
    _currentStep++;
  }

  void removeStep() {
    _steps.removeAt(_currentStep);
    prevStep();
  }

  void prevStep() {
    if (_currentStep == 0) return;
    _currentStep--;
  }

  void nextStep() {
    if (_currentStep == _steps.length) return;
    _currentStep++;
  }

  void setTitle(String newTitle) {
    _title = newTitle;
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
