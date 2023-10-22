enum FlowType { basic, alternate, exception }

class UseCaseFlow implements Comparable<UseCaseFlow> {
  final String title;
  final List<String> steps = List.empty(growable: true);
  int currentStep = 0;
  final FlowType type;

  UseCaseFlow({required this.title, required this.type});

  void addStep(String step) {
    steps.add(step);
    if (currentStep != steps.length) {}
  }

  void prevStep() {
    if (currentStep == 0) return;
    currentStep--;
  }

  void nextStep() {
    if (currentStep == steps.length) return;
    currentStep++;
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
