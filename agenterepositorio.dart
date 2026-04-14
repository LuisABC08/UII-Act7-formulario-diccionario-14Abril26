import 'dart:io';

/// Agente de control de versiones y repositorio de GitHub
/// Funciona de forma interactiva en la terminal
void main(List<String> arguments) async {
  print('\n===================================================');
  print('🤖 Agente Repositorio - Publicador hacia GitHub');
  print('===================================================\n');

  // 1. Verificar si git está instalado
  var result = await Process.run('git', ['--version']);
  if (result.exitCode != 0) {
    print('❌ Error: Git no parece estar instalado en tu sistema o no está en el PATH.');
    print('Por favor, instala git para poder utilizar este agente.');
    return;
  }

  // 2. Comprobar si ya existe un repositorio git inicializado localmente
  bool gitYaInicializado = Directory('.git').existsSync();
  if (!gitYaInicializado) {
    print('📦 Inicializando repositorio local vacío...');
    await ejecutarComandoSilencioso('git', ['init']);
  } else {
    print('📦 Repositorio local de Git detectado.');
  }

  // 3. Establecer rama base 'main'
  await ejecutarComandoSilencioso('git', ['branch', '-M', 'main']);

  // 4. Preguntar y establecer repositorio remoto (origin)
  var remoteResult = await Process.run('git', ['remote', '-v']);
  String outputRemoto = remoteResult.stdout.toString();
  
  if (outputRemoto.contains('origin')) {
    print('\n🔗 Ya existe un remoto "origin" configurado:');
    print(outputRemoto.trim());
    String urlRepo = preguntar('¿Deseas sobreescribir el enlace de GitHub? (deja en blanco para mantener el actual, o pega el nuevo link):', obligatorio: false);
    if (urlRepo.isNotEmpty) {
      await ejecutarComandoSilencioso('git', ['remote', 'set-url', 'origin', urlRepo]);
      print('✅ Remoto "origin" actualizado.');
    }
  } else {
    String urlRepo = preguntar('\n🔗 Introduce el enlace de tu repositorio vacío en GitHub (ej. https://github.com/usuario/repo.git):', obligatorio: true);
    await ejecutarComandoSilencioso('git', ['remote', 'add', 'origin', urlRepo]);
    print('✅ Remoto "origin" agregado.');
  }

  // 5. Agregando los archivos (equivalente a git add .)
  print('\n📂 Agregando archivos del proyecto al área de preparación (git add .)...');
  await ejecutarComandoSilencioso('git', ['add', '.']);

  // 6. Preguntar mensaje de commit
  String mensajeCommit = preguntar('\n📝 Introduce el mensaje para el commit:', obligatorio: true);
  await ejecutarComandoSilencioso('git', ['commit', '-m', mensajeCommit]);

  // 7. Preguntar si se enviará a otra rama o a la principal
  String rama = preguntar('\n🌿 ¿A qué rama deseas enviarlo? (Presiona Enter para usar la rama por default: "main"):', obligatorio: false);
  if (rama.isEmpty) {
    rama = 'main';
  } else if (rama != 'main') {
    // Si la rama es diferente a main, intentamos crearla o cambiarnos a ella
    var checkoutRes = await Process.run('git', ['checkout', '-b', rama]);
    if (checkoutRes.exitCode != 0) {
      // Si ya existe, simplemente nos cambiamos a ella
      await ejecutarComandoSilencioso('git', ['checkout', rama]);
    }
  }

  // 8. Hacer Push
  print('\n🚀 Subiendo archivos a GitHub en la rama "$rama"... (esto puede tomar varios segundos)');
  
  // Para que el push imprima en el flujo estándar y el usuario lo vea mejor:
  var processPush = await Process.start('git', ['push', '-u', 'origin', rama]);
  
  // Imprimir stdout y stderr en tiempo real
  await stdout.addStream(processPush.stdout);
  await stderr.addStream(processPush.stderr);

  var exitCode = await processPush.exitCode;
  
  if (exitCode == 0) {
    print('\n✨ ¡ÉXITO! Proyecto subido exitosamente a Github en la rama "$rama".');
    print('Puedes re-utilizar este agente en cualquiera de tus proyectos copiando "agenterepositorio.dart" y ejecutándolo.');
  } else {
    print('\n❌ Hubo un error al subir los archivos.');
    print('Posibles causas:');
    print('- No tienes internet.');
    print('- La URL del repositorio es incorrecta.');
    print('- Existen cambios en GitHub que no tienes localmente (necesitas hacer pull primero).');
    print('- No estás autenticado en Git.');
  }
  print('\n===================================================');
}

/// Helper para realizar preguntas interactivas en terminal
String preguntar(String prompt, {bool obligatorio = false}) {
  while (true) {
    print(prompt);
    stdout.write('>> ');
    String? input = stdin.readLineSync();
    if (input != null) {
      input = input.trim();
      if (obligatorio && input.isEmpty) {
        print('⚠️  Este campo es obligatorio. Intenta de nuevo.');
      } else {
        return input;
      }
    } else {
      // Input es nulo típicamente si el usuario aborta (Ctrl+C o EOF)
      exit(1); 
    }
  }
}

/// Helper para ejecutar comandos tras bambalinas
Future<void> ejecutarComandoSilencioso(String comando, List<String> argumentos) async {
  var resultado = await Process.run(comando, argumentos);
  if (resultado.exitCode != 0) {
    // Ignoramos el error "nothing to commit" para no asustar al usuario
    if (!resultado.stdout.toString().contains('nothing to commit') &&
        !resultado.stderr.toString().contains('nothing to commit')) {
      print('⚠️ Advertencia ejecutando "$comando ${argumentos.join(' ')}":');
      print(resultado.stderr.toString().isEmpty ? resultado.stdout : resultado.stderr);
    }
  }
}
