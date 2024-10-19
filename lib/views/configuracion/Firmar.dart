import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../../controllers/ConfiguracionController.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import 'Contrato.dart';

class Firmar extends StatefulWidget {
  const Firmar({Key? key}) : super(key: key);

  @override
  State<Firmar> createState() => _FirmarState();
}

class _FirmarState extends State<Firmar> {
  ConfiguracionController controller = ConfiguracionController();
  String firma = "";
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 8,
    penColor: Colors.purple,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var signatureCanvas = Signature(
      controller: _controller,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height - 120,
      backgroundColor: Colors.grey,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              _controller.clear();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.check,
            ),
            onPressed: () async {
              try {
                await _controller.toPngBytes().then(
                  (data) {
                    firma = base64.encode(data as List<int>);
                  },
                );
                guardarFirma();
              } catch (e) {
                mensaje.mensajeFlash(context, "Por favor ingresa tu firma");
              }
              // returns base64 string
            },
          ),
        ],
        title: const Text("Firmar contrato"),
      ),
      body: Column(
        children: [signatureCanvas],
      ),
    );
  }

  Future<void> guardarFirma() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Firmar",
              style: const TextStyle(color: Colors.purple, fontSize: 18.0)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("¿Guardar firma?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Si, guardar',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                bool estado = await controller.apiGuardarFirma({
                  'firma': firma,
                });
                if (estado) {
                  mensaje.mensajeFlash(context, "Firma enviada.");
                  //TODO:redireccionar

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contrato()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
