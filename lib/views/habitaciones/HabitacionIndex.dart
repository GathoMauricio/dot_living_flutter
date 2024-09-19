import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../controllers/HabitacionController.dart';
import '../../models/Habitacion.dart';
import 'HabitacionMedios.dart';
//import 'habitacionMedios.dart';

class HabitacionIndex extends StatefulWidget {
  String habitacion_id = "";
  HabitacionIndex({Key? key, required this.habitacion_id}) : super(key: key);

  @override
  State<HabitacionIndex> createState() => _HabitacionIndexState();
}

class _HabitacionIndexState extends State<HabitacionIndex> {
  Habitacion habitacion = Habitacion();
  HabitacionController controller = HabitacionController();

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    habitacion = await controller.apiShowHabitacion(widget.habitacion_id);
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
                    "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/habitaciones/${habitacion.foto_default.ruta}",
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    habitacion.alias,
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
                          if (habitacion.id > 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HabitacionMedios(
                                        habitacion_id: habitacion.id.toString(),
                                      )),
                            );
                          }
                        },
                        heroTag: 'habitación',
                        elevation: 0,
                        label: Text("Imágenes"),
                        backgroundColor: Colors.cyanAccent,
                        icon: const Icon(Icons.photo_album),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.price_change, color: Colors.blueAccent),
            title: const Text("Renta"),
            subtitle: Text(habitacion.renta),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.price_change, color: Colors.amberAccent),
            title: const Text("Deposito"),
            subtitle: Text(habitacion.deposito),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.abc, color: Colors.deepPurple),
            title: const Text("Medidas"),
            subtitle: Text(habitacion.medidas),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.abc, color: Colors.deepOrange),
            title: const Text("Descripción"),
            subtitle: Text(habitacion.descripcion),
            // trailing:
            //     const Icon(Icons.check_circle_rounded, color: Colors.green),
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
