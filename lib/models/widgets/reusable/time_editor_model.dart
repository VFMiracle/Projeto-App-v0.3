import 'package:flutter/material.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/enums/time_unit.dart';
import 'package:projeto_time_counter/exception/time_editor/no_text_field_text_exception.dart';
import 'package:projeto_time_counter/exception/time_editor/time_value_is_zero_exception.dart';
import 'package:projeto_time_counter/services/strategies/time_editor_configuration_strategy.dart';

class TimeEditorModel{
  String? textFieldText;
  final TimeEditorConfigurationStrategy _configStrtg;
  late final Map<TimeUnit, TimeEditorTimeUnitNotifier> _timeUnitNtfrs = <TimeUnit, TimeEditorTimeUnitNotifier>{};

  TimeEditorModel({required TimeEditorConfigurationStrategy configStrtg, Map<TimeUnit, int>? initialTimeUnitValues, this.textFieldText}) : _configStrtg = configStrtg{
    _timeUnitNtfrs.addAll({
      TimeUnit.hour: TimeEditorTimeUnitNotifier(this),
      TimeUnit.minute: TimeEditorTimeUnitNotifier(this),
      TimeUnit.second: TimeEditorTimeUnitNotifier(this),
    });
    if(initialTimeUnitValues != null){
      _timeUnitNtfrs[TimeUnit.hour]!._value = initialTimeUnitValues[TimeUnit.hour] ?? 0;
      _timeUnitNtfrs[TimeUnit.minute]!._value = initialTimeUnitValues[TimeUnit.minute] ?? 0;
      _timeUnitNtfrs[TimeUnit.second]!._value = initialTimeUnitValues[TimeUnit.second] ?? 0;
    }
  }

  TimeEditorDTO getTimeEditorDTO(){
    return TimeEditorDTO(
      hours: _timeUnitNtfrs[TimeUnit.hour]!.value,
      minutes: _timeUnitNtfrs[TimeUnit.minute]!.value,
      seconds: _timeUnitNtfrs[TimeUnit.second]!.value,
      textFieldText: textFieldText,
    );
  }

  TimeEditorTimeUnitNotifier getTimeUnitNotifier(TimeUnit timeUnit){
    return _timeUnitNtfrs[timeUnit]!;
  }

  void validateExitProcess(){
    if(_configStrtg.verifyTextFieldValid(textFieldText) == false){
      throw NoTextFieldTextException(customMessage: "Please provide a non-empty Task Name.");
    }
    if(_configStrtg.verifyTimeValid(getTimeUnitNotifier(TimeUnit.hour)._value, getTimeUnitNotifier(TimeUnit.minute)._value,
        getTimeUnitNotifier(TimeUnit.second)._value) == false){
      throw TimeValueIsZeroException();
    }
  }
}

class TimeEditorTimeUnitNotifier extends ChangeNotifier{
  int _value = 0;
  // ignore: unused_field
  final TimeEditorModel _parentModel;

  TimeEditorTimeUnitNotifier(this._parentModel);

  int get value => _value;
  set value(int newValue){
    _value = newValue;
    notifyListeners();
  }
}