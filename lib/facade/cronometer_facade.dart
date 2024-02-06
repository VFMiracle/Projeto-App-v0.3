import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerFacade{
  //INFO: This Facade is a singleton because having a single instance of it that any Cronometer Model calls is more efficient than each of them creating an instance of their
  //  own.
  static final CronometerFacade _instance = CronometerFacade._internal();

  CronometerFacade._internal();

  factory CronometerFacade(){
    return _instance;
  }

  void addTimeToRecords(String taskName, int time) async {
    TimeRecordDTO? timeRecordDTO = await TimeRecordDAO().readDbEntry(taskName, DateTime.now());
    if(timeRecordDTO != null){
      int newTime = timeRecordDTO.countedTime! + time;
      TimeRecordDTO updateDTO = TimeRecordDTO(id: timeRecordDTO.id, taskName: taskName, countedTime: newTime, creationDate: timeRecordDTO.creationDate);
      TimeRecordDAO().updateDbEntry(updateDTO);
    }else{
      TimeRecordDTO newDTO = TimeRecordDTO(taskName: taskName, countedTime: time);
      TimeRecordDAO().insertDbEntry(newDTO);
    }
  }

  void recordIsRunningToggle(CronometerModel cronometer){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO(
        commandId: cronometer.isRunningNotifier.isRunning ? CronometerInteractionCommand.start.commandId : CronometerInteractionCommand.pause.commandId,
        type: CommandHistoryType.cronometerInteraction,
        targetName: cronometer.nameNotifier.name,
        updateInfo: cronometer.valueNotifier.currentValue.toString(),
      ),
    );
  }

  void recordTimeReset(CronometerModel cronometer, bool shouldRecordTime){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO(
        commandId: shouldRecordTime ? CronometerInteractionCommand.resetAndSaveTime.commandId : CronometerInteractionCommand.resetAndDeleteTime.commandId,
        type: CommandHistoryType.cronometerInteraction,
        targetName: cronometer.nameNotifier.name,
        updateInfo: cronometer.valueNotifier.currentValue.toString(),
      )
    );
  }

  void updateDbEntry(CronometerModel cronometer, String oldName){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO(commandId: CronometerEditingCommand.updateName.commandId, type: CommandHistoryType.cronometerEditing, targetName: oldName,
        updateInfo: cronometer.nameNotifier.name)
    );
    CronometerDAO().updateDbEntry(_getDtoFromModel(cronometer));
  }

  CronometerDTO _getDtoFromModel(CronometerModel model){
    return CronometerDTO(model.id, model.nameNotifier.name);
  }
}