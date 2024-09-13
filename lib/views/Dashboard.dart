import 'package:DotLiving/views/mensajes/Mensajes.dart';
import 'package:DotLiving/views/notificaciones/Notificaciones.dart';
import 'package:DotLiving/views/pagos/Pagos.dart';
import 'package:DotLiving/views/usuario/Cuenta.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'configuracion/Configuracion.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Google Bottom Bar')),
      body: Center(
        //child: _navBarItems[_selectedIndex].title,
        child: _paginas[_selectedIndex],
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final _paginas = [
  const Cuenta(),
  const Pagos(),
  const Mensajes(),
  const Notificaciones(),
  const Configuracion(),
];

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.account_circle_rounded),
    title: const Text("Cuenta"),
    selectedColor: Colors.teal,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.attach_money_sharp),
    title: const Text("Pagos"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.chat_rounded),
    title: const Text("Mensajes"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.circle_notifications_sharp),
    title: const Text("Notificaciones"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.settings),
    title: const Text("Configuración"),
    selectedColor: Colors.redAccent,
  ),
];
