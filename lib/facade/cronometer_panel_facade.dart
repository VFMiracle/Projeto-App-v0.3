import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerPanelFacade{

  void deleteDbEntry(CronometerModel cronometer){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO(commandId: CronometerEditingCommand.delete.commandId, type: CommandHistoryType.cronometerEditing, targetName: cronometer.nameNotifier.name,
        updateInfo: null)
    );
    CronometerDAO().deleteDbEntry(cronometer.id);
  }

  Future<int> insertDbEntry(CronometerModel cronometer){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryDTO(commandId: CronometerEditingCommand.create.commandId, type: CommandHistoryType.cronometerEditing, targetName: cronometer.nameNotifier.name,
        updateInfo: null)
    );
    return CronometerDAO().insertDbEntry(_getDtoFromModel(cronometer));
  }

  Future<List<CronometerModel>> readAllDbEntries() async {
    List<CronometerDTO> dtos = await CronometerDAO().readAllDbEntries();
    return await _getModelListFromDtoList(dtos);
  }

  CronometerDTO _getDtoFromModel(CronometerModel model){
    return CronometerDTO(model.id, model.nameNotifier.name);
  }

  Future<CronometerModel> _getModelFromDto(CronometerDTO dto) async {
    bool isRunning = false;
    int startValue = 0;
    CommandHistoryDTO? lastCronoIntrct = await CommandHistoryDAO().readDbLastCronoIntrctEntry(dto.name);
    if(lastCronoIntrct != null){
      CronometerInteractionCommand lastInteractionCommand = CronometerInteractionCommand.getCommandById(lastCronoIntrct.commandId)!;
      if(lastInteractionCommand.requiresInitialization){
        switch(lastInteractionCommand){
          case CronometerInteractionCommand.start:
            startValue = int.parse(lastCronoIntrct.updateInfo!) + DateTime.now().difference(lastCronoIntrct.historyCreation).inSeconds;
            isRunning = true;
            break;
          case CronometerInteractionCommand.pause:
            startValue = int.parse(lastCronoIntrct.updateInfo!);
            break;
          default:
            break;
        }
      }
    }
    return CronometerModel(dto.id!, dto.name, startValue: startValue, isRunning: isRunning);
  }

  Future<List<CronometerModel>> _getModelListFromDtoList(List<CronometerDTO> dtos) async {
    List<CronometerModel> models = [];
    for(CronometerDTO dto in dtos){
      models.add( await _getModelFromDto(dto));
    }
    return models;
  }
}