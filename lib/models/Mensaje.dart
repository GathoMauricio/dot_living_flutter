import 'User.dart';

import 'Conversacion.dart';

class Mensaje {
  late var id = 0;
  late var conversacion_id = 0;
  late var usuario_id = 0;
  late var tipo = '';
  late var texto = '';
  late var imagen = '';
  late var created_at = '';
  late var updated_at = '';

  late Conversacion conversacion = Conversacion();
  late User usuario = User();

  Mensaje();

  Mensaje.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        conversacion_id = json['conversacion_id'] ?? '',
        usuario_id = json['usuario_id'] ?? '',
        tipo = json['tipo'] ?? '',
        texto = json['texto'] ?? '',
        //imagen = json['imagen'] ?? '',
        created_at = json['created_at'] ?? '',
        updated_at = json['updated_at'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversacion_id': conversacion_id,
        'usuario_id': usuario_id,
        'tipo': tipo,
        'texto': texto,
        //'imagen': imagen,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
