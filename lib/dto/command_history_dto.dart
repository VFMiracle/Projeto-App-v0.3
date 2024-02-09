import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';

class CommandHistoryDTO{
  final int? _id;
  final int _commandId;
  final CommandHistoryType _type;
  final String _targetName;
  final String? _updateInfo;
  final DateTime _historyCreation;

  int get commandId => _commandId;

  int? get id => _id;

  CommandHistoryType get type => _type;

  String get targetName => _targetName;
  
  String? get updateInfo => _updateInfo;

  DateTime get historyCreation => _historyCreation;

  CommandHistoryDTO({
    int? id,
    required int commandId,
    required CommandHistoryType type,
    required String targetName,
    required String? updateInfo,
    DateTime? historyCreation
  }): _id = id, _commandId = commandId, _type = type, _targetName = targetName, _updateInfo = updateInfo, _historyCreation = historyCreation ?? DateTime.now();

  CommandHistoryDTO.trEditingRecordingDto({
    required TimeRecordEditingCommand command,
    required String targetName,
    required Map<String, dynamic> updateInfo
  }): 
    _id = null,
    _commandId = command.commandId,
    _type = CommandHistoryType.timeRecordEditing,
    _targetName = targetName,
    _updateInfo = _writeTREditingUpdateInfoFromMap(command, updateInfo),
    _historyCreation = DateTime.now();

  static String _writeTREditingUpdateInfoFromMap(TimeRecordEditingCommand command, Map<String, dynamic> updateInfo){
    String result =
      "da_recordDate:${DateTimeUtils().mapDateToDatabaseString(updateInfo['recordDate'] as DateTime)}";
    switch(command){
      case TimeRecordEditingCommand.create:
        result += ", in_initialValue:${updateInfo['initialValue']}";
        break;
      case TimeRecordEditingCommand.delete:
        result += ", in_deleteValue:${updateInfo['deleteValue']}";
        break;
      case TimeRecordEditingCommand.updateName:
        result += ", st_newName:${updateInfo['newName']}";
        break;
      case TimeRecordEditingCommand.updateValue:
        result += ", in_oldValue:${updateInfo['oldValue']}, in_newValue:${updateInfo['newValue']}";
        break;
    }
    return result;
  }
}