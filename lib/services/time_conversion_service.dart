import 'package:projeto_time_counter/enums/time_unit.dart';

class TimeConversionService{
  static final TimeConversionService _instance = TimeConversionService._internal();

  TimeConversionService._internal();

  factory TimeConversionService() => _instance;

  String fromIntToString(int timeInSeconds, {bool shouldDisplaySeconds = true}){
    int timeInHours = timeInSeconds ~/ Duration.secondsPerHour;
    timeInSeconds -= timeInHours * Duration.secondsPerHour;
    int timeInMinutes = timeInSeconds ~/ Duration.secondsPerMinute;
    timeInSeconds -= timeInMinutes * Duration.secondsPerMinute;
    
    String timeString = "${timeInHours.toString().padLeft(2, '0')}:"
        "${timeInMinutes.toString().padLeft(2, '0')}";
    if(shouldDisplaySeconds){
      timeString += ":${timeInSeconds.remainder(60).toString().padLeft(2, '0')}";
    }
    return timeString;
  }

  Map<TimeUnit, int> fromIntToTimeUnitValues(int timeInSeconds){
    Map<TimeUnit, int> timeUnitValues = {};
    for(TimeUnit timeUnit in TimeUnit.values){
      int secondsPerTimeUnit;
      switch(timeUnit){
        case TimeUnit.hour:
          secondsPerTimeUnit = Duration.secondsPerHour;
          break;
        case TimeUnit.minute:
          secondsPerTimeUnit = Duration.secondsPerMinute;
          break;
        default:
          secondsPerTimeUnit = 1;
          break;
      }
      timeUnitValues[timeUnit] = timeInSeconds ~/ secondsPerTimeUnit;
      timeInSeconds -= timeUnitValues[timeUnit]! * secondsPerTimeUnit;
    }
    return timeUnitValues;
  }

  int fromTimeUnitValuesToInt({int? hours, int? minutes, int? seconds}){
    int timeValue = 0;
    if(hours != null){
      timeValue += Duration.secondsPerHour * hours;
    }
    if(minutes != null){
      timeValue += Duration.secondsPerMinute * minutes;
    }
    if(seconds != null){
      timeValue += seconds;
    }
    return timeValue;
  }

  String fromTimeUnitValuesToString({int? hours, int? minutes, int? seconds, bool shouldDisplaySeconds = true}){
    String timeString = "${(hours ?? 0).toString().padLeft(2, '0')}:${(minutes ?? 0).toString().padLeft(2, '0')}";
    if(shouldDisplaySeconds){
      timeString += ":${(seconds ?? 0).toString().padLeft(2, '0')}";
    }
    return timeString;
  }
}