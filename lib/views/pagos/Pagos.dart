import 'package:flutter/widgets.dart';

class Pagos extends StatelessWidget {
  const Pagos({Key? key}) : super(key: key);

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
              "assets/pagos.png",
            ),
            width: 300,
          ),
          Text(
            "Pagos",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
