class CounterLoaderEntity {
  double percent;
  int currentStep;
  int totalSteps;
  String description;

  CounterLoaderEntity(
      {required this.percent,
      required this.currentStep,
      required this.totalSteps,
      required this.description});

  changeStep(int step) {
    currentStep = step;
    percent = (currentStep / totalSteps);
  }

  nextStep() {
    changeStep(currentStep + 1);
  }
}
