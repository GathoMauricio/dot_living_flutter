import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/ConversacionController.dart';
import '../../models/Conversacion.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import 'ShowMensajes.dart';

class Mensajes extends StatefulWidget {
  const Mensajes({Key? key}) : super(key: key);

  @override
  State<Mensajes> createState() => _MensajesState();
}

class _MensajesState extends State<Mensajes> {
  ConversacionController controller = ConversacionController();
  ListView listView = ListView();
  List<ListTile> items = [];
  List<Conversacion> lista = [];
  String asunto = "";
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    items = [];
    items.add(ListTile(
      title: ElevatedButton(
        child: const Text("Iniciar converzación"),
        onPressed: () {
          iniciarConversacion();
        },
      ),
    ));
    lista = await controller.apiIndexConversaciones();
    setState(() {
      for (Conversacion el in lista) {
        items.add(
          ListTile(
            leading:
                const Icon(Icons.chat_bubble_outline, color: Colors.pinkAccent),
            title: Text(el.asunto),
            subtitle: Text(
                "${el.residente.name} ${el.residente.apaterno} ${el.residente.amaterno} - ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(el.created_at))} Hrs."),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowMensajes(
                          conversacion_id: el.id.toString(),
                        )),
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              })
          : ElevatedButton(
              child: const Text(
                  "Aun no hay conversaciones\nIniciar nueva conversacion"),
              onPressed: () {
                iniciarConversacion();
              }),
    );
  }

  Future iniciarConversacion() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'iniciar conversacion',
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      filled: true,
                      fillColor: Color.fromARGB(240, 230, 221, 221),
                      labelStyle: TextStyle(color: Colors.pinkAccent),
                      labelText: 'Escriba el asunto aquí:',
                    ),
                    onChanged: (value) {
                      asunto = value;
                    },
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Iniciar',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                onPressed: () async {
                  if (asunto.isNotEmpty) {
                    Conversacion conversacion =
                        await controller.apiStoreConversacion(asunto);
                    if (conversacion.id > 0) {
                      inicializar();
                      Navigator.of(context).pop();
                      mensaje.mensajeFlash(context, "Registro creado");
                    }
                  }
                },
              ),
            ],
          );
        });
  }
}
