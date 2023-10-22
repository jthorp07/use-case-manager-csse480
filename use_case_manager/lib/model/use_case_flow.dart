enum FlowType { basic, alternate, exception }

class UseCaseFlow implements Comparable<UseCaseFlow> {
  String _title;
  final List<String> _steps = List.empty(growable: true);
  int _currentStep = 0;
  final FlowType type;

  UseCaseFlow({required String title, required this.type}) : _title = title;

  String get title => _title;

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
}
