import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfiguracionController {
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
