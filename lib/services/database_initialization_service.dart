import 'package:path/path.dart';
import 'package:projeto_time_counter/dao/command_history_dao.dart';
import 'package:projeto_time_counter/dao/cronometer_dao.dart';
import 'package:projeto_time_counter/dao/time_record_dao.dart';
import 'package:sqflite/sqflite.dart';

//DESC: Manages the general state of the Database.
class DatabaseInitializationService{
  static const String _dbName = "projeto_time_counter.db";
  static final DatabaseInitializationService _dbManager = DatabaseInitializationService._internal();
  late final Database _database;

  DatabaseInitializationService._internal();

  factory DatabaseInitializationService() => _dbManager;

  Future<void> initialize() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (Database database, int versionNumber){
        database.execute(
          '''CREATE TABLE cronometer(
            id_cronometer INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            nm_cronometer TEXT NOT NULL
          );'''
        );
        database.execute(
          '''CREATE TABLE time_record(
            id_time_record INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            nm_task TEXT NOT NULL,
            nr_time_in_seconds INTEGER NOT NULL,
            dt_creation_date TEXT
          );'''
        );
        database.execute(
          '''CREATE TABLE command_history(
            id_command_history INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            id_used_command INTEGER NOT NULL,
            id_command_type INTEGER NOT NULL,
            nm_target TEXT NOT NULL,
            dt_history_creation TEXT NOT NULL,
            ds_update_info TEXT
          );'''
        );
      },
      onUpgrade: (Database database, int oldVersionNumber, int newVersionNumber) async{
        database.execute(
          '''DELETE FROM command_history;'''
        );
        database.execute(
          '''INSERT INTO command_history(id_used_command, id_command_type, nm_target, dt_history_creation, ds_update_info) VALUES (1, 1, "Bruxeval", "2024-2-1 15:5:0", NULL),
            (2, 1, "Bruxeval", "2024-2-1 20:12:22", "Grumadzul"), (4, 2, 'Grumadzul', "2023-12-18 19:55:20", "0"), (4, 2, 'Sei la', "2023-12-20 17:12:19", "100"),
            (5, 2, 'Grumadzul', "2023-12-18 20:1:0", "340"), (6, 2, 'Grumadzul', "2023-12-18 21:1:41", "340"),
            (8, 3, "Bruxeval", "2023-2-2 6:12:38", 'da_record_date:2024-2-2, in_initial_value:1200'),
            (9, 3, "Grumadzul", "2024-2-2 6:21:4", 'da_record_date:2024-2-2, in_delete_value:600'),
            (10, 3, "Arstuncio", "2024-2-2 6:41:24", 'da_record_date:2024-2-1, st_new_name:Grumadzul'),
            (11, 3, "Burxeval", "2023-2-2 7:2:51", 'da_record_date:2024-2-2, in_oldValue:1200, in_newValue:4500');'''
        );
      },
      version: 17,
    );
    CronometerDAO.initialize(_database);
    TimeRecordDAO.initialize(_database);
    CommandHistoryDAO.initialize(_database);
  }
}