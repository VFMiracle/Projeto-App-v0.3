class TaskAlreadyRecordedException{
  final String? _customMessage;
  final String _stndrMessage = "A task with this name for this day already exists.";

  String get message => _customMessage ?? _stndrMessage;

  TaskAlreadyRecordedException({String? customMessage}) : _customMessage = customMessage;
}