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
          '''INSERT INTO command_history(id_used_command, id_command_type, nm_target, dt_history_creation, ds_update_info) VALUES
            (4, 2, "Arstuncio", "2024-2-12 4:21:50", "0"), (4, 2, "Bruxeval", "2024-2-12 6:1:2", "0"), (4, 2, "Surgag", "2024-2-12 4:43:32", "100"),
            (5, 2, "Bruxeval", "2024-2-12 6:22:2", "1260"), (4, 2, "Energumino", "2024-2-12 7:3:12", "0"), (5, 2, "Energumino", "2024-2-12 7:5:42", "150"),
            (6, 2, "Energumino", "2024-2-12 7:7:1", "150"), (4, 2, "Pilvocu", "2024-2-12 5:8:58", "2000"), (5, 2, "Pilvocu", "2024-2-12 5:14:0", "2302"),
            (7, 2, "Pilvocu", "2024-2-12 6:0:3", "2302");'''
        );
      },
      version: 21,
    );
    CronometerDAO.initialize(_database);
    TimeRecordDAO.initialize(_database);
    CommandHistoryDAO.initialize(_database);
  }
}