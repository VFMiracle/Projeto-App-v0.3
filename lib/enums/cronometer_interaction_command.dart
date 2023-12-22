enum CronometerInteractionCommand{
  start(name: "Start"),
  pause(name: "Pause"),
  resetAndSaveTime(name: "Reset and Save Time"),
  resetAndDeleteTime(name: "Reset and Delete Time");

  const CronometerInteractionCommand({required this.name});

  final String name;
}