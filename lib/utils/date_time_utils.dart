class DateTimeUtils{
  static final DateTimeUtils _instance = DateTimeUtils._internal();

  DateTimeUtils._internal();

  factory DateTimeUtils(){
    return _instance;
  }

  String mapDateTimeToDatabaseString(DateTime dateTime){
    String dateTimeString = "${dateTime.year}-${dateTime.month}-${dateTime.day} ";
    dateTimeString += "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
    return dateTimeString;
  }

  String mapDateTimeToDisplayString(DateTime dateTime, {
    bool shouldDisplaySeconds = false, String dateTimeSeparator = " - ", String dateUnitSeparator = "/", String timeUnitSeparator = ":"
  }){
    String dateTimeString =
      "${dateTime.year}$dateUnitSeparator${dateTime.month.toString().padLeft(2, "0")}$dateUnitSeparator${dateTime.day.toString().padLeft(2, "0")}";
    dateTimeString += " $dateTimeSeparator ${dateTime.hour.toString().padLeft(2, "0")}$timeUnitSeparator${dateTime.minute.toString().padLeft(2, "0")}";
    if(shouldDisplaySeconds){
      dateTimeString += "$timeUnitSeparator${dateTime.second.toString().padLeft(2, "0")}";
    }
    return dateTimeString;
  }

  String mapDateToDatabaseString(DateTime dateTime){
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  String mapDateToDisplayString(DateTime date){
    return "${date.year}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
  }

  DateTime mapDatabaseStringToDateTime(String databaseString){
    List<String> dateTimeList = databaseString.split(' '), dateList = dateTimeList[0].split('-'), timeList = dateTimeList[1].split(':');
    return DateTime(
      int.parse(dateList[0]),
      int.parse(dateList[1]),
      int.parse(dateList[2]),
      int.parse(timeList[0]),
      int.parse(timeList[1]),
      int.parse(timeList[2]),
    );
  }

  DateTime mapStringToDate(String dateTimeString){
    try{
      List<String> dateStringSections = dateTimeString.split("-");
      List<int> dateIntSections = [];
      for(String stringSection in dateStringSections){
        dateIntSections.add(int.parse(stringSection));
      }
      return DateTime(dateIntSections[0], dateIntSections[1], dateIntSections[2]);
    } on Exception catch (e){
      throw Exception("There was an error when converting a String to Datetime: $e.");
    }
  }
}