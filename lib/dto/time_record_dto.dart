class TimeRecordDTO{
  final int? _id, _countedTime;
  final String? _taskName;
  final DateTime? _crtnDate;

  int? get id => _id;

  int? get countedTime => _countedTime;

  String? get taskName => _taskName;

  DateTime? get crtnDate => _crtnDate;

  TimeRecordDTO({int? id, int? countedTime, String? taskName, DateTime? crtnDate}) : _id = id, _countedTime = countedTime, _taskName = taskName, _crtnDate = crtnDate;
}