class TimeEditorConfigurationStrategy{
  final bool? _allowEmptyTextField;
  final bool _allowTimeZero;

  TimeEditorConfigurationStrategy({required bool allowTimeZero, bool? allowEmptyTextField}) : _allowTimeZero = allowTimeZero, _allowEmptyTextField = allowEmptyTextField;

  bool verifyTextFieldValid(String? textFieldText){
    return _allowEmptyTextField! || (textFieldText != null && textFieldText.isNotEmpty);
  }

  bool verifyTimeValid(int hours, int minutes, int seconds){
    return _allowTimeZero || hours > 0 || minutes > 0 || seconds > 0;
  }
}