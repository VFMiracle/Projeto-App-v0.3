class TimeRecordDTO{
  final int? _id;
  final int _countedTime;
  final String _taskName;
  final DateTime _creationDate;

  int? get id => _id;

  int get countedTime => _countedTime;

  String get taskName => _taskName;

  DateTime get creationDate => _creationDate;

  TimeRecordDTO({int? id, required int countedTime, required String taskName, DateTime? creationDate}) : 
      _id = id, _countedTime = countedTime, _taskName = taskName, _creationDate = creationDate ?? DateTime.now();
}