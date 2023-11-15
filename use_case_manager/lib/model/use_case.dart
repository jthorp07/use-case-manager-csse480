import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';
import 'package:use_case_manager/model/use_case_actor.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

class UseCase {
  final List<UseCaseFlow> _flows = List.empty(growable: true);
  final String projectTitle;
  final String ownerUid;
  String? documentId;
  int _currentFlow = 0;
  String _title;
  String _processName;
  final Set<Actor> _actors;

  UseCase(
      {
      this.documentId,
      required this.projectTitle,
      required this.ownerUid,
      required String title,
      required String processName,
      Set<Actor>? actors})
      : _title = title,
        _actors = actors ?? <Actor>{},
        _processName = processName {
    _flows.add(UseCaseFlow(title: "Basic", type: FlowType.basic));
  }

  UseCase.fromFirestore({required DocumentSnapshot doc}): this(projectTitle: FirestoreModelUtils.getStringField(doc, fsUseCase_ProjectTitle), ownerUid: FirestoreModelUtils.getStringField(doc, fsUseCase_OwnerUid), title: FirestoreModelUtils.getStringField(doc, ""), processName: FirestoreModelUtils.getStringField(doc, ""));

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
    _flows.add(UseCaseFlow(title: flowName, type: type));
    _sortFlows();
    return true;
  }

  void addActor(Actor a) {
    _actors.add(a);
  }

  void removeActor(Actor a) {
    _actors.remove(a);
  }

  void nextFlow() {
    if (_currentFlow == _flows.length) return;
    _currentFlow++;
  }

  void prevFlow() {
    if (_currentFlow == 0) return;
    _currentFlow--;
  }

  void nextStep() {
    _flows[_currentFlow].nextStep();
  }

  void prevStep() {
    _flows[_currentFlow].nextStep();
  }

  void setTitle(String newTitle) {
    _title = newTitle;
  }

  void setProcessName(String newName) {
    _processName = newName;
  }

  void addStep(String step) {
    _flows[_currentFlow].addStep(step);
  }

  void removeStep() {
    _flows[_currentFlow].removeStep();
  }

  bool changeFlowTitle(String newTitle) {
    if (_hasFlow(newTitle)) return false;
    _flows[_currentFlow].setTitle(newTitle);
    return true;
  }

  Map<String, Object> toMap() => {
    documentId!: documentId!,
    fsUseCase_OwnerUid: projectTitle,
    fsUseCase_Title: _title,
    fsUseCase_ProcessName: _processName,
    fsUseCase_ProjectTitle: projectTitle,
  };

  // ************************************
  //
  // Private Methods
  //
  // ************************************
  void _sortFlows() {
    _flows.sort((a, b) => a.compareTo(b));
  }

  bool _hasFlow(String flowTitle) {
    for (UseCaseFlow flow in _flows) {
      if (flow.title == flowTitle) return true;
    }
    return false;
  }
}
