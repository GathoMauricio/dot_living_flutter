import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../controllers/UserController.dart';
import '../../models/Habitacion.dart';
import '../../models/Residencia.dart';
import '../../models/User.dart';
import '../../helpers/Mensajes.dart' as mensaje;

class Cuenta extends StatefulWidget {
  const Cuenta({Key? key}) : super(key: key);

  @override
  State<Cuenta> createState() => _CuentaState();
}

class _CuentaState extends State<Cuenta> {
  UserController controller = UserController();
  User usuario = User();
  Residencia residencia = Residencia();
  Habitacion habitacion = Habitacion();
  @override
  void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    await controller.apiDatosUsuario();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      usuario =
          User.fromJson(json.decode(localStorage.getString("usuario") ?? ""));
      usuario.foto =
          "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/foto_usuario/${usuario.foto}";
      try {
        residencia = Residencia.fromJson(
            json.decode(localStorage.getString("residencia") ?? ""));
        habitacion = Habitacion.fromJson(
            json.decode(localStorage.getString("habitacion") ?? ""));
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: _TopPortion(
              foto: usuario.foto,
            )),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                Text(
                  "${usuario.name} ${usuario.apaterno} ${usuario.amaterno}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (residencia.id > 0) {
                          mensaje.mensajeFlash(
                              context, "Info de ${residencia.nombre}");
                        }
                      },
                      heroTag: 'residencia',
                      elevation: 0,
                      label: Text(residencia.nombre),
                      icon: const Icon(Icons.add_home_work_rounded),
                    ),
                    const SizedBox(width: 16.0),
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (habitacion.id > 0) {
                          mensaje.mensajeFlash(
                              context, "Info de ${habitacion.alias}");
                        }
                      },
                      heroTag: 'habitación',
                      elevation: 0,
                      backgroundColor: Colors.cyanAccent,
                      label: Text(habitacion.alias),
                      icon: const Icon(Icons.home_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.email, color: Colors.purpleAccent),
          title: const Text("Correo electrónico"),
          subtitle: Text(usuario.email),
          trailing: const Icon(Icons.check_circle_rounded, color: Colors.green),
        ),
        ListTile(
          leading: const Icon(Icons.phone, color: Colors.amberAccent),
          title: const Text("Teléfono"),
          subtitle: Text(
              usuario.telefono.isEmpty ? "No disponible" : usuario.telefono),
          trailing: Icon(Icons.check_circle_rounded,
              color: usuario.telefono.isEmpty ? Colors.blueGrey : Colors.green),
        ),
        ListTile(
          leading: const Icon(Icons.work, color: Colors.blueAccent),
          title: const Text("Ocupación"),
          subtitle: Text(
              usuario.ocupacion.isEmpty ? "No disponible" : usuario.ocupacion),
          trailing: Icon(Icons.check_circle_rounded,
              color:
                  usuario.ocupacion.isEmpty ? Colors.blueGrey : Colors.green),
        ),
        const Text("Contacto de emergencia"),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.deepOrange),
          title: const Text("Nombre"),
          subtitle: Text(usuario.nombre_emergencia.isEmpty
              ? "No disponible"
              : "${usuario.nombre_emergencia} ${usuario.apellido_emergencia}"),
          trailing: Icon(Icons.check_circle_rounded,
              color: usuario.nombre_emergencia.isEmpty
                  ? Colors.blueGrey
                  : Colors.green),
        ),
        ListTile(
          leading: const Icon(Icons.phone, color: Colors.pinkAccent),
          title: const Text("Telefono"),
          subtitle: Text(usuario.nombre_emergencia.isEmpty
              ? "No disponible"
              : usuario.telefono_emergencia),
          trailing: Icon(Icons.check_circle_rounded,
              color: usuario.telefono_emergencia.isEmpty
                  ? Colors.blueGrey
                  : Colors.green),
        ),
      ],
    );
  }
}

// class ProfileInfoItem {
//   final String title;
//   final int value;
//   const ProfileInfoItem(this.title, this.value);
// }

class _TopPortion extends StatelessWidget {
  String foto = "";
  _TopPortion({required this.foto});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(foto)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
