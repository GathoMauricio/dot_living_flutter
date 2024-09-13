import 'package:flutter/widgets.dart';

class Notificaciones extends StatelessWidget {
  const Notificaciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(
            height: 300,
          ),
          Image(
            image: AssetImage(
              "assets/tablero.png",
            ),
            width: 300,
          ),
          Text(
            "Notificaciones",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
