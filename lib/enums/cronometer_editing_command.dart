enum CronometerEditingCommand{
  create(name: "Create"),
  updateName(name: "Update Name"),
  delete(name: "Delete");

  const CronometerEditingCommand({required this.name});

  final String name;
}