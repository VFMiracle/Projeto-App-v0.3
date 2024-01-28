import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/facade/cronometer_facade.dart';
import 'package:projeto_time_counter/models/routes/cronometer_panel_model.dart';

//DESC: Describes the logic behind a Cronometer.
class CronometerModel{
  final int _id;
  final CronometerFacade _facade = CronometerFacade();
  late final CronometerIsRunningNotifier _isRunningNotifier;
  late final CronometerNameNotifier _nameNotifier;
  late final CronometerValueNotifier _valueNotifier;

  int get id => _id;

  CronometerIsRunningNotifier get isRunningNotifier => _isRunningNotifier;

  CronometerNameNotifier get nameNotifier => _nameNotifier;

  CronometerValueNotifier get valueNotifier => _valueNotifier;

  CronometerModel(this._id, String name){
    //OBS: The Notifiers are being initialized insede the constructor because the 'this' keyword can't be used before this moment.
    //INFO: The Model reference needs to be sent so the Notifiers can have knowledge of the Model they're associated with.
    _isRunningNotifier = CronometerIsRunningNotifier(this);
    _nameNotifier = CronometerNameNotifier(this, name);
    _valueNotifier = CronometerValueNotifier(this);
  }

  void delete(){
    CronometerPanelModel().deleteCronometer(this);
  }

  void resetValue(bool shouldRecordTime){
    if(shouldRecordTime){
      int rcrddTime = _valueNotifier.currentValue;
      _facade.addTimeToRecords(_nameNotifier.name, rcrddTime);
    }
    _valueNotifier.startValue = 0;
  }

  void toggleIsRunning(){
    _isRunningNotifier._toggle();
    if(_isRunningNotifier.isRunning){
      _valueNotifier._startTimeCounter();
    }else{
      _valueNotifier._stopTimeCounter();
    }
  }
}

class CronometerIsRunningNotifier extends ChangeNotifier{
  bool _isRunning = false;
  //ignore: unused_field
  final CronometerModel _parentModel;

  bool get isRunning => _isRunning;

  CronometerIsRunningNotifier(this._parentModel);

  void _toggle(){
    _isRunning = !_isRunning;
    notifyListeners();
  }
}

class CronometerNameNotifier extends ChangeNotifier{
  String _name;
  final CronometerModel _parentModel;

  String get name => _name;
  set name(String newName){
    String oldName = _name;
    _name = newName;
    _parentModel._facade.updateDbEntry(_parentModel, oldName);
    notifyListeners();
  }

  CronometerNameNotifier(this._parentModel, String name) : _name = name;
}

class CronometerValueNotifier extends ChangeNotifier{
  int _startValue = 0, _currentValue = 0;
  DateTime _startTime = DateTime.now();
  Timer? _timeCounter;
  //ignore: unused_field
  final CronometerModel _parentModel;

  int get currentValue => _currentValue;

  set startValue(int newValue){
    _startValue = newValue;
    _currentValue = _startValue;
    _startTime = DateTime.now();
    notifyListeners();
  }

  CronometerValueNotifier(this._parentModel);

  void _startTimeCounter(){
    _startTime = DateTime.now();
    _timeCounter = Timer.periodic(const Duration(milliseconds: 500), (Timer timer){
      _currentValue = _startValue + DateTime.now().difference(_startTime).inSeconds;
      notifyListeners();
    });
  }

  void _stopTimeCounter(){
    _currentValue = _startValue + DateTime.now().difference(_startTime).inSeconds;
    _startValue = _currentValue;
    _timeCounter!.cancel();
  }
}