import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatefulWidget {
  const VerEmpleadosScreen({super.key});

  @override
  State<VerEmpleadosScreen> createState() => _VerEmpleadosScreenState();
}

class _VerEmpleadosScreenState extends State<VerEmpleadosScreen> {
  @override
  Widget build(BuildContext context) {
    // Convertir los valores del diccionario en una lista
    final empleados = datosEmpleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: empleados.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 20),
                    Text(
                      'No hay empleados registrados.',
                      style: TextStyle(fontSize: 20, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: empleados.length,
                itemBuilder: (context, index) {
                  final empleado = empleados[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    shadowColor: Colors.teal.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      child: ListTile(
                        leading: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal.shade100,
                            border: Border.all(color: Colors.teal, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              'ID\n${empleado.id}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12, color: Colors.teal),
                            ),
                          ),
                        ),
                        title: Text(
                          empleado.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.work_outline, size: 18, color: Colors.teal),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      empleado.puesto,
                                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.attach_money, size: 18, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text(
                                    empleado.salario.toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
