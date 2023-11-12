class TimeEditorDTO{
  final int _hours;
  final int _minutes;
  final int _seconds;
  final String? _textFieldText;

  int get hours => _hours;

  int get minutes => _minutes;

  int get seconds => _seconds;

  String? get textFieldText => _textFieldText;

  TimeEditorDTO({required int hours, required int minutes, required int seconds, String? textFieldText}) : _hours = hours, _minutes = minutes, _seconds = seconds,
      _textFieldText = textFieldText;
}