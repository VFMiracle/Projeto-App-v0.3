class NoTextFieldTextException implements Exception{
  final String? _customMessage;
  final String _standardMessage = "The Text Field requires a non-empty String to be submitted.";

  String get message => _customMessage ?? _standardMessage;

  NoTextFieldTextException({String? customMessage}) : _customMessage = customMessage;
}