import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas_app/Main/home_controller.dart';
import 'package:tareas_app/SecondPage/SecondRoute.dart';
import 'package:tareas_app/tarea.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  late final List<Tarea> tareasCompletas;

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    tareasCompletas = controller.completedTasks;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager Page'),
        backgroundColor: const Color.fromARGB(255, 188, 143, 240),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => Center(
          child: Column(
            children: [
              if (controller.tasks.isEmpty || controller.tasks.where((task) => !task.completada).isEmpty)
                const Text("No hay tareas pendientes")
              else
                Text(
                    "Tareas Pendientes ${controller.tasks.where((task) => !task.completada).length}"),
              Text("Tareas Completas: ${controller.completedTasks.length}"),
              IconButton(
                onPressed: () => Get.to(SecondRoute(),
                    arguments: {"tareasCompletas": controller.completedTasks}),
                icon:
                    const Icon(Icons.open_in_new, color: Colors.blue, size: 28),
              ),
              Expanded(
                child: ListView(
                  children: controller.tasks
                      .map(
                        (tarea) => ListTile(
                          leading: tarea.completada
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.check_circle,
                                  color: Colors.red),
                          title: Text(tarea.nombre),
                          subtitle: Text("ID: ${tarea.id}     "
                              "Fecha prevista: ${(tarea.fechaPrevista)} ${tarea.fechaRealizada != null ? "      Fecha realizada: ${(tarea.fechaRealizada!)}" : ""}"),
                          

                          trailing: IconButton(
                            onPressed: () {
                              controller.completeTask(tarea.id);
                            },
                            
                            icon: tarea.completada
                                ? const Icon(Icons.clear_outlined)
                                : const Icon(Icons.check),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 69, 79, 223),
        tooltip: 'Add Task',
        onPressed: () {
          _mostrarDialogo(context);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _mostrarDialogo(BuildContext context) {
    TextEditingController controller = TextEditingController();
    DateTime fecha = DateTime.now();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nueva Tarea"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Introduce la tarea"),
          ),
          actions: [
            IconButton(
              onPressed: () {
                seleccionarFecha(context).then((value) {
                  fecha = value!;
                });
              },
              icon: const Icon(Icons.calendar_today),
            ),
            TextButton(
              onPressed: () {
                Get.find<HomeController>().addTask(controller.text, fecha);
                Navigator.of(context).pop();
              },
              child: const Text("Aceptar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> seleccionarFecha(BuildContext context) async {
    DateTime? selectedDate;
    DateTime? fecha;
    TimeOfDay? hora;
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 3),
    ).then((value) {
      fecha = value;
    });
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      hora = value;
    });
    if (fecha != null && hora != null) {
      selectedDate = DateTime(
          fecha!.year, fecha!.month, fecha!.day, hora!.hour, hora!.minute);
    }
    print(selectedDate);
    return selectedDate;
  }
}
