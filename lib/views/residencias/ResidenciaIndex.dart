import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../controllers/ResidenciaController.dart';
import '../../models/Residencia.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import 'ResidenciaMedios.dart';

class ResidenciaIndex extends StatefulWidget {
  String residencia_id = "";
  ResidenciaIndex({Key? key, required this.residencia_id}) : super(key: key);

  @override
  State<ResidenciaIndex> createState() => _ResidenciaIndexState();
}

class _ResidenciaIndexState extends State<ResidenciaIndex> {
  Residencia residencia = Residencia();
  ResidenciaController controller = ResidenciaController();

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    residencia = await controller.apiShowResidencia(widget.residencia_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: _TopPortion(
                foto:
                    "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/residencias/${residencia.foto_default.ruta}",
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    residencia.nombre,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          if (residencia.id > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResidenciaMedios(
                                        residencia_id: residencia.id.toString(),
                                      )),
                            );
                          }
                        },
                        heroTag: 'residencia',
                        elevation: 0,
                        label: Text("Imágenes"),
                        icon: const Icon(Icons.photo_album),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Auditor"),
            subtitle: Text(
                "${residencia.auditor.name} ${residencia.auditor.apaterno} ${residencia.auditor.amaterno}"),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.amberAccent),
            title: const Text("Teléfono"),
            subtitle: Text(residencia.telefono),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.deepOrange),
            title: const Text("Email"),
            subtitle: Text(residencia.email),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.purpleAccent),
            title: const Text("Dirección"),
            subtitle: Text(residencia.direccion),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  String foto = "";
  _TopPortion({required this.foto});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(foto),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
