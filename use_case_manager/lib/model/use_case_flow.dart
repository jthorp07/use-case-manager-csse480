enum FlowType { basic, alternate, exception }

class UseCaseFlow {
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
}
