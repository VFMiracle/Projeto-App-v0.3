enum CronometerInteractionCommand{
  start(commandId: 4, name: "Start", updateInfoType: int),
  pause(commandId: 5, name: "Pause", updateInfoType: int),
  resetAndSaveTime(commandId: 6, name: "Reset and Save Time", updateInfoType: int),
  resetAndDeleteTime(commandId: 7, name: "Reset and Delete Time", updateInfoType: int);

  const CronometerInteractionCommand({required this.commandId, required this.name, required this.updateInfoType});

  final int commandId;
  final String name;
  final Type? updateInfoType;

  static CronometerInteractionCommand? getCommandById(int id){
    for(CronometerInteractionCommand value in CronometerInteractionCommand.values){
      if(value.commandId == id){
        return value;
      }
    }
    return null;
  }
}