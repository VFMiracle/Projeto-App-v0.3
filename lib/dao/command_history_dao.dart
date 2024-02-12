import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
import 'package:projeto_time_counter/models/routes/cronometer_model.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:sqflite/sqflite.dart';

class CommandHistoryDAO{
  static final CommandHistoryDAO _instance = CommandHistoryDAO._internal();

  final String _tableName = "command_history";
  late final Database _database;

  CommandHistoryDAO._internal();

  factory CommandHistoryDAO() => _instance;

  static void initialize(Database database){
    _instance._database = database;
  }

  void deleteDbEntry(int commandHistoryId){
    _database.delete(
      _tableName,
      where: "id_command_history = ?",
      whereArgs: [commandHistoryId],
    );
  }

  Future<int> insertDbEntry(CommandHistoryDTO commandHistory) async {
    int commandHistoryId = 0;
    Map<String, dynamic> commandHistoryDbEntry = {"id_used_command": commandHistory.commandId, "id_command_type": commandHistory.type.id,
      "nm_target": commandHistory.targetName, "dt_history_creation": DateTimeUtils().mapDateTimeToDatabaseString(commandHistory.historyCreation),
      "ds_update_info": commandHistory.updateInfo};
    await _database.insert(
      _tableName,
      commandHistoryDbEntry,
    ).then((newCommandHistoryId) => commandHistoryId = newCommandHistoryId);
    return commandHistoryId;
  }

  Future<List<CommandHistoryDTO>> readDbEntriesByTypeAndDay(int commandHistoryTypeId, DateTime selDate) async {
    List<CommandHistoryDTO> commandHistories = [];
    List<Map<String, dynamic>> commandHistoriesMap = await _database.query(
      _tableName,
      where: "id_command_type = ? AND dt_history_creation LIKE ?",
      whereArgs: [commandHistoryTypeId, "${DateTimeUtils().mapDateToDatabaseString(selDate)}%"]
    );
    for(Map<String, dynamic> commandHistoryMap in commandHistoriesMap){
      commandHistories.add(CommandHistoryDTO(id: commandHistoryMap['id_command_history'], commandId: commandHistoryMap['id_used_command'],
        type: CommandHistoryType.getTypeById(commandHistoryMap['id_command_type'])!, targetName: commandHistoryMap['nm_target'],
        historyCreation: DateTimeUtils().mapDatabaseStringToDateTime(commandHistoryMap['dt_history_creation']),
        updateInfo: commandHistoryMap['ds_update_info']));
    }
    return commandHistories;
  }

  void readDbLastCronoIntrctEntry(CronometerModel cronometer) async {
    
  }
}