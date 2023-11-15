import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

class CronometerPanelFacade{

  void deleteDbEntry(int crnmtrId){
    CronometerDAO().deleteDbEntry(crnmtrId);
  }

  Future<int> insertDbEntry(CronometerModel cronometer){
    return CronometerDAO().insertDbEntry(_getDtoFromModel(cronometer));
  }

  Future<List<CronometerModel>> readAllDbEntries() async {
    List<CronometerDTO> dtos = await CronometerDAO().readAllDbEntries();
    return _getModelListFromDtoList(dtos);
  }

  CronometerDTO _getDtoFromModel(CronometerModel model){
    return CronometerDTO(model.id, model.nameNtfr.name);
  }

  CronometerModel _getModelFromDto(CronometerDTO dto){
    return CronometerModel(dto.idPrprt!, dto.namePrprt!);
  }

  List<CronometerModel> _getModelListFromDtoList(List<CronometerDTO> dtos){
    List<CronometerModel> models = [];
    for(CronometerDTO dto in dtos){
      models.add(_getModelFromDto(dto));
    }
    return models;
  }
}