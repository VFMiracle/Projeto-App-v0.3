class TimeValueIsZeroException implements Exception{
  final String? _customMessage;
  final String _stndrMessage = "The time value of this editor cannot be 0.";

  String get message => _customMessage ?? _stndrMessage;

  TimeValueIsZeroException({String? customMessage}) : _customMessage = customMessage;
}