enum TimeUnit{
  hour(valueToGreaterUnit: 24),
  minute(valueToGreaterUnit: 60),
  second(valueToGreaterUnit: 60);

  const TimeUnit({required this.valueToGreaterUnit});

  final int valueToGreaterUnit;
}