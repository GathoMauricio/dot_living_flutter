import 'package:DotLiving/helpers/Api.dart' as api;
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeController {
  Future<Object> hayNuevaVersion() async {
    var response = await api
        .serverResponse('api-ultima-version-android', 'GET', {'none': 'data'});
    if (response.statusCode == 200) {
      try {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (dotenv.env['APP_VERSION'] == jsonResponse['ultima_version']) {
          return {
            "estatus": false,
            "ultima_version": jsonResponse['ultima_version']
          };
        } else {
          return {
            "estatus": true,
            "ultima_version": jsonResponse['ultima_version']
          };
        }
      } catch (e) {
        return {"estatus": false, "ultima_version": null};
      }
    } else {
      return {"estatus": false, "ultima_version": null};
    }
  }
}
