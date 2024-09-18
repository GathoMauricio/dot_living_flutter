import 'Residencia.dart';

class MediaResidencia {
  late var id = 0;
  late var residencia_id = 0;
  late var ruta = "";
  late var descripcion = "";
  late Residencia residencia = Residencia();

  MediaResidencia();

  MediaResidencia.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        residencia_id = json['residencia_id'] ?? '',
        ruta = json['ruta'] ?? '',
        descripcion = json['descripcion'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'residencia_id': residencia_id,
        'ruta': ruta,
        'descripcion': descripcion,
      };
}
