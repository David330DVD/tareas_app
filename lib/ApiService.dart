import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<void> fetchSaludo() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/api/saludo'));


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data['message']);
      } else {
        print('Failed to load saludo: ${response.statusCode} ');
      }
    } catch (e) {
      print('Error al realizar la petición HTTP: $e');
    }
  }


Future<void> addTask(String taskName, DateTime dueDate) async {
  final url = Uri.parse('http://localhost:8000/api/tasks/add'); // Ajusta la URL según tu configuración

  try {
    final response = await http.post(
      url,
      body: json.encode({
        'name': taskName,
        'due_date': dueDate.toIso8601String(),
        'completed': false,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Tarea agregada exitosamente');
    } else {
      print('Error al agregar la tarea: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al realizar la petición HTTP: $e');
  }
}

}
