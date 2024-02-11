import 'package:flutter/material.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/facade/command_history_panel_facade.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';

class CommandHistoryPanelModel{
  static CommandHistoryPanelModel? _commandHistoryPanelModel;
  
  final CommandHistoryPanelFacade _facade = CommandHistoryPanelFacade();
  late final CommandHistoryPanelHistoriesNotifier _historiesNotifier;
  late final CommandHistoryPanelSelDateNotifier _selDateNotifier;

  CommandHistoryPanelHistoriesNotifier get historiesNotifier => _historiesNotifier;

  CommandHistoryPanelSelDateNotifier get selDateNotifier => _selDateNotifier;

  CommandHistoryPanelModel._internal(){
    _selDateNotifier = CommandHistoryPanelSelDateNotifier(this);
    _historiesNotifier = CommandHistoryPanelHistoriesNotifier(this);
  }

  factory CommandHistoryPanelModel(){
    _commandHistoryPanelModel ??= CommandHistoryPanelModel._internal();
    return _commandHistoryPanelModel!;
  }

  static void disposeInstance(){
    _commandHistoryPanelModel = null;
  }
}

class CommandHistoryPanelHistoriesNotifier extends ChangeNotifier{
  CommandHistoryType _selCommandHistoryType = CommandHistoryType.cronometerEditing;
  final List<CommandHistoryModel> histories = [];
  // ignore: unused_field
  final CommandHistoryPanelModel _parentModel;

  int get qtdHistories => histories.length;

  CommandHistoryType get selCommandHistoryType => _selCommandHistoryType;

  set selCommandHistoryType(CommandHistoryType newValue){
    _selCommandHistoryType = newValue;
    _loadDesiredCommandHistories();
  }

  CommandHistoryPanelHistoriesNotifier(CommandHistoryPanelModel parentModel): _parentModel = parentModel{
    _loadDesiredCommandHistories();
  }

  void addHistory(CommandHistoryModel history){
    histories.add(history);
    notifyListeners();
  }

  void addHistories(List<CommandHistoryModel> histories){
    histories.addAll(histories);
    notifyListeners();
  }

  void deleteHistory(CommandHistoryModel commandHistory){
    histories.remove(commandHistory);
    _parentModel._facade.deleteDbEntry(commandHistory.id);
    notifyListeners();
  }

  CommandHistoryModel getHistoryByIndex(int index){
    return histories[index];
  }

  void _loadDesiredCommandHistories() async {
    histories.clear();
    histories.addAll(await _parentModel._facade.readDbEntries(_selCommandHistoryType, _parentModel._selDateNotifier._selDate));
    notifyListeners();
  }
}

class CommandHistoryPanelSelDateNotifier extends ChangeNotifier{
  DateTime _selDate;
  // ignore: unused_field
  final CommandHistoryPanelModel _parentModel;

  DateTime get selDate => _selDate;
  set selDate(DateTime newDate){
    _selDate = newDate;
    _parentModel._historiesNotifier._loadDesiredCommandHistories();
    notifyListeners();
  }

  CommandHistoryPanelSelDateNotifier(CommandHistoryPanelModel parentModel): _parentModel = parentModel, _selDate = DateTime.now();
}