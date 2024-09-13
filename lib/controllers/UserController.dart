import 'dart:convert';

import 'package:DotLiving/helpers/Mensajes.dart' as mensajes;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

class UserController {
  Future login(String email, String password) async {
    var datos = {"email": email, "password": password};
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-login', datos);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['estatus'] == 1) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.setString("auth_token", jsonResponse['auth_token']);
        }
        return jsonResponse;
      } catch (e) {
        print(e);
        return {'estatus': false, 'error': 'Error al obtener los datos'};
      }
    } else {
      return {
        'estatus': false,
        'error': 'Error de servidor [code:${response.statusCode}]'
      };
    }
  }

  Future<bool> apiLogout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-logout');
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonResponse['estatus'] == 1) {
          localStorage.remove('auth_token');
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

  Future apiDatosUsuario() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-datos-usuario');

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse;
        String body = utf8.decode(response.bodyBytes);
        jsonResponse = convert.jsonDecode(body) as Map<String, dynamic>;

        if (jsonResponse['estatus'] == 1) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          try {
            localStorage.setString(
                "usuario", json.encode(jsonResponse['usuario']));
            try {
              localStorage.setString(
                  "residencia", json.encode(jsonResponse['residencia']));
              localStorage.setString(
                  "habitacion", json.encode(jsonResponse['habitacion']));
            } catch (e) {
              print(e);
            }
          } catch (e) {
            print(e);
          }
          return true;
        } else {
          localStorage.remove('auth_token');
          return false;
        }
      } catch (e) {
        print(e);
        localStorage.remove('auth_token');
        return false;
      }
    } else {
      localStorage.remove('auth_token');
      return false;
    }
  }

  // void guardarUsuarioLogeado(usuario) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   try {
  //     localStorage.setString(
  //         "usuario",
  //         json.encode({
  //           'id': usuario['id'],
  //           'rol_id': usuario['user_rol_id'],
  //           'cliente_id': usuario['company_branch_id'],
  //           'estatus': usuario['status'],
  //           'nombre': usuario['name'],
  //           'apaterno': usuario['middle_name'],
  //           'amaterno': usuario['last_name'],
  //           'telefono': usuario['phone'],
  //           'telefono_emergencia': usuario['emergency_phone'],
  //           'email': usuario['email'],
  //           'direccion': usuario['address'],
  //           'imagen': usuario['image'],
  //         }));
  //   } catch (e) {
  //     if (kDebugMode) print(e);
  //   }
  // }

  // Future<Usuario> usuarioLogueado() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   //print(localStorage.getString("usuario"));
  //   return Usuario.fromJson(
  //       json.decode(localStorage.getString("usuario") ?? ""));
  // }
}
