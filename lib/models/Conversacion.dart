import 'User.dart';

class Conversacion {
  late var id = 0;
  late var residente_id = 0;
  late var asunto = '';
  late var created_at = '';
  late var updated_at = '';

  late User residente = User();

  Conversacion();

  Conversacion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        residente_id = json['residente_id'] ?? '',
        asunto = json['asunto'] ?? '',
        created_at = json['created_at'] ?? '',
        updated_at = json['updated_at'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'residente_id': residente_id,
        'asunto': asunto,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
