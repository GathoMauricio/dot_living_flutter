import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

import '../models/EstatusPago.dart';
import '../models/Pago.dart';
import '../models/TipoPago.dart';

class PagoController {
  Future<List<Pago>> apiIndexPagos() async {
    List<Pago> lista = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-pagos', {});
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    //print(response.body);
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var el in jsonResponse['data']) {
          Pago aux = Pago.fromJson(el);
          aux.estatus = EstatusPago.fromJson(el['estatus']);
          aux.tipo = TipoPago.fromJson(el['tipo']);
          lista.add(aux);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Error de servidor");
    }
    return lista;
  }
}
