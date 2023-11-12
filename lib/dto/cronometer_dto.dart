class CronometerDTO{
  final int? _id;
  final String _name;

  int? get idPrprt => _id;

  String? get namePrprt => _name;

  CronometerDTO(int id, String name) : _id = id, _name = name;
}