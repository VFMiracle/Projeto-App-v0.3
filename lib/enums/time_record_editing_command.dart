enum TimeRecordEditingCommand{
  create(commandId: 8, name: "Create", updateInfoType: int),
  delete(commandId: 9, name: "Delete", updateInfoType: int),
  updateName(commandId: 10, name: "Update Name", updateInfoType: String),
  updateValue(commandId: 11, name: "Update Value", updateInfoType: Map);

  const TimeRecordEditingCommand({required this.commandId, required this.name, required this.updateInfoType});

  final int commandId;
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