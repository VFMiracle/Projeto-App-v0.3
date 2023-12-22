import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';

abstract class CommandHistoryModel{
  final String _targetName;
  final DateTime _creationDate;

  String get commandName;

  DateTime get creationDate => _creationDate;

  String get targetName => _targetName;

  dynamic get updateInfo;

  CommandHistoryModel({required String targetName, required DateTime creationDate}): _targetName = targetName, _creationDate = creationDate;

  void delete(){
    CommandHistoryPanelModel().historiesNotifier.deleteHistory(this);
  }
}