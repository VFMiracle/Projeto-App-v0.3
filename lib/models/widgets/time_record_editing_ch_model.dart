import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';

class TimeRecordEditingChModel extends CommandHistoryModel{
  final TimeRecordEditingCommand _command;
  final Map<String, dynamic> _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  TimeRecordEditingChModel({required int id, required TimeRecordEditingCommand command, required String targetName, required Map<String, dynamic> updateInfo,
    DateTime? creationDateTime}): _command = command, _updateInfo = updateInfo, super(id: id, targetName: targetName, creationDateTime: creationDateTime ?? DateTime.now());

  @override
  String writeUpdateInfoDisplayString({bool useDefaultPreamble = true}){
    String displayString = '''Time Record's Date: ${DateTimeUtils().mapDateToDisplayString(_updateInfo["recordDate"])}\n''';
    switch(_command){
      case TimeRecordEditingCommand.create:
        if(useDefaultPreamble){
          displayString += "Initial Value: ";
        }
        displayString += TimeConversionService().fromIntToString(_updateInfo["initialValue"]);
        break;
      case TimeRecordEditingCommand.delete:
        if(useDefaultPreamble){
          displayString += "Deleted Time: ";
        }
        displayString += TimeConversionService().fromIntToString(_updateInfo["deleteValue"]);
        break;
      case TimeRecordEditingCommand.updateName:
        if(useDefaultPreamble){
          displayString += "New Name: ";
        }
        displayString += _updateInfo["newName"];
        break;
      case TimeRecordEditingCommand.updateValue:
        if(useDefaultPreamble){
          displayString += "Old Value: ${TimeConversionService().fromIntToString(_updateInfo['oldValue'])}\n"
          "New Value: ${TimeConversionService().fromIntToString(_updateInfo['newValue'])}";
        }else{
          displayString += _updateInfo.toString();
        }
        break;
      default: break;
    }
    return displayString;
  }
}