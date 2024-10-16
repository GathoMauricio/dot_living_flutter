import 'package:flutter/material.dart';
import '../../controllers/PagoController.dart';
import '../../models/Pago.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import 'ShowPago.dart';

class Pagos extends StatefulWidget {
  const Pagos({Key? key}) : super(key: key);

  @override
  State<Pagos> createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  PagoController controller = PagoController();
  ListView listView = ListView();
  List<ListTile> items = [];
  List<Pago> lista = [];
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    lista = await controller.apiIndexPagos();
    setState(() {
      for (Pago el in lista) {
        items.add(
          ListTile(
            leading: el.estatus_id == 2
                ? const Icon(Icons.check_circle_outline, color: Colors.green)
                : const Icon(Icons.warning, color: Colors.orangeAccent),
            title: Text("${el.tipo.nombre} - ${el.estatus.nombre}"),
            subtitle: Text("${el.fecha} - \$${el.cantidad}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowPago(
                          pago_id: el.id.toString(),
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
      child: items.length > 0
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return items[index];
              })
          : const Center(child: Text("Sin registros para mostrar")),
    );
  }
}
