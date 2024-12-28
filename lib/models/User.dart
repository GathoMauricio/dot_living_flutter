import 'package:flutter_dotenv/flutter_dotenv.dart';

class User {
  late var id = 0;
  late var name = "";
  late var apaterno = "";
  late var amaterno = "";
  late var telefono = "";
  late var ocupacion = "";
  late var nombre_emergencia = "";
  late var apellido_emergencia = "";
  late var telefono_emergencia = "";
  late var identificacion_emergencia = "";
  late var domicilio_emergencia = "";
  late var firma = "";
  late var fecha_contrato = "";
  late var foto =
      "http://${dotenv.env['SERVER_URL']}/dot_living/public/storage/foto_usuario/perfil.jpg";
  late var email = "";
  late var num_ine = "";

  User();

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        apaterno = json['apaterno'] ?? '',
        amaterno = json['amaterno'] ?? '',
        telefono = json['telefono'] ?? '',
        ocupacion = json['ocupacion'] ?? '',
        nombre_emergencia = json['nombre_emergencia'] ?? '',
        apellido_emergencia = json['apellido_emergencia'] ?? '',
        telefono_emergencia = json['telefono_emergencia'] ?? '',
        identificacion_emergencia = json['identificacion_emergencia'] ?? '',
        domicilio_emergencia = json['domicilio_emergencia'] ?? '',
        foto = json['foto'] ?? '',
        email = json['email'] ?? '',
        firma = json['firma'] ?? '',
        fecha_contrato = json['fecha_contrato'] ?? '',
        num_ine = json['num_ine'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'apaterno': apaterno,
        'amaterno': amaterno,
        'telefono': telefono,
        'ocupacion': ocupacion,
        'nombre_emergencia': nombre_emergencia,
        'apellido_emergencia': apellido_emergencia,
        'telefono_emergencia': telefono_emergencia,
        'identificacion_emergencia': identificacion_emergencia,
        'domicilio_emergencia': domicilio_emergencia,
        'foto': foto,
        'email': email,
        'firma': firma,
        'fecha_contrato': fecha_contrato,
        'num_ine': num_ine,
      };
}
