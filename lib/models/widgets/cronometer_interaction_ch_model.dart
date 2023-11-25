import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CronometerInteractionChModel extends CommandHistoryModel{
  final CronometerInteractionCommand _command;
  final DateTime _creationDate;
  final String _targetName;
  final dynamic _updateInfo;

  @override
  String get commandName => _command.toString();

  @override
  DateTime get creationDate => _creationDate;

  @override
  String get targetName => _targetName;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerInteractionChModel({required CronometerInteractionCommand command, required String targetName, dynamic updateInfo}): _command = command,
      _creationDate = DateTime.now(), _targetName = targetName, _updateInfo = updateInfo;
}