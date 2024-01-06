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

  Future<List<CommandHistoryDTO>> readDbEntriesByCommandType(int commandHistoryTypeId) async {
    List<CommandHistoryDTO> commandHistories = [];
    List<Map<String, dynamic>> commandHistoriesMap = await _database.rawQuery(
      '''SELECT base.id_command_history, commands.id_type, commands.nm_command, base.nm_target, base.dt_history_creation, base.ds_update_info
        FROM command_history AS base
        INNER JOIN command_history_command AS commands ON base.id_used_command = commands.id_command_history_command
        WHERE commands.id_type = ?;''',
        [commandHistoryTypeId]
    );
    for(Map<String, dynamic> commandHistoryMap in commandHistoriesMap){
      commandHistories.add(CommandHistoryDTO(id: commandHistoryMap['id_command_history'], command: commandHistoryMap['nm_command'],
        targetName: commandHistoryMap['nm_target'], type: CommandHistoryType.getTypeById(commandHistoryMap['id_type'])!,
        creationDateTime: DateTimeUtils().mapDatabaseStringToDateTime(commandHistoryMap['dt_history_creation']), updateInfo: commandHistoryMap['ds_update_info']));
    }
    return commandHistories;
  }

  void testing() async {
    List<Map<String, dynamic>> test = await _database.rawQuery(
      '''SELECT base.id_command_history, commands.id_type, commands.nm_command, base.nm_target, base.dt_history_creation, base.ds_update_info
        FROM command_history AS base
        INNER JOIN command_history_command AS commands ON base.id_used_command = commands.id_command_history_command;'''
    );
    print(int.parse(test[1]['ds_update_info']));
  }
}