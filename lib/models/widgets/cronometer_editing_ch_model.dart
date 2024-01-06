import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:timezone/timezone.dart';

class CronometerEditingChModel extends CommandHistoryModel{
  final CronometerEditingCommand _command;
  final String? _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerEditingChModel({required int id, required CronometerEditingCommand command, required String targetName, DateTime? creationDateTime, String? updateInfo}):
      _command = command, _updateInfo = updateInfo, super(id: id, targetName: targetName, creationDateTime: creationDateTime ??
      TZDateTime.now(getLocation("America/Sao_Paulo")));

  @override
  String writeUpdateInfoDisplayString({bool useDefaultPreamble = true}){
    if(useDefaultPreamble){
      return "Cronometer's New Name: $_updateInfo";
    }
    return _updateInfo!;
  }
}