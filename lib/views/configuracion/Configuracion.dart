import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../controllers/HomeController.dart';
import '../../controllers/UserController.dart';
import '../../helpers/Mensajes.dart' as mensaje;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/Mensajes.dart';
import '../auth/Login.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool _isDark = false;
  @override
  void initState() {
    super.initState();
    checkModoOscuro();
  }

  checkModoOscuro() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      _isDark = localStorage.getBool('modo_oscuro')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _SingleSection(
          title: "General",
          children: [
            _CustomListTile(
                on_tap: "",
                title: "Modo oscuro",
                icon: Icons.dark_mode_outlined,
                trailing: Switch(
                    value: _isDark,
                    onChanged: (value) async {
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();
                      setState(() {
                        localStorage.setBool('modo_oscuro', value);
                        _isDark = value;
                        if (_isDark) {
                          mensaje.mensajeEmergente(
                              context,
                              "Modo oscuro activado",
                              "Los cambios se reflejarán al recargar la aplicación.");
                        } else {
                          mensaje.mensajeEmergente(
                              context,
                              "Modo oscuro desactivado",
                              "Los cambios se reflejarán al recargar la aplicación.");
                        }
                      });
                    })),
            const _CustomListTile(
                on_tap: "actualizar",
                title: "Actualizar",
                icon: Icons.download),
            const _CustomListTile(
                on_tap: "cerrarSesion",
                title: "Cerar sesión",
                icon: Icons.exit_to_app_rounded),
          ],
        ),
        // const Divider(),
        // const _SingleSection(
        //   title: "Organization",
        //   children: [
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Profile",
        //         icon: Icons.person_outline_rounded),
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Messaging",
        //         icon: Icons.message_outlined),
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Calling",
        //         icon: Icons.phone_outlined),
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "People",
        //         icon: Icons.contacts_outlined),
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Calendar",
        //         icon: Icons.calendar_today_rounded)
        //   ],
        // ),
        // const Divider(),
        // const _SingleSection(
        //   children: [
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Help & Feedback",
        //         icon: Icons.help_outline_rounded),
        //     _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "About",
        //         icon: Icons.info_outline_rounded),
        //      _CustomListTile(
        //         on_tap: "cerrarSesion",
        //         title: "Sign out",
        //         icon: Icons.exit_to_app_rounded),
        //   ],
        // ),
      ],
    );
  }
}

actualizar(context) async {
  var hayNuevaVersion =
      await HomeController().hayNuevaVersion() as Map<String, dynamic>;
  if (hayNuevaVersion['estatus']) {
    // ignore: use_build_context_synchronously
    mensajeNuevaVersion(
        context,
        "Versión disponible: ${hayNuevaVersion['ultima_version'].toString().replaceAll("_", ".")}",
        "Actualmente se ejecuta la versión ${dotenv.env['APP_VERSION'].toString().replaceAll("_", ".")} le sugerimos descargar la versión más reciente.",
        hayNuevaVersion['ultima_version']);
  } else {
    // ignore: use_build_context_synchronously
    mensajeNuevaVersion(
        context,
        "Última versión: ${hayNuevaVersion['ultima_version'].toString().replaceAll("_", ".")}",
        "Actualmente se ejecuta la versión ${dotenv.env['APP_VERSION'].toString().replaceAll("_", ".")} \n¿Desea dercargarla de todas formas?.",
        hayNuevaVersion['ultima_version']);
  }
}

cerrarSesion(context) {
  print("Cerrar sesión");
  _mensajeLogout(context);
}

Future<void> _mensajeLogout(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('¿Realmente desea salir de la aplicación?'),
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
              'Salir',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              mensajeFlash(context, "Procesando la petición");
              if (await UserController().apiLogout()) {
                quitarMensajeFlash(context);
                mensajeFlash(context, "La sesión se cerró con exito");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
              } else {
                quitarMensajeFlash(context);
                mensajeFlash(context, "Error durante la operación");
              }
            },
          ),
        ],
      );
    },
  );
}

class _CustomListTile extends StatelessWidget {
  final String on_tap;
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile(
      {Key? key,
      required this.on_tap,
      required this.title,
      required this.icon,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: () {
        switch (on_tap) {
          case 'cerrarSesion':
            cerrarSesion(context);
            break;
          case 'actualizar':
            actualizar(context);
        }
      },
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
