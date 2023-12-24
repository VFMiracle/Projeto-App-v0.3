import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';

abstract class CommandHistoryModel{
  final String _targetName;
  final DateTime _creationDateTime;

  String get commandName;

  DateTime get creationDateTime => _creationDateTime;

  String get targetName => _targetName;

  dynamic get updateInfo;

  CommandHistoryModel({required String targetName, required DateTime creationDateTime}): _targetName = targetName, _creationDateTime = creationDateTime;

  void delete(){
    CommandHistoryPanelModel().historiesNotifier.deleteHistory(this);
  }

  String writeUpdateInfoPreamble();
}