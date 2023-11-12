import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/time_editor_dto.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/models/time_record_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

class TimeRecordPanelFacade{
  
  void deleteDbEntry(int timeRecordId){
    TimeRecordDAO().deleteDbEntry(timeRecordId);
  }

  Future<TimeRecordModel> insertDbEntry(TimeEditorDTO timeEditorDto) async {
    TimeRecordDTO recordDTO = _mapEditorDtoToRecordDto(timeEditorDto);
    TimeRecordModel recordModel = TimeRecordModel(await TimeRecordDAO().insertDbEntry(recordDTO), recordDTO.taskName!, recordDTO.countedTime!);
    return recordModel;
  }

  Future<List<TimeRecordModel>> readDbEntriesByDay(DateTime crtnDate) async {
    List<TimeRecordDTO> dtos = await TimeRecordDAO().readDbEntriesByDay(crtnDate);
    return _getModelListFromDtoList(dtos);
  }

  TimeRecordDTO _mapEditorDtoToRecordDto(TimeEditorDTO editorDto){
    return TimeRecordDTO(taskName: editorDto.textFieldText, countedTime: TimeConversionService().fromTimeUnitValuesToInt(hours: editorDto.hours,
        minutes: editorDto.minutes, seconds: editorDto.seconds));
  }

  TimeRecordModel _mapRecordDtoToRecordModel(TimeRecordDTO dto){
    return TimeRecordModel(dto.id!, dto.taskName!, dto.countedTime!);
  }

  List<TimeRecordModel> _getModelListFromDtoList(List<TimeRecordDTO> dtos){
    List<TimeRecordModel> models = [];
    for(TimeRecordDTO dto in dtos){
      models.add(_mapRecordDtoToRecordModel(dto));
    }
    return models;
  }
}