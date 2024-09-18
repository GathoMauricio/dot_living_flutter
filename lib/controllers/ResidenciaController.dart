import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Residencia.dart';
import '../models/User.dart';

class ResidenciaController {
  Future<Residencia> apiIndexResidencia(String residencia_id) async {
    Residencia residencia = Residencia();
    var datos = {"residencia_id": residencia_id};
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-residencia', datos);
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
        residencia = Residencia.fromJson(jsonResponse['data']['residencia']);
        residencia.auditor = User.fromJson(jsonResponse['data']['auditor']);
        return residencia;
      } catch (e) {
        print(e);
        residencia.nombre = "Catch Error";
        return residencia;
      }
    } else {
      residencia.nombre = "Server Error";
      return residencia;
    }
  }
}
