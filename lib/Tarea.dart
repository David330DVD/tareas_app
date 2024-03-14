


class Tarea  {
  int id;
  String nombre;
  bool completada;
  DateTime fechaPrevista;
  DateTime? fechaRealizada;

  Tarea({required this.id,required this.nombre, this.completada = false, required this.fechaPrevista , this.fechaRealizada});

  static fromJson(tarea) {
    return Tarea(
      id: tarea['id'],
      nombre: tarea['name'],
      completada: tarea['completed'] == 1 ? true : false,
      fechaPrevista: DateTime.parse(tarea['due_date']),
      fechaRealizada: tarea['completion_date'] != null ? DateTime.parse(tarea['completion_date']) : null,
    );

  }


}