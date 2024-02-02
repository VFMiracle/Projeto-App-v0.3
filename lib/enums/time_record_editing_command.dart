enum TimeRecordEditingCommand{
  create(commandId: 8, name: "Create", updateInfoType: Map),
  delete(commandId: 9, name: "Delete", updateInfoType: Map),
  updateName(commandId: 10, name: "Update Name", updateInfoType: Map),
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