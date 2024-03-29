import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/facade/time_record_facade.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

class TimeRecordModel{
  final int _id;
  final TimeRecordFacade _facade = TimeRecordFacade();
  late final TimeRecordCountedTimeNotifier _countedTimeNotifier;
  late final TimeRecordTaskNameNotifier _taskNameNotifier;

  int get id => _id;
  TimeRecordCountedTimeNotifier get countedTimeNotifier => _countedTimeNotifier;
  TimeRecordTaskNameNotifier get taskNameNotifier => _taskNameNotifier;

  TimeRecordModel(this._id, String taskName, int countedTime){
    _countedTimeNotifier = TimeRecordCountedTimeNotifier(this, countedTime);
    _taskNameNotifier = TimeRecordTaskNameNotifier(this, taskName);
  }

  void delete(){
    TimeRecordPanelModel().timeRecordsNotifier.deleteTimeRecord(this);
  }

  void update(TimeEditorDTO timeEditorDto){
    bool wasChanged = false;
    int dtoCountedTime = TimeConversionService().fromTimeUnitValuesToInt(hours: timeEditorDto.hours, minutes: timeEditorDto.minutes, seconds: timeEditorDto.seconds);
    if(_taskNameNotifier.taskName != timeEditorDto.textFieldText){
      String oldName = _taskNameNotifier.taskName;
      _taskNameNotifier.taskName = timeEditorDto.textFieldText!;
      wasChanged = true;
      _facade.recordNameChange(this, oldName);
    }
    if(_countedTimeNotifier.countedTime != dtoCountedTime){
      int oldValue = _countedTimeNotifier.countedTime;
      _countedTimeNotifier.countedTime = dtoCountedTime;
      wasChanged = true;
      _facade.recordValueChange(this, oldValue);
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