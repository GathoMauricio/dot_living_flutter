import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/ConversacionController.dart';
import '../../models/Mensaje.dart';
import '../../helpers/Mensajes.dart' as mensaje;

class ShowMensajes extends StatefulWidget {
  String conversacion_id = "";
  ShowMensajes({Key? key, required this.conversacion_id}) : super(key: key);

  @override
  State<ShowMensajes> createState() => _ShowMensajesState();
}

class _ShowMensajesState extends State<ShowMensajes> {
  ConversacionController controller = ConversacionController();
  ListView listView = ListView();
  List<ListTile> items = [];
  List<Mensaje> lista = [];
  String texto = "";
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    items = [];
    lista = await controller.apiIndexMensajes(widget.conversacion_id);
    setState(() {
      for (Mensaje el in lista) {
        items.add(
          ListTile(
            leading: const Icon(Icons.chat_bubble, color: Colors.pinkAccent),
            title: Text(el.texto),
            subtitle: Text(
                "${el.usuario.name} ${el.usuario.apaterno} ${el.usuario.amaterno} - ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(el.created_at))} Hrs."),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            iniciarConversacion();
          }),
      appBar: AppBar(
        title: const Text("Conversación"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: items.length > 0
            ? ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return items[index];
                })
            : const Center(child: Text("Sin registros para mostrar")),
      ),
    );
  }

  Future iniciarConversacion() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Nuevo mensaje',
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
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
                      labelText: 'Escriba su mensaje aquí:',
                    ),
                    onChanged: (value) {
                      texto = value;
                    },
                    maxLines: 4,
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
                  'Enviar',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                onPressed: () async {
                  if (texto.isNotEmpty) {
                    Mensaje mensaje = await controller.apiStoreMensaje(
                        widget.conversacion_id, texto);
                    //if (mensaje.id > 0) {
                    inicializar();
                    Navigator.of(context).pop();
                    //}
                  }
                },
              ),
            ],
          );
        });
  }
}
