import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class TestCommandHistoryModel implements CommandHistoryModel{
  final String _commandName;
  final DateTime _creationDate;
  final String _targetName;
  final dynamic _updateInfo;

  @override
  String get commandName => _commandName;

  @override
  DateTime get creationDate => _creationDate;

  @override
  String get targetName => _targetName;

  @override
  dynamic get updateInfo => _updateInfo;

  TestCommandHistoryModel({dynamic updateInfo}): _commandName = "Some Command", _creationDate = DateTime.now(), _targetName = "A Cronometer", _updateInfo = updateInfo;
}