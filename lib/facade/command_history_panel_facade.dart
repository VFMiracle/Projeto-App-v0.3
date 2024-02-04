import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_editing_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_interaction_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_editing_ch_model.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';

class CommandHistoryPanelFacade{

  Future<List<CommandHistoryModel>> readDbEntries(CommandHistoryType commandType, DateTime selDate) async {
    List<CommandHistoryLoadingDTO> dtos = await CommandHistoryDAO().readDbEntriesByCommandType(commandType.id, selDate);
    return _getModelListFromDtoList(dtos);
  }

  Map<String, dynamic> _convertUpdateInfoStringToMap(String updateInfoString){
    Map<String, dynamic> updateInfoMap = {};
    List<String> entriesString = updateInfoString.split(", ");
    for(String entryString in entriesString){
      List<String> keyValuePairStrings = entryString.split(':');
      dynamic entryValue;
      String valueTypeAsString = keyValuePairStrings[0].substring(0, 2);
      keyValuePairStrings[0] = keyValuePairStrings[0].substring(3);
      switch(valueTypeAsString){
        case "da":
          entryValue = DateTimeUtils().mapDatabaseStringToDate(keyValuePairStrings[1]);
          break;
        case "in":
          entryValue = int.parse(keyValuePairStrings[1]);
          break;
        case "st":
          entryValue = keyValuePairStrings[1];
          break;
      }
      updateInfoMap.addAll({keyValuePairStrings[0]: entryValue});
    }
    return updateInfoMap;
  }

  dynamic _convertUpdateInfoStringToType(String updateInfo, Type type){
    switch(type){
      case int:
        return int.parse(updateInfo);
      case String:
        return updateInfo;
      case Map:
        return _convertUpdateInfoStringToMap(updateInfo);
      default:
        return null;
    }
  }

  List<CommandHistoryModel> _getModelListFromDtoList(List<CommandHistoryLoadingDTO> dtos){
    List<CommandHistoryModel> models = [];
    for(CommandHistoryLoadingDTO dto in dtos){
      models.add(_mapDtoToModel(dto));
    }
    return models;
  }

  CommandHistoryModel _mapDtoToModel(CommandHistoryLoadingDTO dto){
    switch(dto.type){
      case CommandHistoryType.cronometerEditing:
        CronometerEditingCommand command = CronometerEditingCommand.getCommandByName(dto.commandName)!;
        dynamic updateInfo;
        if(command.updateInfoType != null){
          updateInfo = _convertUpdateInfoStringToType(dto.updateInfo!, command.updateInfoType!);
        }
        return CronometerEditingChModel(id: dto.id, command: command, targetName: dto.targetName, creationDateTime: dto.creationDateTime, updateInfo: updateInfo);
      case CommandHistoryType.cronometerInteraction:
        CronometerInteractionCommand command = CronometerInteractionCommand.getCommandByName(dto.commandName)!;
        dynamic updateInfo;
        if(command.updateInfoType != null){
          updateInfo = _convertUpdateInfoStringToType(dto.updateInfo!, command.updateInfoType!);
        }
        return CronometerInteractionChModel(id: dto.id, command: command, targetName: dto.targetName, creationDateTime: dto.creationDateTime, updateInfo: updateInfo);
      case CommandHistoryType.timeRecordEditing:
        TimeRecordEditingCommand command = TimeRecordEditingCommand.getCommandByName(dto.commandName)!;
        dynamic updateInfo;
        if(command.updateInfoType != null){
          updateInfo = _convertUpdateInfoStringToType(dto.updateInfo!, command.updateInfoType!);
        }
        return TimeRecordEditingChModel(id: dto.id, command: command, targetName: dto.targetName, creationDateTime: dto.creationDateTime, updateInfo: updateInfo);
    }
  }
}