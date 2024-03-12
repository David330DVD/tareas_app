import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tareas_app/tarea.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(home: SecondRoute()));
}

class SecondRoute extends StatelessWidget {
  late final Tarea task;
  late final List<Tarea> tareasCompletas;

  SecondRoute({super.key});
  @override
  Widget build(context) {
    tareasCompletas = Get.arguments["tareasCompletas"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Lista tareas completas"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tareas Completas: ${tareasCompletas.length}",
                style: const TextStyle(fontSize: 20)),
            Expanded(
                child: ListView(
                    children: tareasCompletas
                        .map((tarea) => ListTile(
                              leading: const Icon(Icons.check_circle,
                                  color: Colors.green),
                              title: Text(tarea.nombre),
                              subtitle: Text(
                                  "Fecha prevista: ${(tarea.fechaPrevista)} ${tarea.fechaRealizada != null ? "      Fecha realizada: ${(tarea.fechaRealizada!)}" : ""}"),
                            ))
                        .toList()))
          ],
        ),
      ),
    );
  }
}

