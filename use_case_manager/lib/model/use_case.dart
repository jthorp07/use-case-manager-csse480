import 'package:use_case_manager/model/use_case_actor.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

class UseCase {
  final List<UseCaseFlow> _flows = List.empty(growable: true);
  int _currentFlow = 0;
  String title;
  List<Actor> actors;

  UseCase({required this.title, required this.actors}) {
    _flows.add(UseCaseFlow(title: "Basic", type: FlowType.basic));
  }

  // ************************************
  //
  // Public Methods
  //
  // ************************************

  void addFlow({required String flowName, required FlowType type}) {

    _flows.add(UseCaseFlow(title: flowName, type: type));
    _sortFlows();
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

  // ************************************
  //
  // Private Methods
  //
  // ************************************
  void _sortFlows() {
    _flows.sort((a, b) => a.compareTo(b));
  }
}
