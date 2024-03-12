import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/facade/cronometer_panel_facade.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';

//DESC: Describes the logic behind the Cronometer Panel.
class CronometerPanelModel extends ChangeNotifier{
  //INFO: Since the Cronometer Panel Model is instanced at the start of the App and remains until it is closed, it is a better ideia to turn it into a static singleton.
  static final CronometerPanelModel _cronometerPanelModel = CronometerPanelModel._internal();
  String _searchTerm = '';
  List<CronometerModel> _searchedCronometers = [];
  
  List<CronometerModel> _cronometersModel = [];
  final CronometerPanelFacade _facade = CronometerPanelFacade();

  int get qtdCronometer => _cronometersModel.length;

  CronometerPanelModel._internal(){
    _facade.readAllDbEntries().then((List<CronometerModel> cronometers){
      _cronometersModel = cronometers;
      _searchCronometers();
    });
  }

  factory CronometerPanelModel() => _cronometerPanelModel;

  //OBS: This function waits for the Cronometer Record to be sent to the Database before creating a new Cronometer Model in the App. If delays begin to happend between
  //  the time that the Creation Dialog is closed and a new Cronometer is added to the Panel, this might be the cause of them. Right now the code is left as is because
  //  the only solution would require the Cronometer Model id to be initialized after it has been created, which may cause some comprehension issues.
  void addCronometer(String cronometerName){
    CronometerModel auxModel = CronometerModel.forInsertion(cronometerName);
    _facade.insertDbEntry(auxModel).then((int crnmtrId){
      _cronometersModel.add(CronometerModel(crnmtrId, cronometerName));
      _searchCronometers();
    });
  }

  void deleteCronometer(CronometerModel cronometer){
    _cronometersModel.remove(cronometer);
    _facade.deleteDbEntry(cronometer);
    _searchCronometers();
  }

  CronometerModel getCronometerModelByIndex(int index){
    return _cronometersModel[index];
  }

  void _searchCronometers(){
    _searchedCronometers.clear();
    for(CronometerModel cronometer in _cronometersModel){
      if(cronometer.nameNotifier.name.toLowerCase().contains(_searchTerm.toLowerCase())){
        _searchedCronometers.add(cronometer);
      }
    }
    sortCronometers();
  }

  void sortCronometers(){
    _cronometersModel.sort((a, b) => a.nameNotifier.name.toLowerCase().compareTo(b.nameNotifier.name.toLowerCase()));
    notifyListeners();
  }

  void updateSearchTerm(String newSearchTerm){
    _searchTerm = newSearchTerm;
    _searchCronometers();
  }
}