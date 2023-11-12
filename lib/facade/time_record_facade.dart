import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/models/time_record_model.dart';

class TimeRecordFacade{
  
  void updateDbEntry(TimeRecordModel timeRecord){
    TimeRecordDAO().updateDbEntry(_mapRecordModelToRecordDto(timeRecord));
  }

  TimeRecordDTO _mapRecordModelToRecordDto(TimeRecordModel model){
    return TimeRecordDTO(id: model.id, taskName: model.taskNameNtfr.taskName, countedTime: model.countedTimeNtfr.countedTime, crtnDate: null);
  }
}