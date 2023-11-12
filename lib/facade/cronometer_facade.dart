import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/models/cronometer_model.dart';

class CronometerFacade{

  void addTimeToRecords(String taskName, int time) async {
    TimeRecordDTO? timeRecordDTO = await TimeRecordDAO().readDbEntry(taskName, DateTime.now());
    if(timeRecordDTO != null){
      int newTime = timeRecordDTO.countedTime! + time;
      TimeRecordDTO updateDTO = TimeRecordDTO(id: timeRecordDTO.id, taskName: taskName, countedTime: newTime);
      TimeRecordDAO().updateDbEntry(updateDTO);
    }else{
      TimeRecordDTO newDTO = TimeRecordDTO(taskName: taskName, countedTime: time);
      TimeRecordDAO().insertDbEntry(newDTO);
    }
  }

  void updateDbEntry(CronometerModel cronometer){
    CronometerDAO().updateDbEntry(_getDtoFromModel(cronometer));
  }

  CronometerDTO _getDtoFromModel(CronometerModel model){
    return CronometerDTO(model.id, model.nameNtfr.name);
  }
}