import 'package:flutter/widgets.dart';

class Mensajes extends StatelessWidget {
  const Mensajes({Key? key}) : super(key: key);

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
              "assets/mensajeria.png",
            ),
            width: 300,
          ),
          Text(
            "Mensajes",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
