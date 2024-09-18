import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/MediaResidencia.dart';

class MediaResidenciaController {
  Future<List<MediaResidencia>> apiIndexMediaResidencia(
      String residencia_id) async {
    List<MediaResidencia> lista = [];

    var datos = {"residencia_id": residencia_id};
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-media-residencia', datos);
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var el in jsonResponse['medios']) {
          lista.add(MediaResidencia.fromJson(el));
        }
      } catch (e) {
        print(e);
      }
    }
    return lista;
  }
}
