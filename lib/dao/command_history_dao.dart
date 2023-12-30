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

  void testing() async {
    List<Map<String, dynamic>> test = await _database.rawQuery(
      '''SELECT commands.id_type, commands.nm_command, base.nm_target, base.dt_history_creation, base.ds_update_info
        FROM command_history AS base
        INNER JOIN command_history_command AS commands ON base.id_used_command = commands.id_command_history_command;'''
    );
    print(test);
  }
}