import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tareas_app/tarea.dart';

class TaskService {
  Future<void> crearTarea(String nombre, DateTime fechaCreacion) async {
    // URL de la API para crear una tarea
    String url = 'http://127.0.0.1:8000/api/tasks/add';

    // Cuerpo del JSON para crear la tarea
    Map<String, dynamic> tarea = {
      'name': nombre,
      'due_date': fechaCreacion.toIso8601String(),
      'completion_date': null,
      'completed': false
    };

    // Realizar la solicitud HTTP para crear la tarea
    try {
      // Realizar la solicitud POST
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tarea),
      );

      // Verificar si la solicitud fue exitosa (código de respuesta 201)
      if (response.statusCode == 201) {
        print('Tarea creada exitosamente');
      } else {
        print('Error al crear la tarea: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Obtener todas las tareas
  Future<List<Tarea>> obtenerTareas() async {
    // URL de la API para obtener todas las tareas
    String url = 'http://127.0.0.1:8000/api/tasks';

    try {
      // Realizar la solicitud GET
      var response = await http.get(Uri.parse(url));

      // Verificar si la solicitud fue exitosa (código de respuesta 200)
      if (response.statusCode == 200) {
        // Decodificar el cuerpo de la respuesta JSON
        List<dynamic> data = json.decode(response.body);

        // Crear una lista de Tarea y convertir cada elemento
        List<Tarea> tareas = [];
        for (var tareaData in data) {
          tareas.add(Tarea.fromJson(tareaData));
        }

        return tareas;
      } else {
        print('Error al obtener las tareas: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
