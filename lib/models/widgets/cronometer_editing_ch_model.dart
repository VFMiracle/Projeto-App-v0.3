import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CronometerEditingChModel extends CommandHistoryModel{
  final CronometerEditingCommand _command;
  final String? _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerEditingChModel({required CronometerEditingCommand command, required String targetName, String? updateInfo}): _command = command,
      _updateInfo = updateInfo, super(targetName: targetName, creationDate: DateTime.now());
}