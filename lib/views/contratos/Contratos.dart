import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/ConfiguracionController.dart';
import '../../models/Contrato.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import '../configuracion/ContratoDetalle.dart';

class Contratos extends StatefulWidget {
  const Contratos({Key? key}) : super(key: key);

  @override
  State<Contratos> createState() => _ContratosState();
}

class _ContratosState extends State<Contratos> {
  ConfiguracionController controller = ConfiguracionController();
  ListView listView = ListView();
  List<ListTile> items = [];
  List<Contrato> lista = [];
  @override
  void initState() {
    inicializar();
    super.initState();
  }

  inicializar() async {
    lista = await controller.apiIndexContratos();
    setState(() {
      for (Contrato el in lista) {
        items.add(
          ListTile(
            leading: Text(el.estatus),
            title: Text(
                "Fecha ${DateFormat('yyyy-MM-dd').format(DateTime.parse(el.created_at))}"),
            subtitle: Text("Del ${el.fecha_inicio} al ${el.fecha_fin}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContratoDetalle(
                          contrato_id: el.id.toString(),
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
    return Scaffold(
        appBar: AppBar(title: const Text('Contratos')),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: items.length > 0
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return items[index];
                  })
              : const Center(child: Text("Sin registros para mostrar")),
        ));
  }
}
