import 'package:projeto_time_counter/dto/command_history_dto.dart';
import 'package:projeto_time_counter/enums/command_history_type.dart';
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

  Future<CommandHistoryDTO?> readDbLastCronoIntrctEntry(String cronometerName) async {
    List<Map<String, dynamic>> cronoIntrctsMap = await _database.query(
      _tableName,
      where: "id_command_type = ? AND dt_history_creation LIKE ? AND nm_target LIKE ?",
      whereArgs: [2, "${DateTimeUtils().mapDateToDatabaseString(DateTime.now())}%", cronometerName],
      orderBy: "id_command_history DESC",
      limit: 1,
    );
    if(cronoIntrctsMap.isNotEmpty){
      return CommandHistoryDTO(
        id: cronoIntrctsMap[0]["id_command_history"],
        commandId: cronoIntrctsMap[0]["id_used_command"],
        type: CommandHistoryType.getTypeById(cronoIntrctsMap[0]["id_command_type"])!,
        targetName: cronoIntrctsMap[0]["nm_target"],
        historyCreation: DateTimeUtils().mapDatabaseStringToDateTime(cronoIntrctsMap[0]["dt_history_creation"]),
        updateInfo: cronoIntrctsMap[0]["ds_update_info"]
      );
    }
    return null;
  }
}