import 'package:DotLiving/models/Residencia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../controllers/MediaHabitacionController.dart';
import '../../controllers/HabitacionController.dart';
import '../../models/Habitacion.dart';
import '../../models/MediaHabitacion.dart';

class HabitacionMedios extends StatefulWidget {
  String habitacion_id = "";
  HabitacionMedios({Key? key, required this.habitacion_id}) : super(key: key);
  @override
  State<HabitacionMedios> createState() => _HabitacionMediosState();
}

class _HabitacionMediosState extends State<HabitacionMedios> {
  List<String> imgList = [];
  Habitacion habitacion = Habitacion();
  HabitacionController habitacionController = HabitacionController();
  MediaHabitacionController mediaController = MediaHabitacionController();
  List<MediaHabitacion> lista = [];

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    habitacion =
        await habitacionController.apiShowHabitacion(widget.habitacion_id);
    lista = await mediaController.apiIndexMediaHabitacion(widget.habitacion_id);
    imgList = [];
    for (MediaHabitacion el in lista) {
      imgList.add(
          "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/habitaciones/${el.ruta}");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fotos: ${habitacion.alias}")),
      body: lista.isEmpty
          ? const Center(
              child: Text("No hay contenido para mostrar"),
            )
          : Builder(
              builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return CarouselSlider(
                  options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  items: lista
                      .map((item) => Center(
                              child: Stack(
                            children: [
                              Image.network(
                                "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/habitaciones/${item.ruta}",
                                fit: BoxFit.cover,
                                height: height,
                              ),
                              Container(
                                //width: MediaQuery.of(context).size.width - 200,
                                padding: const EdgeInsets.all(10),
                                color: Colors.white,
                                child: Text(
                                  item.descripcion,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              // Center(
                              //   child: Container(
                              //     padding: const EdgeInsets.all(10),
                              //     color: Colors.white,
                              //     child: Text(
                              //       item.descripcion,
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.blue,
                              //         fontSize: 22.0,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )))
                      .toList(),
                );
              },
            ),
    );
  }
}
