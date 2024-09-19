import 'package:DotLiving/models/MediaHabitacion.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Habitacion.dart';
import '../models/User.dart';

class HabitacionController {
  Future<Habitacion> apiShowHabitacion(String habitacion_id) async {
    Habitacion habitacion = Habitacion();
    var datos = {"habitacion_id": habitacion_id};
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String authToken = localStorage.getString("auth_token").toString();

    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}api-show-habitacion', datos);
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
        habitacion = Habitacion.fromJson(jsonResponse['data']['habitacion']);
        if (jsonResponse['data']['foto_default'] != 'none') {
          habitacion.foto_default =
              MediaHabitacion.fromJson(jsonResponse['data']['foto_default']);
        }
        return habitacion;
      } catch (e) {
        print(e);
        habitacion.alias = "Catch Error";
        return habitacion;
      }
    } else {
      habitacion.alias = "Server Error";
      return habitacion;
    }
  }
}
