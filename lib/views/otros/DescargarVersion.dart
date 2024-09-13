import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class DescargarVersion extends StatefulWidget {
  String nuevaVersion;
  DescargarVersion({super.key, required this.nuevaVersion});

  @override
  State<DescargarVersion> createState() => _DescargarVersionState();
}

class _DescargarVersionState extends State<DescargarVersion> {
  final url =
      "http://${dotenv.env['SERVER_URL']}${dotenv.env['PROJECT_PATH']}api-descargar-android-app";
  bool descargado = false;
  var progreso = "Presiona para iniciar la descarga";
  var ruta = "Sin ruta";
  @override
  void initState() {
    getPermission();
    super.initState();
  }

  //get storage permission
  void getPermission() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    await Permission.unknown.request();
    await Permission.requestInstallPackages.request();
  }

  Future<void> descargarArchivo() async {
    Dio dio = Dio();
    try {
      var dir = await getExternalStorageDirectory();
      ruta = "${dir?.path}/dotech_app_${widget.nuevaVersion}.apk";

      await dio.download(url, ruta, onReceiveProgress: (rec, total) {
        setState(() {
          progreso = "Descargando ${((rec / total) * 100).toStringAsFixed(0)}%";
        });
      });
    } catch (e) {
      if (kDebugMode) print(e);
    }

    setState(() {
      descargado = true;
      progreso = "Descarga completa";
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   // color: Colors.red.withOpacity(0.1),
        //   image: DecorationImage(
        //       image: AssetImage('assets/images/wallpaper.jpg'),
        //       fit: BoxFit.cover,
        //       opacity: 1),
        // ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/dot_living.png',
              width: isSmallScreen ? 100 : 200,
              height: isSmallScreen ? 100 : 200,
            ),
            const Text("DotLiving",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.lightBlue,
                )
                // style: GoogleFonts.indieFlower(
                //   textStyle: const TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 40,
                //       color: Colors.white),
                // ),
                ),
            const SizedBox(
              height: 10.0,
            ),
            Text("Versión ${widget.nuevaVersion}",
                style: const TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
            const SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              onPressed: () {
                descargarArchivo();
              },
              color: Colors.purple,
              textColor: Colors.white,
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.download,
                size: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(progreso,
                style: const TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)),
            const SizedBox(
              height: 20,
            ),
            _descargaCompleta()
          ],
        )),
      ),
    );
  }

  Widget _descargaCompleta() {
    if (descargado) {
      return ElevatedButton(
        onPressed: () async {
          if (await File(ruta).exists()) {
            OpenFile.open(ruta);
          } else {
            print("No se encontró la ruta");
          }
        },
        child: const Text(
          "Ejecutar instalador",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
