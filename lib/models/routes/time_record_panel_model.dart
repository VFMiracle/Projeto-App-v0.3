import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/exception/time_record_panel/task_already_recorded_exception.dart';
import 'package:projeto_time_counter/facade/time_record_panel_facade.dart';
import 'package:projeto_time_counter/models/widgets/time_record_model.dart';

class TimeRecordPanelModel{
  //INFO: While the Time Record Panel Model is a singleton, it is only needed on certain moments of the App. As such, in order to prevent it from consuming unnecessary
  //  memory, the instance will be disposed whenever it's no longer needed.
  static TimeRecordPanelModel? _timeRecordPanelModel;

  final TimeRecordPanelFacade _facade = TimeRecordPanelFacade();
  late final TimeRecordPanelRecordsNotifier _timeRecordsNotifier;
  late final TimeRecordPanelSelDateNotifier _selDateNotifier;

  static bool get isIntialized => _timeRecordPanelModel != null;

  TimeRecordPanelRecordsNotifier get timeRecordsNotifier => _timeRecordsNotifier;
  TimeRecordPanelSelDateNotifier get selDateNotifier => _selDateNotifier;

  TimeRecordPanelModel._internal(){
    _selDateNotifier = TimeRecordPanelSelDateNotifier(this);
    _timeRecordsNotifier = TimeRecordPanelRecordsNotifier(this);
    _selDateNotifier.addListener(_loadTimeRecordsOfSelectedDate);
    _loadTimeRecordsOfSelectedDate();
  }

  factory TimeRecordPanelModel(){
    _timeRecordPanelModel ??= TimeRecordPanelModel._internal();
    return _timeRecordPanelModel!;
  }

  static void disposeInstance(){
    _timeRecordPanelModel = null;
  }

  void _loadTimeRecordsOfSelectedDate(){
    _facade.readDbEntriesByDay(_selDateNotifier.selDate).then((List<TimeRecordModel> timeRecords){
      _timeRecordsNotifier._setTimeRecords(timeRecords);
    });
  }
}

class TimeRecordPanelRecordsNotifier extends ChangeNotifier{
  List<TimeRecordModel> _timeRecords = [];
  final TimeRecordPanelModel _parentModel;

  int get qtdTimeRecords => _timeRecords.length;

  TimeRecordPanelRecordsNotifier(TimeRecordPanelModel parentModel) : _parentModel = parentModel;

  void addTimeRecord(TimeEditorDTO timeEditorDto){
    _validateTimeEditorDto(timeEditorDto);
    _addTimeRecord(timeEditorDto);
  }

  void deleteTimeRecord(TimeRecordModel timeRecord){
    _timeRecords.remove(timeRecord);
    _parentModel._facade.deleteDbEntry(timeRecord.id);
    notifyListeners();
  }

  TimeRecordModel getRecordByIndex(int index){
    return _timeRecords[index];
  }

  void _addTimeRecord(TimeEditorDTO timeEditorDto) async {
    _timeRecords.add(await _parentModel._facade.insertDbEntry(timeEditorDto, _parentModel._selDateNotifier.selDate));
    notifyListeners();
  }

  void _setTimeRecords(List<TimeRecordModel> timeRecords){
    _timeRecords = timeRecords;
    notifyListeners();
  }

  void _validateTimeEditorDto(TimeEditorDTO timeEditorDto){
    for(TimeRecordModel timeRecord in _timeRecords){
      if(timeRecord.taskNameNtfr.taskName.compareTo(timeEditorDto.textFieldText!) == 0){
        throw TaskAlreadyRecordedException();
      }
    }
  }
}

class TimeRecordPanelSelDateNotifier extends ChangeNotifier{
  DateTime _selDate;
  // ignore: unused_field
  final TimeRecordPanelModel _parentModel;

  DateTime get selDate => _selDate;
  set selDate(DateTime newDate){
    _selDate = newDate;
    notifyListeners();
  }

  TimeRecordPanelSelDateNotifier(TimeRecordPanelModel parentModel) : _parentModel = parentModel, _selDate = DateTime.now();
}