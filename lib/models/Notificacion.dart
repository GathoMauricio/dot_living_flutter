class Notificacion {
  late var id = 0;
  late var residencia_id = 0;
  late var tipo = '';
  late var texto = '';
  late var imagen = '';
  late var created_at = '';
  late var updated_at = '';

  Notificacion();

  Notificacion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        residencia_id = json['residencia_id'] ?? '',
        tipo = json['tipo'] ?? '',
        texto = json['texto'] ?? '',
        imagen = json['imagen'] ?? '',
        created_at = json['created_at'] ?? '',
        updated_at = json['updated_at'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'residencia_id': residencia_id,
        'tipo': tipo,
        'texto': texto,
        'imagen': imagen,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
