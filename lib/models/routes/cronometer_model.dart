import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:projeto_time_counter/facade/cronometer_facade.dart';
import 'package:projeto_time_counter/models/routes/cronometer_panel_model.dart';

//DESC: Describes the logic behind a Cronometer.
class CronometerModel{
  final int _id;
  late final CronometerIsRunningNotifier _isRunningNotifier;
  late final CronometerNameNotifier _nameNotifier;
  late final CronometerValueNotifier _valueNotifier;

  int get id => _id;

  CronometerIsRunningNotifier get isRunningNotifier => _isRunningNotifier;

  CronometerNameNotifier get nameNotifier => _nameNotifier;

  CronometerValueNotifier get valueNotifier => _valueNotifier;

  CronometerModel(this._id, String name, {bool isRunning = false, int startValue = 0}){
    _isRunningNotifier = CronometerIsRunningNotifier(this, isRunning);
    _nameNotifier = CronometerNameNotifier(this, name);
    _valueNotifier = CronometerValueNotifier(this, startValue, isRunning: isRunning);
  }

  CronometerModel.forInsertion(String name): _id = -1{
    _isRunningNotifier = CronometerIsRunningNotifier(this, false);
    _nameNotifier = CronometerNameNotifier(this, name);
    _valueNotifier = CronometerValueNotifier(this, 0);
  }

  void delete(){
    CronometerPanelModel().deleteCronometer(this);
  }

  void resetValue(bool shouldRecordTime){
    if(shouldRecordTime){
      int timeToRecord = _valueNotifier.currentValue;
      CronometerFacade().addTimeToRecords(_nameNotifier.name, timeToRecord);
    }
    CronometerFacade().recordTimeReset(this, shouldRecordTime);
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
  bool _isRunning;
  //ignore: unused_field
  final CronometerModel _parentModel;

  bool get isRunning => _isRunning;

  CronometerIsRunningNotifier(this._parentModel, this._isRunning);

  void _toggle(){
    _isRunning = !_isRunning;
    CronometerFacade().recordIsRunningToggle(_parentModel);
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
    CronometerPanelModel().sortCronometers();
    CronometerFacade().updateDbEntry(_parentModel, oldName);
    notifyListeners();
  }

  CronometerNameNotifier(this._parentModel, this._name);
}

class CronometerValueNotifier extends ChangeNotifier{
  int _startValue, _currentValue;
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

  CronometerValueNotifier(this._parentModel, this._startValue, {bool isRunning = false}): _currentValue = _startValue{
    if(isRunning){
      _startTimeCounter();
    }
  }

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