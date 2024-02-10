import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_model.dart';

class TimeRecordFacade{
  
  void recordNameChange(TimeRecordModel timeRecord, String oldName){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO.trEditingRecordingDto(command: TimeRecordEditingCommand.updateName, targetName: oldName,
        updateInfo: <String, dynamic>{"recordDate": TimeRecordPanelModel().selDateNotifier.selDate, "newName": timeRecord.taskNameNotifier.taskName})
    );
  }

  void recordValueChange(TimeRecordModel timeRecord, int oldValue){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO.trEditingRecordingDto(
        command: TimeRecordEditingCommand.updateValue,
        targetName: timeRecord.taskNameNotifier.taskName,
        updateInfo:
          <String, dynamic>{"recordDate": TimeRecordPanelModel().selDateNotifier.selDate, "oldValue": oldValue, "newValue": timeRecord.countedTimeNotifier.countedTime}
      )
    );
  }

  void updateDbEntry(TimeRecordModel timeRecord){
    TimeRecordDAO().updateDbEntry(_mapRecordModelToRecordDto(timeRecord));
  }

  TimeRecordDTO _mapRecordModelToRecordDto(TimeRecordModel model){
    return TimeRecordDTO(id: model.id, taskName: model.taskNameNotifier.taskName, countedTime: model.countedTimeNotifier.countedTime, creationDate: null);
  }
}