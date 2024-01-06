import 'package:projeto_time_counter/enums/command_history_type.dart';

class CommandHistoryDTO{
  final int _id;
  final String _command;
  final String _targetName;
  final CommandHistoryType _type;
  final DateTime _creationDateTime;
  final String? _updateInfo;

  int get id => _id;

  String get command => _command;

  String get targetName => _targetName;

  CommandHistoryType get type => _type;

  DateTime get creationDateTime => _creationDateTime;
  
  String? get updateInfo => _updateInfo;

  CommandHistoryDTO({required int id, required String command, required String targetName, required CommandHistoryType type, required DateTime creationDateTime,
    required String? updateInfo}): _id = id, _command = command, _targetName = targetName, _type = type, _creationDateTime = creationDateTime, _updateInfo = updateInfo;
}