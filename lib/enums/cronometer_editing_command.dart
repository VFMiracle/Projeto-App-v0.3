enum CronometerEditingCommand{
  create(commandId: 1, name: "Create", updateInfoType: null),
  updateName(commandId: 2, name: "Update Name", updateInfoType: String),
  delete(commandId: 3, name: "Delete", updateInfoType: null);

  const CronometerEditingCommand({required this.commandId, required this.name, required this.updateInfoType});

  final int commandId;
  final String name;
  final Type? updateInfoType;

  static CronometerEditingCommand? getCommandById(int id){
    for(CronometerEditingCommand value in CronometerEditingCommand.values){
      if(value.commandId == id){
        return value;
      }
    }
    return null;
  }
}