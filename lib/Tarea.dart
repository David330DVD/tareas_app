


class Tarea  {
  int id;
  String nombre;
  bool completada;
  DateTime fechaPrevista;
  DateTime? fechaRealizada;

  Tarea({required this.id,required this.nombre, this.completada = false, required this.fechaPrevista});
  
}