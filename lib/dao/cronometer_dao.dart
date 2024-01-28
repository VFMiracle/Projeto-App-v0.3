import 'package:projeto_time_counter/dto/cronometer_dto.dart';
import 'package:sqflite/sqflite.dart';

//DESC: Manages the Database's Cronometer Entries.
class CronometerDAO{
  static final CronometerDAO _instance = CronometerDAO._internal();
  
  final String _tableName = "cronometer";
  late final Database _database;

  CronometerDAO._internal();

  factory CronometerDAO() => _instance;

  static void initialize(Database database){
    _instance._database = database;
  }

  void deleteDbEntry(int crnmtrId){
    _database.delete(
      _tableName,
      where: "id_cronometer = ?",
      whereArgs: [crnmtrId]
    );
  }

  //INFO: This function can't recieve a direct Cronometer Model because such Model can't exist since it would need it's Id, unique both in the code execution and in the
  //  database. As such, a Database Entry needs to be made before a Model of that Entry can exist.
  Future<int> insertDbEntry(CronometerDTO cronometer) async {
    int newCrnmtrId = 0;
    Map<String, dynamic> cronometerDbEntry = {"nm_cronometer": cronometer.namePrprt};
    await _database.insert(
      _tableName,
      cronometerDbEntry,
    ).then((int crnmtrId) => newCrnmtrId = crnmtrId);
    return newCrnmtrId;
  }

  Future<List<CronometerDTO>> readAllDbEntries() async {
    List<CronometerDTO> cronometers = [];
    List<Map<String, dynamic>> crnmtrDbEntries = await _database.query(
      _tableName
    );
    for(Map<String, dynamic> crnmtrDbEntry in crnmtrDbEntries){
      cronometers.add(CronometerDTO(crnmtrDbEntry["id_cronometer"], crnmtrDbEntry["nm_cronometer"]));
    }
    return cronometers;
  }

  void updateDbEntry(CronometerDTO cronometer){
    Map<String, dynamic> crnmtrDbEntryUpdt = {"nm_cronometer": cronometer.namePrprt};
    _database.update(
      _tableName,
      crnmtrDbEntryUpdt,
      where: "id_cronometer = ?",
      whereArgs: [cronometer.idPrprt],
    );
  }
}