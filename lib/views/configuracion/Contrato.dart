import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../controllers/UserController.dart';
import '../../models/User.dart';
import 'Firmar.dart';

class Contrato extends StatefulWidget {
  const Contrato({Key? key}) : super(key: key);

  @override
  State<Contrato> createState() => _ContratoState();
}

class _ContratoState extends State<Contrato> {
  UserController controller = UserController();
  User usuario = User();
  void initState() {
    inicializar();
    super.initState();
  }

  void inicializar() async {
    bool data = await controller.apiDatosUsuario();
    if (data) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      setState(() {
        usuario =
            User.fromJson(json.decode(localStorage.getString('usuario') ?? ""));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("Firmar"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Firmar()),
              );
            },
          )
        ],
        title: Text("Contrato"),
      ),
      body: Column(
        children: [
          Text(
              "Inquilino: ${usuario.name} ${usuario.apaterno} ${usuario.amaterno}"),
          Text(
              "Mauris posuere purus non erat euismod, sed pretium dui consequat. Morbi tincidunt condimentum leo sed molestie. Donec pulvinar ac nulla in consectetur. Phasellus ultricies, dolor id pulvinar accumsan, nisl urna pretium magna, et vestibulum lorem nibh ut nisi. Sed non justo enim. Aenean efficitur metus eget turpis dignissim, vitae molestie nisl tincidunt. Duis fringilla, quam at scelerisque pulvinar, ligula sapien eleifend tortor, non rhoncus velit massa ac neque. Sed id est dui. Quisque consectetur id tortor porttitor rhoncus. Sed elementum non elit ut lobortis. Vestibulum vitae egestas enim. Mauris sed dui sagittis, maximus libero quis, scelerisque odio. Pellentesque volutpat tempus tristique. Vestibulum mauris metus, egestas sodales enim sed, gravida cursus arcu. Phasellus quis dapibus eros. Praesent accumsan aliquet ipsum pretium lacinia. Mauris bibendum mauris justo, ac ultrices elit dignissim quis. Fusce ac ultrices est, convallis volutpat mi. Aenean eleifend mollis turpis, eu faucibus ante facilisis sed. Cras quis scelerisque arcu, eget tempor felis. Sed commodo nisi mauris. Pellentesque libero nunc, congue vel imperdiet sed, ullamcorper feugiat urna. Pellentesque et molestie felis. Suspendisse potenti. Praesent ut metus id ex tincidunt placerat et id diam. Cras orci turpis, iaculis sit amet erat vitae, vestibulum blandit augue. Phasellus ligula odio, hendrerit in imperdiet eget, tincidunt ac odio. Duis pretium arcu at sapien maximus, at vulputate tellus molestie. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla ante ipsum, aliquam at porttitor at, dignissim id dolor. Quisque varius orci sit amet sapien hendrerit, id consequat ex hendrerit. Donec et pharetra nisl, sit amet pretium neque. Donec bibendum id elit eget dignissim. Donec justo ipsum, tempus vel ullamcorper et, vulputate vulputate urna. Pellentesque eget sagittis velit, in hendrerit ligula. Ut varius ut leo ut elementum. Cras urna erat, dictum eget eros a, sollicitudin rhoncus nisi. Phasellus luctus nunc sit amet aliquam lacinia. Nunc dictum volutpat auctor. Duis a euismod arcu. Praesent vestibulum,."),
          usuario.firma.isNotEmpty
              ? Text("${usuario.name} ${usuario.apaterno} ${usuario.amaterno}")
              : Text("NO SE HA FIRMADO"),
          usuario.firma.isNotEmpty
              ? Image(
                  image: NetworkImage(
                      "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/firma_usuario/${usuario.firma}"),
                  width: 80,
                  //height: MediaQuery.sizeOf(context).height / 24,
                )
              : SizedBox(),
          usuario.firma.isNotEmpty
              ? Text("______________________________")
              : SizedBox(),
        ],
      ),
    );
  }
}
