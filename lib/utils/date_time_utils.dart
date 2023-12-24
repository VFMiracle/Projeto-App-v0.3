class DateTimeUtils{
  static final DateTimeUtils _instance = DateTimeUtils._internal();

  DateTimeUtils._internal();

  factory DateTimeUtils(){
    return _instance;
  }

  String mapDateTimeToDisplayString(DateTime dateTime, {bool shouldDisplaySeconds = false}){
    String dateTimeString = "${dateTime.year}/${dateTime.month.toString().padLeft(2, "0")}/${dateTime.day.toString().padLeft(2, "0")}" + 
      "- ${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";
    if(shouldDisplaySeconds){
      dateTimeString += ":${dateTime.second.toString().padLeft(2, "0")}";
    }
    return dateTimeString;
  }

  String mapDateToDatabaseString(DateTime dateTime){
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  String mapDateToDisplayString(DateTime date){
    return "${date.year}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
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