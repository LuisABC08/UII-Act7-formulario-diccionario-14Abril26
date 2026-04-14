import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Inicio - Control Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal.shade50,
                  border: Border.all(color: Colors.teal.shade200, width: 3)
                ),
                child: const Icon(
                  Icons.business_center,
                  size: 100,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 50),
              
              // Botón de Captura
              SizedBox(
                width: 300,
                height: 65,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/captura');
                  },
                  icon: const Icon(Icons.person_add_rounded, size: 30),
                  label: const Text('Capturar Empleados', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    shadowColor: Colors.teal.withOpacity(0.5)
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Botón de Ver Empleados
              SizedBox(
                width: 300,
                height: 65,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/ver');
                  },
                  icon: const Icon(Icons.people_alt_rounded, size: 30),
                  label: const Text('Ver Empleados', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black26
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
