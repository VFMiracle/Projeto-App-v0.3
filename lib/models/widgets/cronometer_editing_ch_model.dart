import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CronometerEditingChModel extends CommandHistoryModel{
  final CronometerEditingCommand _command;
  final DateTime _creationDate;
  final String _targetName;
  final dynamic _updateInfo;

  @override
  String get commandName {
    switch(_command){
      case CronometerEditingCommand.create:
        return "Create";
      case CronometerEditingCommand.delete:
        return "Delete";
      case CronometerEditingCommand.updateName:
        return "Update Name";
    }
  }

  @override
  DateTime get creationDate => _creationDate;

  @override
  String get targetName => _targetName;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerEditingChModel({required CronometerEditingCommand command, required String targetName, dynamic updateInfo}): _command = command,
      _targetName = targetName, _creationDate = DateTime.now(), _updateInfo = updateInfo;
}