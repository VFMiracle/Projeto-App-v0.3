import 'package:projeto_time_counter/background/notification_manager.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

//DESC: Describes the logic for the Bakcground Cronometer Notification.
class BackgroundCronometer{
  final CronometerModel _crnmtrModel;

  BackgroundCronometer(CronometerModel crnmtrModel) : _crnmtrModel = crnmtrModel;

  void start(){
    if(_crnmtrModel.isRunningNotifier.isRunning){
      _crnmtrModel.valueNotifier.addListener(_displayRunning);
    }else if(_crnmtrModel.valueNotifier.currentValue > 0){
      _displayPaused();
    }
  }

  void cancel(){
    if(_crnmtrModel.isRunningNotifier.isRunning){
      _crnmtrModel.valueNotifier.removeListener(_displayRunning);
    }
    NotificationManager().cancelCronometer();
  }

  void _displayPaused(){
    String crnmtrStatus = "${TimeConversionService().fromIntToString(_crnmtrModel.valueNotifier.currentValue)} - Paused";
    NotificationManager().displayCronometer(_crnmtrModel.nameNotifier.name, crnmtrStatus);
  }

  void _displayRunning(){
    NotificationManager().displayCronometer(_crnmtrModel.nameNotifier.name, TimeConversionService().fromIntToString(_crnmtrModel.valueNotifier.currentValue));
  }
}