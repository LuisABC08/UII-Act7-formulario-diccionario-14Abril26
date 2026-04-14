import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleadosScreen extends StatefulWidget {
  const CapturaEmpleadosScreen({super.key});

  @override
  State<CapturaEmpleadosScreen> createState() => _CapturaEmpleadosScreenState();
}

class _CapturaEmpleadosScreenState extends State<CapturaEmpleadosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _puestoController = TextEditingController();
  final _salarioController = TextEditingController();

  void _guardarFormulario() {
    if (_formKey.currentState!.validate()) {
      AgenteGuardarDatos.guardarEmpleado(
        nombre: _nombreController.text,
        puesto: _puestoController.text,
        salario: double.parse(_salarioController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Empleado guardado con éxito', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal,
        ),
      );

      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();

      // Refrescar el estado para actualizar el ID autoincremental mostrado
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Empleado'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.person_add_alt_1, size: 64, color: Colors.teal),
                      const SizedBox(height: 16),
                      const Text(
                        'Datos del Empleado',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.teal),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Primer dato: ID (Autonumérico y solo lectura)
                      TextFormField(
                        key: ValueKey(AgenteGuardarDatos.siguienteId),
                        initialValue: AgenteGuardarDatos.siguienteId.toString(),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'ID (Autonumérico)',
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Segundo dato: Nombre
                      TextFormField(
                        controller: _nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Tercer dato: Puesto
                      TextFormField(
                        controller: _puestoController,
                        decoration: InputDecoration(
                          labelText: 'Puesto',
                          prefixIcon: const Icon(Icons.work),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un puesto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Cuarto dato: Salario
                      TextFormField(
                        controller: _salarioController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Salario',
                          prefixIcon: const Icon(Icons.attach_money),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa un salario';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Por favor ingresa un número válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _guardarFormulario,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          elevation: 5,
                        ),
                        child: const Text(
                          'GUARDAR DATOS',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
