import 'package:flutter/material.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/facade/command_history_panel_facade.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_editing_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_interaction_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_editing_ch_model.dart';

class CommandHistoryPanelModel{
  static CommandHistoryPanelModel? _commandHistoryPanelModel;
  
  final CommandHistoryPanelFacade _facade = CommandHistoryPanelFacade();
  late final CommandHistoryPanelHistoriesNotifier _historiesNotifier;

  CommandHistoryPanelHistoriesNotifier get historiesNotifier => _historiesNotifier;

  CommandHistoryPanelModel._internal(){
    _facade.testing();
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

  _loadDesiredCommandHistories(){
    histories.clear();
    switch(_selCommandHistoryType){
      case (CommandHistoryType.cronometerEditing):
        histories.addAll([
          CronometerEditingChModel(id: 1, command: CronometerEditingCommand.create, targetName: "Erguminoga"),
          CronometerEditingChModel(id: 2, command: CronometerEditingCommand.updateName, targetName: "Erguminoga", updateInfo: "Pergucielo"),
          CronometerEditingChModel(id: 3, command: CronometerEditingCommand.delete, targetName: "Pergucielo"),
          CronometerEditingChModel(id: 4, command: CronometerEditingCommand.create, targetName: "Arguminogaf")
        ]);
        break;
      case (CommandHistoryType.cronometerInteraction):
        histories.addAll([
          CronometerInteractionChModel(id: 5, command: CronometerInteractionCommand.start, targetName: "Pergucielo", updateInfo: 0),
          CronometerInteractionChModel(id: 6, command: CronometerInteractionCommand.pause, targetName: "Pergucielo", updateInfo: 320),
          CronometerInteractionChModel(id: 7, command: CronometerInteractionCommand.resetAndSaveTime, targetName: "Pergucielo", updateInfo: 600),
          CronometerInteractionChModel(id: 8, command: CronometerInteractionCommand.start, targetName: "Arguminogaf", updateInfo: 0),
          CronometerInteractionChModel(id: 9, command: CronometerInteractionCommand.pause, targetName: "Arguminogaf", updateInfo: 1000),
          CronometerInteractionChModel(id: 10, command: CronometerInteractionCommand.resetAndDeleteTime, targetName: "Arguminogaf", updateInfo: 1000),
          CronometerInteractionChModel(id: 11, command: CronometerInteractionCommand.start, targetName: "Arguminogaf", updateInfo: 0),
          CronometerInteractionChModel(id: 12, command: CronometerInteractionCommand.pause, targetName: "Arguminogaf", updateInfo: 200),
          CronometerInteractionChModel(id: 13, command: CronometerInteractionCommand.resetAndDeleteTime, targetName: "Arguminogaf", updateInfo: 4000),
        ]);
        break;
      case(CommandHistoryType.timeRecordEditing):
        histories.addAll([
          TimeRecordEditingChModel(id: 14, command: TimeRecordEditingCommand.create, targetName: "Pergucielo", updateInfo: 600),
          TimeRecordEditingChModel(id: 15, command: TimeRecordEditingCommand.updateName, targetName: "Pergucielo", updateInfo: "Borguvisol"),
          TimeRecordEditingChModel(id: 16, command: TimeRecordEditingCommand.updateValue, targetName: "Borguvisol",
              updateInfo: <String, int>{"oldValue": 600, "newValue": 450}),
          TimeRecordEditingChModel(id: 17, command: TimeRecordEditingCommand.delete, targetName: "Borguvisol"),
          TimeRecordEditingChModel(id: 18, command: TimeRecordEditingCommand.create, targetName: "Arguminogaf", updateInfo: 200)
        ]);
        break;
    }
  }
}