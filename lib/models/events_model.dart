class EventModel {
  int? idEvento;
  String? dscEvento;
  String? fechaEvento;
  bool completado;

  EventModel(
      {this.idEvento,
      this.dscEvento,
      this.fechaEvento,
      required this.completado});

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        idEvento: map['idEvento'],
        dscEvento: map['dscEvento'],
        fechaEvento: map['fechaEvento'],
        completado: map['completado'] == 1 ? true : false);
  }
}
