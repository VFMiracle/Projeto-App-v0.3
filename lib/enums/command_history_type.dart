enum CommandHistoryType{
  cronometerEditing(id: 1, description: "Cronometer Edits"),
  cronometerInteraction(id: 2, description: "Cronometer Interactions"),
  timeRecordEditing(id: 3, description: "Time Record Edits");

  const CommandHistoryType({required this.id, required this.description});

  final int id;
  final String description;
}