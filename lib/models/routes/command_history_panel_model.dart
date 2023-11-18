import 'package:flutter/material.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/models/widgets/reusable/test_command_history_model.dart';
import 'package:projeto_time_counter/services/time_conversion_service.dart';

class CommandHistoryPanelModel{
  static CommandHistoryPanelModel? _commandHistoryPanelModel;
  
  late final CommandHistoryPanelHistoriesNotifier _historiesNotifier;

  CommandHistoryPanelHistoriesNotifier get historiesNotifier => _historiesNotifier;

  CommandHistoryPanelModel._internal(){
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
  final List<CommandHistoryModel> histories = [];
  // ignore: unused_field
  final CommandHistoryPanelModel _parentModel;

  int get qtdHistories => histories.length;

  CommandHistoryPanelHistoriesNotifier(CommandHistoryPanelModel parentModel): _parentModel = parentModel{
    histories.addAll([TestCommandHistoryModel(), TestCommandHistoryModel(updateInfo: 2), TestCommandHistoryModel(updateInfo: "Updated Info Section"),
      TestCommandHistoryModel(updateInfo: TimeConversionService().fromTimeUnitValuesToString(hours: 1, minutes: 23, seconds: 45))]);
  }

  addHistory(CommandHistoryModel history){
    histories.add(history);
    notifyListeners();
  }

  addHistories(List<CommandHistoryModel> histories){
    histories.addAll(histories);
    notifyListeners();
  }

  deleteHistory(CommandHistoryModel history){
    histories.remove(history);
    notifyListeners();
  }

  getHistoryByIndex(int index){
    return histories[index];
  }
}