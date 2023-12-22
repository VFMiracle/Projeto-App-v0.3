enum TimeRecordEditingCommand{
  create(name: "Create"),
  delete(name: "Delete"),
  updateName(name: "Update Name"),
  updateValue(name: "Update Value");

  const TimeRecordEditingCommand({required this.name});

  final String name;
}