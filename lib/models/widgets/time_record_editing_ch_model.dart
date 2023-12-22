import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class TimeRecordEditingChModel extends CommandHistoryModel{
  final TimeRecordEditingCommand _command;
  final dynamic _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  TimeRecordEditingChModel({required TimeRecordEditingCommand command, required String targetName, dynamic updateInfo}): _command = command,
      _updateInfo = updateInfo, super(targetName: targetName, creationDate: DateTime.now());
}