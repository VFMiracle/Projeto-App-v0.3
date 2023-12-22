enum CommandHistoryType{
  cronometerEditing(description: "Cronometer Edits"),
  cronometerInteraction(description: "Cronometer Interactions"),
  timeRecordEditing(description: "Time Record Edits");

  const CommandHistoryType({required this.description});

  final String description;
}