enum CronometerEditingCommand{
  create(name: "Create", updateInfoType: null),
  updateName(name: "Update Name", updateInfoType: String),
  delete(name: "Delete", updateInfoType: null);

  const CronometerEditingCommand({required this.name, required this.updateInfoType});

  final String name;
  final Type? updateInfoType;

  static CronometerEditingCommand? getCommandByName(String commandName){
    for(CronometerEditingCommand value in CronometerEditingCommand.values){
      if(value.name == commandName){
        return value;
      }
    }
    return null;
  }
}