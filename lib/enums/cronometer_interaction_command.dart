enum CronometerInteractionCommand{
  start(name: "Start", updateInfoType: int),
  pause(name: "Pause", updateInfoType: int),
  resetAndSaveTime(name: "Reset and Save Time", updateInfoType: int),
  resetAndDeleteTime(name: "Reset and Delete Time", updateInfoType: int);

  const CronometerInteractionCommand({required this.name, required this.updateInfoType});

  final String name;
  final Type? updateInfoType;

  static CronometerInteractionCommand? getCommandByName(String commandName){
    for(CronometerInteractionCommand value in CronometerInteractionCommand.values){
      if(value.name == commandName){
        return value;
      }
    }
    return null;
  }
}