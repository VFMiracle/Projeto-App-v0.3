import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerInitializationService{
  static CronometerInitializationService _instance = CronometerInitializationService._internal();

  CronometerInitializationService._internal();

  factory CronometerInitializationService() => _instance;

  void initialize(List<CronometerModel> cronometers){
    
  }
}