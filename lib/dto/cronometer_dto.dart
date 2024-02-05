class CronometerDTO{
  final int? _id;
  final String _name;

  int? get id => _id;

  String get name => _name;

  CronometerDTO(int id, String name) : _id = id, _name = name;
}