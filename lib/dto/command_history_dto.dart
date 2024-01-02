import 'package:projeto_time_counter/enums/command_history_type.dart';

class CommandHistoryDTO{
  final int _id;
  final String _command;
  final String _targetName;
  final CommandHistoryType _type;
  final DateTime _creationDate;
  final String? _updateInfo;

  int get id => _id;

  String get command => _command;

  String get targetName => _targetName;

  CommandHistoryType get type => _type;

  DateTime get creationDate => _creationDate;
  
  String? get updateInfo => _updateInfo;

  CommandHistoryDTO({required int id, required String command, required String targetName, required CommandHistoryType type, required DateTime creationDate,
    required String? updateInfo}): _id = id, _command = command, _targetName = targetName, _type = type, _creationDate = creationDate, _updateInfo = updateInfo;
}