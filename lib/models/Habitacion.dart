import 'package:DotLiving/models/MediaHabitacion.dart';

class Habitacion {
  late var id = 0;
  late var residencia_id = 0;
  late var residente_id = 0;
  late var alias = "No disponible";
  late var medidas = "";
  late var renta = "";
  late var deposito = "";
  late var descripcion = "";
  late var numero = '';
  late MediaHabitacion foto_default = MediaHabitacion();

  Habitacion();

  Habitacion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        residencia_id = json['residencia_id'] ?? '',
        residente_id = json['residente_id'] ?? '',
        alias = json['alias'] ?? '',
        medidas = json['medidas'] ?? '',
        renta = json['renta'] ?? '',
        deposito = json['deposito'] ?? '',
        descripcion = json['descripcion'] ?? '',
        numero = json['numero'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'residencia_id': residencia_id,
        'residente_id': residente_id,
        'alias': alias,
        'medidas': medidas,
        'renta': renta,
        'deposito': deposito,
        'descripcion': descripcion,
        'numero': numero,
      };
}
