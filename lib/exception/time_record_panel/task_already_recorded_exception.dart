class TaskAlreadyRecordedException{
  final String? _customMessage;
  final String _standardMessage = "A task with this name for this day already exists.";

  String get message => _customMessage ?? _standardMessage;

  TaskAlreadyRecordedException({String? customMessage}) : _customMessage = customMessage;
}