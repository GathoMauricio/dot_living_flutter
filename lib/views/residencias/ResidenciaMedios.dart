import 'package:DotLiving/models/Residencia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../controllers/MediaResidenciaController.dart';
import '../../controllers/ResidenciaController.dart';
import '../../models/MediaResidencia.dart';

class ResidenciaMedios extends StatefulWidget {
  String residencia_id = "";
  ResidenciaMedios({Key? key, required this.residencia_id}) : super(key: key);
  @override
  State<ResidenciaMedios> createState() => _ResidenciaMediosState();
}

class _ResidenciaMediosState extends State<ResidenciaMedios> {
  List<String> imgList = [];
  Residencia residencia = Residencia();
  ResidenciaController residenciaController = ResidenciaController();
  MediaResidenciaController mediaController = MediaResidenciaController();
  List<MediaResidencia> lista = [];

  @override
  void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    residencia =
        await residenciaController.apiIndexResidencia(widget.residencia_id);
    lista = await mediaController.apiIndexMediaResidencia(widget.residencia_id);
    imgList = [];
    for (MediaResidencia el in lista) {
      imgList.add(
          "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/residencias/${el.ruta}");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fotos: ${residencia.nombre}")),
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
                                "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/residencias/${item.ruta}",
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
