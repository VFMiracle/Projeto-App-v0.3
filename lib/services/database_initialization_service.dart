import 'package:path/path.dart';
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
          )'''
        );
        database.execute(
          '''CREATE TABLE time_record(
            id_time_record INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            nm_task TEXT NOT NULL,
            nr_time_in_seconds INTEGER NOT NULL,
            dt_creation_date TEXT
          )'''
        );
      },
      onUpgrade: (Database database, int oldVersionNumber, int newVersionNumber) async{
        return database.execute(''' ''');
      },
      version: 1,
    );
    CronometerDAO.initialize(_database);
    TimeRecordDAO.initialize(_database);
  }
}