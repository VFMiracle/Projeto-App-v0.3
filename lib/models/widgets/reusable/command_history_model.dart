import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';

abstract class CommandHistoryModel{

  String get commandName;

  DateTime get creationDate;

  String get targetName;

  dynamic get updateInfo;

  void delete(){
    CommandHistoryPanelModel().historiesNotifier.deleteHistory(this);
  }
}