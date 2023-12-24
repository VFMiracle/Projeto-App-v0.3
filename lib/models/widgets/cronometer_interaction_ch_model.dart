import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CronometerInteractionChModel extends CommandHistoryModel{
  final CronometerInteractionCommand _command;
  final int? _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerInteractionChModel({required CronometerInteractionCommand command, required String targetName, int? updateInfo}): _command = command,
      _updateInfo = updateInfo, super(targetName: targetName, creationDateTime: DateTime.now());
}