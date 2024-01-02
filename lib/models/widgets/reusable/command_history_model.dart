import 'package:projeto_time_counter/models/routes/command_history_panel_model.dart';

abstract class CommandHistoryModel{
  final int _id;
  final String _targetName;
  final DateTime _creationDateTime;

  int get id => _id;

  String get commandName;

  DateTime get creationDateTime => _creationDateTime;

  String get targetName => _targetName;

  dynamic get updateInfo;

  CommandHistoryModel({required int id, required String targetName, required DateTime creationDateTime}): _id = id, _targetName = targetName,
    _creationDateTime = creationDateTime;

  void delete(){
    CommandHistoryPanelModel().historiesNotifier.deleteHistory(this);
  }

  String writeUpdateInfoDisplayString({bool useDefaultPreamble = true});
}