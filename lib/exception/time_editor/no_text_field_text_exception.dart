class NoTextFieldTextException implements Exception{
  final String? _customMessage;
  final String _stndrMessage = "The Text Field requires a non-empty String to be submitted.";

  String get message => _customMessage ?? _stndrMessage;

  NoTextFieldTextException({String? customMessage}) : _customMessage = customMessage;
}