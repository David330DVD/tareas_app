import 'package:get/get.dart';
import 'package:tareas_app/tarea.dart';
import 'package:tareas_app/TaskService.dart';

class HomeController extends GetxController {
  List<Tarea> tasks = [];
  List<Tarea> completedTasks = [];

  @override
  void onInit() {
    super.onInit();
    TaskService().obtenerTareas().then((value) {
      tasks = value;
      update();
    });
  }

  void addTask(String taskName, DateTime dueDate) {
    TaskService().crearTarea(taskName, dueDate);

    TaskService().obtenerTareas().then((value) {
      tasks.add(value.last);
      update();
    });
    update();
  }

  void completeTask(int taskId) {
    final taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex].completada = tasks[taskIndex].completada ? false : true;
      if (tasks[taskIndex].completada) {
        tasks[taskIndex].fechaRealizada = DateTime.now();
        completedTasks.add(tasks[taskIndex]);
      } else {
        tasks[taskIndex].fechaRealizada = null;

        completedTasks.remove(tasks[taskIndex]);
      }
      update(); // Notificar a la interfaz de usuario que se han realizado cambios en los datos
    }
  }
}
