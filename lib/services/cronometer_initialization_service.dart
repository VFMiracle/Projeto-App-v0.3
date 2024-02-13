import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerInitializationService{
  static final CronometerInitializationService _instance = CronometerInitializationService._internal();

  CronometerInitializationService._internal();

  factory CronometerInitializationService() => _instance;

  void initialize(List<CronometerModel> cronometers) async {
    for(CronometerModel cronometer in cronometers){
      CommandHistoryDTO? lastCronoIntrct = await CommandHistoryDAO().readDbLastCronoIntrctEntry(cronometer.nameNotifier.name);
      if(lastCronoIntrct != null && (lastCronoIntrct.commandId == 4 || lastCronoIntrct.commandId == 5)){
        
      }
    }
  }
}