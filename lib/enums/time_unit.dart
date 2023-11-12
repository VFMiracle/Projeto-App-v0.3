enum TimeUnit{
  hour(valueToGrtrUnit: 24),
  minute(valueToGrtrUnit: 60),
  second(valueToGrtrUnit: 60);

  const TimeUnit({required this.valueToGrtrUnit});

  final int valueToGrtrUnit;
}