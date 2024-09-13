import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

serverResponse(route, method, data) async {
  String authToken = "";
  http.Response response;
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  if (localStorage.containsKey('auth_token')) {
    authToken = localStorage.getString("auth_token").toString();
  }
  if (method == 'POST') {
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}$route');
    response = await http.post(
      url,
      body: data,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
  } else {
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(),
        '${dotenv.env['PROJECT_PATH']}$route', data);
    response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
  }
  return response;
}

Future<File> abriPdf(String link) async {
  String authToken = "";
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  authToken = localStorage.getString("auth_token").toString();
  try {
    var url = Uri.http(dotenv.env['SERVER_URL'].toString(), link, {});
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    var bytes = response.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/temp_cotizacion.pdf");
    File urlFile = await file.writeAsBytes(bytes);
    return urlFile;
  } catch (e) {
    throw Exception("Error al abrir el archivo");
  }
}
