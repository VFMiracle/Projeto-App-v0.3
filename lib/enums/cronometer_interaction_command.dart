enum CronometerInteractionCommand{
  start(commandId: 4, name: "Start", updateInfoType: int, requiresInitialization: true),
  pause(commandId: 5, name: "Pause", updateInfoType: int, requiresInitialization: true),
  resetAndSaveTime(commandId: 6, name: "Reset and Save Time", updateInfoType: int),
  resetAndDeleteTime(commandId: 7, name: "Reset and Delete Time", updateInfoType: int);

  const CronometerInteractionCommand({required this.commandId, required this.name, required this.updateInfoType, this.requiresInitialization = false});

  final int commandId;
  final bool requiresInitialization;
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