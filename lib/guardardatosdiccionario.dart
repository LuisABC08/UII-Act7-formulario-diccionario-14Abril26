import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class AgenteGuardarDatos {
  static int siguienteId = 1;

  static void guardarEmpleado({
    required String nombre,
    required String puesto,
    required double salario,
  }) {
    // Generar el siguiente id autoincremental
    Empleado nuevoEmpleado = Empleado(
      id: siguienteId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardar en el diccionario global
    datosEmpleado[siguienteId] = nuevoEmpleado;
    
    // Incrementar el ID autonumérico
    siguienteId++;
  }
}
