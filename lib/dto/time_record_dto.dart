class TimeRecordDTO{
  final int? _id, _countedTime;
  final String? _taskName;
  final DateTime? _creationDate;

  int? get id => _id;

  int? get countedTime => _countedTime;

  String? get taskName => _taskName;

  DateTime? get creationDate => _creationDate;

  TimeRecordDTO({int? id, int? countedTime, String? taskName, DateTime? creationDate}) : 
      _id = id, _countedTime = countedTime, _taskName = taskName, _creationDate = creationDate;
}