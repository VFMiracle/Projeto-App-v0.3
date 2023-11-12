import 'package:projeto_time_counter/background/notification_manager.dart';
import 'package:projeto_time_counter/models/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

//DESC: Describes the logic for the Bakcground Cronometer Notification.
class BackgroundCronometer{
  final CronometerModel _crnmtrModel;

  BackgroundCronometer(CronometerModel crnmtrModel) : _crnmtrModel = crnmtrModel;

  void start(){
    if(_crnmtrModel.isRunningNtfr.isRunning){
      _crnmtrModel.valueNtfr.addListener(_displayRunning);
    }else if(_crnmtrModel.valueNtfr.currentValue > 0){
      _displayPaused();
    }
  }

  void cancel(){
    if(_crnmtrModel.isRunningNtfr.isRunning){
      _crnmtrModel.valueNtfr.removeListener(_displayRunning);
    }
    NotificationManager().cancelCronometer();
  }

  void _displayPaused(){
    String crnmtrStatus = "${TimeConversionService().fromIntToString(_crnmtrModel.valueNtfr.currentValue)} - Paused";
    NotificationManager().displayCronometer(_crnmtrModel.nameNtfr.name, crnmtrStatus);
  }

  void _displayRunning(){
    NotificationManager().displayCronometer(_crnmtrModel.nameNtfr.name, TimeConversionService().fromIntToString(_crnmtrModel.valueNtfr.currentValue));
  }
}