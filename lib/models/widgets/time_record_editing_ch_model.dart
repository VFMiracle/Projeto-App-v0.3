import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class TimeRecordEditingChModel extends CommandHistoryModel{
  final TimeRecordEditingCommand _command;
  final DateTime _creationDate;
  final String _targetName;
  final dynamic _updateInfo;

  @override
  String get commandName{
    switch(_command){
      case TimeRecordEditingCommand.create:
        return "Create";
      case TimeRecordEditingCommand.delete:
        return "Delete";
      case TimeRecordEditingCommand.updateName:
        return "Update Name";
      case TimeRecordEditingCommand.updateValue:
        return "Update Value";
    }
  }

  @override
  DateTime get creationDate => _creationDate;

  @override
  String get targetName => _targetName;

  @override
  dynamic get updateInfo => _updateInfo;

  TimeRecordEditingChModel({required TimeRecordEditingCommand command, required String targetName, dynamic updateInfo}): _command = command,
      _creationDate = DateTime.now(), _targetName = targetName, _updateInfo = updateInfo;
}