import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/facade/cronometer_panel_facade.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

//DESC: Describes the logic behind the Cronometer Panel.
class CronometerPanelModel extends ChangeNotifier{
  //INFO: Since the Cronometer Panel Model is instanced at the start of the App and remains until it is closed, it is a better ideia to turn it into a static singleton.
  static final CronometerPanelModel _crnmtrPanelModel = CronometerPanelModel._internal();
  
  List<CronometerModel> _crnmtrsModel = [];
  final CronometerPanelFacade _facade = CronometerPanelFacade();

  int get qtdCronometer => _crnmtrsModel.length;

  CronometerPanelModel._internal(){
    _facade.readAllDbEntries().then((List<CronometerModel> cronometers){
      _crnmtrsModel = cronometers;
      _sortCronometers();
    });
  }

  factory CronometerPanelModel() => _crnmtrPanelModel;

  //OBS: This function waits for the Cronometer Record to be sent to the Database before creating a new Cronometer Model in the App. If delays begin to happend between
  //  the time that the Creation Dialog is closed and a new Cronometer is added to the Panel, this might be the cause of them. Right now the code is left as is because
  //  the only solution would require the Cronometer Model id to be initialized after it has been created, which may cause some comprehension issues.
  void addCronometer(String crnmtrName){
    CronometerModel auxModel = CronometerModel(-1, crnmtrName);
    _facade.insertDbEntry(auxModel).then((int crnmtrId){
      _crnmtrsModel.add(CronometerModel(crnmtrId, crnmtrName));
      _sortCronometers();
    });
  }

  void deleteCronometer(CronometerModel cronometer){
    _crnmtrsModel.remove(cronometer);
    _facade.deleteDbEntry(cronometer.id);
    _sortCronometers();
  }

  CronometerModel getCronometerModelByIndex(int index){
    return _crnmtrsModel[index];
  }

  void _sortCronometers(){
    _crnmtrsModel.sort((a, b) => a.nameNtfr.name.toLowerCase().compareTo(b.nameNtfr.name.toLowerCase()));
    notifyListeners();
  }
}