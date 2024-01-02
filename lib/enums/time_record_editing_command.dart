enum TimeRecordEditingCommand{
  create(name: "Create", updateInfoType: int),
  delete(name: "Delete", updateInfoType: int),
  updateName(name: "Update Name", updateInfoType: String),
  updateValue(name: "Update Value", updateInfoType: Map);

  const TimeRecordEditingCommand({required this.name, required this.updateInfoType});

  final String name;
  final Type? updateInfoType;

  static TimeRecordEditingCommand? getCommandByName(String commandName){
    for(TimeRecordEditingCommand value in TimeRecordEditingCommand.values){
      if(value.name == commandName){
        return value;
      }
    }
    return null;
  }
}