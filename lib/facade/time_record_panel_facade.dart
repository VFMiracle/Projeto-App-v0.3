import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/routes/time_record_panel_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

class TimeRecordPanelFacade{
  
  void deleteDbEntry(TimeRecordModel timeRecord){
    TimeRecordDAO().deleteDbEntry(timeRecord.id);
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO.trEditingRecordingDto(
        command: TimeRecordEditingCommand.delete,
        targetName: timeRecord.taskNameNotifier.taskName,
        updateInfo: <String, dynamic>{"recordDate": TimeRecordPanelModel().selDateNotifier.selDate, "deleteValue": timeRecord.countedTimeNotifier.countedTime
      })
    );
  }

  Future<TimeRecordModel> insertDbEntry(TimeEditorDTO timeEditorDto, DateTime creationDate) async {
    TimeRecordDTO recordDTO = _mapEditorDtoToRecordDto(timeEditorDto, creationDate);
    CommandHistoryDAO().insertDbEntry(CommandHistoryDTO.trEditingRecordingDto(
      command: TimeRecordEditingCommand.create, targetName: recordDTO.taskName,
        updateInfo: <String, dynamic>{"recordDate": creationDate, "initialValue": recordDTO.countedTime}
    ));
    TimeRecordModel recordModel = TimeRecordModel(await TimeRecordDAO().insertDbEntry(recordDTO), recordDTO.taskName, recordDTO.countedTime);
    return recordModel;
  }

  Future<List<TimeRecordModel>> readDbEntriesByDay(DateTime crtnDate) async {
    List<TimeRecordDTO> dtos = await TimeRecordDAO().readDbEntriesByDay(crtnDate);
    return _getModelListFromDtoList(dtos);
  }

  TimeRecordDTO _mapEditorDtoToRecordDto(TimeEditorDTO editorDto, DateTime creationDate){
    return TimeRecordDTO(taskName: editorDto.textFieldText!, countedTime: TimeConversionService().fromTimeUnitValuesToInt(hours: editorDto.hours,
        minutes: editorDto.minutes, seconds: editorDto.seconds), creationDate: creationDate);
  }

  TimeRecordModel _mapRecordDtoToRecordModel(TimeRecordDTO dto){
    return TimeRecordModel(dto.id!, dto.taskName, dto.countedTime);
  }

  List<TimeRecordModel> _getModelListFromDtoList(List<TimeRecordDTO> dtos){
    List<TimeRecordModel> models = [];
    for(TimeRecordDTO dto in dtos){
      models.add(_mapRecordDtoToRecordModel(dto));
    }
    return models;
  }
}