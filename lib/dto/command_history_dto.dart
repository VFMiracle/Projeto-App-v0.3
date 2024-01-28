import 'package:projeto_time_counter/enums/command_history_type.dart';

abstract class CommandHistoryDTO{
  final String _targetName;
  final String? _updateInfo;

  String get targetName => _targetName;
  
  String? get updateInfo => _updateInfo;

  CommandHistoryDTO({required String targetName, required String? updateInfo}): _targetName = targetName, _updateInfo = updateInfo;
}

class CommandHistoryLoadingDTO extends CommandHistoryDTO{
  final int _id;
  final String _commandName;
  final CommandHistoryType _type;
  final DateTime _creationDateTime;

  int get id => _id;

  String get commandName => _commandName;

  CommandHistoryType get type => _type;

  DateTime get creationDateTime => _creationDateTime;

  CommandHistoryLoadingDTO({required int id, required String commandName, required String targetName, required CommandHistoryType type, required DateTime creationDateTime,
    required String? updateInfo}): _id = id, _commandName = commandName, _creationDateTime = creationDateTime, _type = type, super(targetName: targetName,
    updateInfo: updateInfo);
}

class CommandHistoryRecordingDTO extends CommandHistoryDTO{
  final int _commandId;

  int get commandId => _commandId;

  CommandHistoryRecordingDTO({required int commandId, required targetName, required String? updateInfo}): _commandId = commandId,
    super(targetName: targetName, updateInfo: updateInfo);
}