import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerInitializationService{
  static final CronometerInitializationService _instance = CronometerInitializationService._internal();

  CronometerInitializationService._internal();

  factory CronometerInitializationService() => _instance;

  void initialize(List<CronometerModel> cronometers){
    CommandHistoryDAO().readDbLastCronoIntrctEntry(cronometers[0]);
  }
}