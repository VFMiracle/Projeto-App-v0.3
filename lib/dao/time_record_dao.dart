import 'package:projeto_time_counter/dto/time_record_dto.dart';
import 'package:projeto_time_counter/utils/date_time_utils.dart';
import 'package:sqflite/sqflite.dart';

class TimeRecordDAO{
  static final TimeRecordDAO _instance = TimeRecordDAO._internal();
  
  final String _tableName = "time_record";
  late final Database _database;

  TimeRecordDAO._internal();

  factory TimeRecordDAO() => _instance;

  static void initialize(Database database){
    _instance._database = database;
  }

  void deleteDbEntry(int timeRecordId){
    _database.delete(
      _tableName,
      where: "id_time_record = ?",
      whereArgs: [timeRecordId],
    );
  }

  Future<int> insertDbEntry(TimeRecordDTO timeRecord) async {
    int newTimeRecordId = 0;
    Map<String, dynamic> timeRecordDbEntry = {"nm_task": timeRecord.taskName, "nr_time_in_seconds": timeRecord.countedTime,
      "dt_creation_date": DateTimeUtils().mapDateToDatabaseString(timeRecord.creationDate ?? DateTime.now())};
    await _database.insert(
      _tableName,
      timeRecordDbEntry,
    ).then((int timeRecordId) => newTimeRecordId = timeRecordId);
    return newTimeRecordId;
  }

  Future<List<TimeRecordDTO>> readDbEntriesByDay(DateTime crtnDate) async {
    String crtnDateString = DateTimeUtils().mapDateToDatabaseString(crtnDate);
    List<TimeRecordDTO> timeRecords = [];
    
    List<Map<String, dynamic>> timeRecordsMap = await _database.query(
      _tableName,
      where: "dt_creation_date = ?",
      whereArgs: [crtnDateString],
    );
    for(Map<String, dynamic> timeRecordMap in timeRecordsMap){
      timeRecords.add(TimeRecordDTO(id: timeRecordMap["id_time_record"], taskName: timeRecordMap["nm_task"], countedTime: timeRecordMap["nr_time_in_seconds"],
        creationDate: crtnDate));
    }
    return timeRecords;
  }

  Future<TimeRecordDTO?> readDbEntry(String taskName, DateTime crtnDate) async {
    String crtnDateString = DateTimeUtils().mapDateToDatabaseString(crtnDate);

    List<Map<String, dynamic>> queryResult = await _database.query(
      _tableName,
      where: "nm_task = ? AND dt_creation_date = ?",
      whereArgs: [taskName, crtnDateString]
    );
    if(queryResult.isNotEmpty){
      DateTime parsedDateTime = DateTimeUtils().mapStringToDate(queryResult[0]["dt_creation_date"]);
      return TimeRecordDTO(id: queryResult[0]["id_time_record"], countedTime: queryResult[0]["nr_time_in_seconds"], taskName: queryResult[0]["nm_task"],
          creationDate: parsedDateTime);
    }else{
      return null;
    }
  }

  void updateDbEntry(TimeRecordDTO update) async {
    Map<String, dynamic> updateValues = {"nm_task": update.taskName, "nr_time_in_seconds": update.countedTime};
    await _database.update(
      _tableName,
      updateValues,
      where: "id_time_record = ?",
      whereArgs: [update.id]
    );
  }
}