import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Contrato.dart';
import '../models/Habitacion.dart';
import '../models/User.dart';

class ConfiguracionController {
  Future<List<Contrato>> apiIndexContratos() async {
    List<Contrato> lista = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-contratos', {});
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
          Contrato aux = Contrato.fromJson(el);
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

  Future<Contrato> apiShowContrato(contrato_id) async {
    Contrato contrato = Contrato();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(
        dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-show-contrato',
        {'contrato_id': contrato_id});
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
        contrato = Contrato.fromJson(jsonResponse['data']);
        contrato.habitacion =
            Habitacion.fromJson(jsonResponse['data']['habitacion']);
        contrato.residente = User.fromJson(jsonResponse['data']['residente']);
      } catch (e) {
        print(e);
      }
    } else {
      print("Error de servidor");
    }
    return contrato;
  }

  Future<bool> apiGuardarFirma(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();
    var response = await http.post(
        Uri.http(dotenv.env['SERVER_URL'].toString(),
            '${dotenv.env['PROJECT_PATH']}api-guardar-firma'),
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $authToken',
        });
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['estatus'] == 1) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }
}
