import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';
import 'package:timezone/timezone.dart';

class CronometerInteractionChModel extends CommandHistoryModel{
  final CronometerInteractionCommand _command;
  final int? _updateInfo;

  @override
  String get commandName => _command.name;

  @override
  dynamic get updateInfo => _updateInfo;

  CronometerInteractionChModel({required int id, required CronometerInteractionCommand command, required String targetName, int? updateInfo}): _command = command,
      _updateInfo = updateInfo, super(id: id, targetName: targetName, creationDateTime: TZDateTime.now(getLocation("America/Sao_Paulo")));

  @override
  String writeUpdateInfoDisplayString({bool useDefaultPreamble = true}){
    String displayString = "";
    if(useDefaultPreamble){
      switch(_command){
        case CronometerInteractionCommand.start:
          displayString += "Initial Time: ";
          break;
        case CronometerInteractionCommand.pause:
          displayString += "Paused On Time: ";
          break;
        default:
          displayString += "Time At Reset: ";
          break;
      }
    }
    displayString += TimeConversionService().fromIntToString(_updateInfo!);
    return displayString;
  }
}