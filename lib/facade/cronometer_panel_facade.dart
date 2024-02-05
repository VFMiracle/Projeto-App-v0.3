import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerPanelFacade{

  void deleteDbEntry(CronometerModel cronometer){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryRecordingDTO(commandId: CronometerEditingCommand.delete.commandId, targetName: cronometer.nameNotifier.name, updateInfo: null)
    );
    CronometerDAO().deleteDbEntry(cronometer.id);
  }

  Future<int> insertDbEntry(CronometerModel cronometer){
    CommandHistoryDAO().insertDbEntry(
      CommandHistoryRecordingDTO(commandId: CronometerEditingCommand.create.commandId, targetName: cronometer.nameNotifier.name, updateInfo: null)
    );
    return CronometerDAO().insertDbEntry(_getDtoFromModel(cronometer));
  }

  Future<List<CronometerModel>> readAllDbEntries() async {
    List<CronometerDTO> dtos = await CronometerDAO().readAllDbEntries();
    return _getModelListFromDtoList(dtos);
  }

  CronometerDTO _getDtoFromModel(CronometerModel model){
    return CronometerDTO(model.id, model.nameNotifier.name);
  }

  CronometerModel _getModelFromDto(CronometerDTO dto){
    return CronometerModel(dto.id!, dto.name);
  }

  List<CronometerModel> _getModelListFromDtoList(List<CronometerDTO> dtos){
    List<CronometerModel> models = [];
    for(CronometerDTO dto in dtos){
      models.add(_getModelFromDto(dto));
    }
    return models;
  }
}