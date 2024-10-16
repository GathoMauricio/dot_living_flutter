import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

import '../models/Conversacion.dart';
import '../models/Mensaje.dart';
import '../models/User.dart';

class ConversacionController {
  Future<List<Conversacion>> apiIndexConversaciones() async {
    List<Conversacion> lista = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-conversaciones', {});
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
          Conversacion aux = Conversacion.fromJson(el);
          aux.residente = User.fromJson(el['residente']);
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

  Future<Conversacion> apiStoreConversacion(String asunto) async {
    Conversacion conversacion = Conversacion();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-store-conversacion');
    var response = await http.post(
      url,
      body: {'asunto': asunto},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['estatus'] == 1) {
          conversacion = Conversacion.fromJson(jsonResponse['data']);
        }
      } catch (e) {
        print(e);
      }
    }
    return conversacion;
  }

  Future<List<Mensaje>> apiIndexMensajes(String conversacion_id) async {
    List<Mensaje> lista = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(
        dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-index-mensajes',
        {'conversacion_id': conversacion_id});
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
          Mensaje aux = Mensaje.fromJson(el);
          aux.usuario = User.fromJson(el['usuario']);
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

  Future<Mensaje> apiStoreMensaje(String conversacion_id, String texto) async {
    Mensaje mensaje = Mensaje();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-store-mensaje');
    var response = await http.post(
      url,
      body: {'conversacion_id': conversacion_id, 'texto': texto},
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    //print(response.body);
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['estatus'] == 1) {
          mensaje = Mensaje.fromJson(jsonResponse['data']);
        }
      } catch (e) {
        print(e);
      }
    }
    return mensaje;
  }
}
