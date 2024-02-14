class TimeValueIsZeroException implements Exception{
  final String? _customMessage;
  final String _standardMessage = "The time value of this editor cannot be 0.";

  String get message => _customMessage ?? _standardMessage;

  TimeValueIsZeroException({String? customMessage}) : _customMessage = customMessage;
}