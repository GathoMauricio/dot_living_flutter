import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '../../controllers/NotificacionController.dart';
import '../../models/Notificacion.dart';
import '../../helpers/Mensajes.dart' as mensaje;

class Notificaciones extends StatefulWidget {
  const Notificaciones({Key? key}) : super(key: key);

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  NotificacionController controller = NotificacionController();
  ListView listView = ListView();
  List<ListTile> items = [];
  List<Notificacion> lista = [];
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    lista = await controller.apiIndexNotificaciones();
    setState(() {
      for (Notificacion el in lista) {
        items.add(
          ListTile(
            leading: el.tipo == 'texto'
                ? const Icon(Icons.abc, color: Colors.orangeAccent)
                : const Icon(Icons.photo, color: Colors.orangeAccent),
            title: Text(el.texto, style: const TextStyle(color: Colors.purple)),
            subtitle: el.tipo == 'texto'
                ? Text(
                    "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(el.created_at))} Hrs.",
                    textAlign: TextAlign.center)
                : Column(children: [
                    Image(
                      image: NetworkImage(
                          "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/tableros/${el.imagen}"),
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                    Text(
                        "${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(el.created_at))} Hrs."),
                  ]),
            //trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ShowNofificacion(
              //             conversacion_id: el.id.toString(),
              //           )),
              // );
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
          : const Center(
              child: const Text("No hay notificaciones para mostrar"),
            ),
    );
  }
}
