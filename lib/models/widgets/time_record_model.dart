import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/facade/time_record_facade.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

class TimeRecordModel{
  final int _id;
  final TimeRecordFacade _facade = TimeRecordFacade();
  late final TimeRecordCountedTimeNotifier _countedTimeNtfr;
  late final TimeRecordTaskNameNotifier _taskNameNtfr;

  int get id => _id;
  TimeRecordCountedTimeNotifier get countedTimeNtfr => _countedTimeNtfr;
  TimeRecordTaskNameNotifier get taskNameNtfr => _taskNameNtfr;

  TimeRecordModel(this._id, String taskName, int countedTime){
    _countedTimeNtfr = TimeRecordCountedTimeNotifier(this, countedTime);
    _taskNameNtfr = TimeRecordTaskNameNotifier(this, taskName);
  }

  void delete(){
    TimeRecordPanelModel().timeRecordsNotifier.deleteTimeRecord(this);
  }

  void update(TimeEditorDTO timeEditorDto){
    bool wasChanged = false;
    int dtoCountedTime = TimeConversionService().fromTimeUnitValuesToInt(hours: timeEditorDto.hours, minutes: timeEditorDto.minutes, seconds: timeEditorDto.seconds);
    if(_taskNameNtfr.taskName != timeEditorDto.textFieldText){
      _taskNameNtfr.taskName = timeEditorDto.textFieldText!;
      wasChanged = true;
    }
    if(_countedTimeNtfr.countedTime != dtoCountedTime){
      _countedTimeNtfr.countedTime = dtoCountedTime;
      wasChanged = true;
    }
    if(wasChanged){
      _facade.updateDbEntry(this);
    }
  }
}

class TimeRecordCountedTimeNotifier extends ChangeNotifier{
  int _countedTime;
  //ignore: unused_field
  final TimeRecordModel _parentModel;

  int get countedTime => _countedTime;
  set countedTime(int newTime){
    _countedTime = newTime;
    notifyListeners();
  }

  TimeRecordCountedTimeNotifier(this._parentModel, this._countedTime);
}

class TimeRecordTaskNameNotifier extends ChangeNotifier{
  String _taskName;
  //ignore: unused_field
  final TimeRecordModel _parentModel;

  String get taskName => _taskName;
  set taskName(String newName){
    _taskName = newName;
    notifyListeners();
  }

  TimeRecordTaskNameNotifier(this._parentModel, this._taskName);
}