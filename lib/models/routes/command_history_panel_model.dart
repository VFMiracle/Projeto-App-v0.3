import 'package:flutter/material.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/enums/cronometer_editing_command.dart';
import 'package:projeto_time_counter/enums/cronometer_interaction_command.dart';
import 'package:projeto_time_counter/enums/time_record_editing_command.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_editing_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/cronometer_interaction_ch_model.dart';
import 'package:projeto_time_counter/models/widgets/reusable/command_history_model.dart';
import 'package:projeto_time_counter/models/widgets/time_record_editing_ch_model.dart';

class CommandHistoryPanelModel{
  static CommandHistoryType _selCommandHistoryType = CommandHistoryType.cronometerEditing;
  static CommandHistoryPanelModel? _commandHistoryPanelModel;
  
  late final CommandHistoryPanelHistoriesNotifier _historiesNotifier;

  set selCommandHistoryType(CommandHistoryType newValue){
    _selCommandHistoryType = newValue;

  }

  CommandHistoryPanelHistoriesNotifier get historiesNotifier => _historiesNotifier;

  CommandHistoryPanelModel._internal(CommandHistoryType commandHistoryType){
    _historiesNotifier = CommandHistoryPanelHistoriesNotifier(this, commandHistoryType);
  }

  factory CommandHistoryPanelModel(){
    _commandHistoryPanelModel ??= CommandHistoryPanelModel._internal(commandHistoryType);
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

  CommandHistoryPanelHistoriesNotifier(CommandHistoryPanelModel parentModel, CommandHistoryType commandHistoryType): _parentModel = parentModel{
    _loadDesiredCommandHistories(commandHistoryType);
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

  _loadDesiredCommandHistories(CommandHistoryType commandHistoryType){
    switch(commandHistoryType){
      case (CommandHistoryType.cronometerEditing):
        histories.addAll([
          CronometerEditingChModel(command: CronometerEditingCommand.create, targetName: "Erguminoga"),
          CronometerEditingChModel(command: CronometerEditingCommand.updateName, targetName: "Erguminoga", updateInfo: "Pergucielo"),
          CronometerEditingChModel(command: CronometerEditingCommand.delete, targetName: "Pergucielo"),
          CronometerEditingChModel(command: CronometerEditingCommand.create, targetName: "Arguminogaf")
        ]);
        break;
      case (CommandHistoryType.cronometerInteraction):
        histories.addAll([
          CronometerInteractionChModel(command: CronometerInteractionCommand.start, targetName: "Pergucielo", updateInfo: 0),
          CronometerInteractionChModel(command: CronometerInteractionCommand.pause, targetName: "Pergucielo", updateInfo: 320),
          CronometerInteractionChModel(command: CronometerInteractionCommand.resetAndSaveTime, targetName: "Pergucielo", updateInfo: 600),
          CronometerInteractionChModel(command: CronometerInteractionCommand.start, targetName: "Arguminogaf", updateInfo: 0),
          CronometerInteractionChModel(command: CronometerInteractionCommand.pause, targetName: "Arguminogaf", updateInfo: 1000),
          CronometerInteractionChModel(command: CronometerInteractionCommand.resetAndDeleteTime, targetName: "Arguminogaf", updateInfo: 1000),
          CronometerInteractionChModel(command: CronometerInteractionCommand.start, targetName: "Arguminogaf", updateInfo: 0),
          CronometerInteractionChModel(command: CronometerInteractionCommand.pause, targetName: "Arguminogaf", updateInfo: 200),
          CronometerInteractionChModel(command: CronometerInteractionCommand.resetAndDeleteTime, targetName: "Arguminogaf", updateInfo: 200),
        ]);
        break;
      case(CommandHistoryType.timeRecordEditing):
        histories.addAll([
          TimeRecordEditingChModel(command: TimeRecordEditingCommand.create, targetName: "Pergucielo", updateInfo: 600),
          TimeRecordEditingChModel(command: TimeRecordEditingCommand.updateName, targetName: "Pergucielo", updateInfo: "Borguvisol"),
          TimeRecordEditingChModel(command: TimeRecordEditingCommand.updateValue, targetName: "Borguvisol",
              updateInfo: <String, int>{"oldValue": 600, "newValue": 450}),
          TimeRecordEditingChModel(command: TimeRecordEditingCommand.delete, targetName: "Borguvisol"),
          TimeRecordEditingChModel(command: TimeRecordEditingCommand.create, targetName: "Arguminogaf", updateInfo: 200)
        ]);
        break;
    }
  }
}

abstract class _CommandHistoryPanelHistoriesNotifierRestrictConnection{
  
}