import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/PagoController.dart';
import '../../models/Pago.dart';
import '../../helpers/Mensajes.dart' as mensaje;

class ShowPago extends StatefulWidget {
  String pago_id;
  ShowPago({Key? key, required this.pago_id}) : super(key: key);

  @override
  State<ShowPago> createState() => _ShowPagoState();
}

class _ShowPagoState extends State<ShowPago> {
  PagoController controller = PagoController();
  Pago pago = Pago();
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    pago = await controller.apiShowPago(widget.pago_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Detalles del pago")),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            ListTile(
              title: Text("Tipo", style: TextStyle(color: Colors.blue)),
              subtitle: Text(pago.tipo.nombre),
            ),
            ListTile(
              title: Text("Estatus", style: TextStyle(color: Colors.blue)),
              subtitle: Text(pago.estatus.nombre),
            ),
            ListTile(
              title:
                  Text("Fecha de pago", style: TextStyle(color: Colors.blue)),
              subtitle: Text(pago.fecha),
            ),
            ListTile(
              title: Text("Cantidad", style: TextStyle(color: Colors.blue)),
              subtitle: Text("\$ ${pago.cantidad}"),
            ),
            ListTile(
              title: Text("Descripción", style: TextStyle(color: Colors.blue)),
              subtitle: Text(pago.descripcion),
            ),
            comprobante(),
          ]),
        ));
  }

  Widget comprobante() {
    switch (pago.estatus_id) {
      case 1:
        if (pago.comprobante.isEmpty) {
          return ListTile(
            title: ElevatedButton(
              onPressed: () {
                seleccionarArchivoCamara();
              },
              child: const Text("Cargar comprobante"),
            ),
          );
        } else {
          return Image(
              image: NetworkImage(
                  "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/comprobantes/${pago.comprobante}"));
        }

      case 2:
        if (pago.comprobante.isEmpty) {
          return Center(child: Text("Sin comprobante"));
        } else {
          return Image(
              image: NetworkImage(
                  "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/comprobantes/${pago.comprobante}"));
        }

      case 3:
        return ListTile(
          title: ElevatedButton(
            onPressed: () {
              seleccionarArchivoCamara();
            },
            child: const Text("Volver a cargar comprobante"),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  seleccionarArchivoCamara() async {
    final ImagePicker picker = ImagePicker();
    String imagePath = "";
    try {
      var archivo = await picker.pickImage(source: ImageSource.camera);
      imagePath = archivo!.path;
      List<int> bytes = File(imagePath).readAsBytesSync();
      //print(bytes);
      var imagen64 = base64Encode(bytes);
      var data = {
        'pago_id': pago.id.toString(),
        'archivo': imagen64,
      };
      mensaje.mensajeFlash(context, "Enviando comprobante...");
      bool respuesta = await controller.apiAdjuntarComprobante(data);
      if (respuesta) {
        mensaje.mensajeFlash(context, "Comprobante enviado...");
        inicializar();
      } else {
        mensaje.mensajeEmergente(context, "Error",
            "Ocurrió un error durante la operacion, por favor intente de nuevo");
      }
    } catch (e) {
      print(e);
    }
  }
}
