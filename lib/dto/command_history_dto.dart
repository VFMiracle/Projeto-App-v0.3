import 'package:projeto_time_counter/enums/command_history_type.dart';

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
  }): _commandId = commandId, _id = id, _type = type, _targetName = targetName, _updateInfo = updateInfo, _historyCreation = historyCreation ?? DateTime.now();
}