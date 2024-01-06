import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:timezone/timezone.dart';

class TimeRecordEditingChModel extends CommandHistoryModel{
  final TimeRecordEditingCommand _command;
  final dynamic _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  TimeRecordEditingChModel({required int id, required TimeRecordEditingCommand command, required String targetName, DateTime? creationDateTime, dynamic updateInfo}):
      _command = command, _updateInfo = updateInfo, super(id: id, targetName: targetName, creationDateTime: creationDateTime ??
      TZDateTime.now(getLocation("America/Sao_Paulo")));

  @override
  String writeUpdateInfoDisplayString({bool useDefaultPreamble = true}){
    String displayString = "";
    switch(_command){
      case TimeRecordEditingCommand.create:
        if(useDefaultPreamble){
          displayString += "Value: ";
        }
        displayString += TimeConversionService().fromIntToString(_updateInfo);
        break;
      case TimeRecordEditingCommand.updateName:
        if(useDefaultPreamble){
          displayString += "New Name: ";
        }
        displayString += _updateInfo;
        break;
      case TimeRecordEditingCommand.updateValue:
        if(useDefaultPreamble){
          displayString = "Old Value: ${TimeConversionService().fromIntToString(_updateInfo['oldValue'])}\n"
          "New Value: ${TimeConversionService().fromIntToString(_updateInfo['newValue'])}";
        }else{
          displayString = _updateInfo.toString();
        }
        break;
      default: break;
    }
    return displayString;
  }
}