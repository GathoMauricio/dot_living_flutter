class Residencia{
  late var id = 0;
  late var auditor_id = 0;
  late var nombre = "No disponible";
  late var telefono = "";
  late var email = "";
  late var direccion = "";

  Residencia();

  Residencia.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        auditor_id = json['auditor_id'] ?? '',
        nombre = json['nombre'] ?? '',
        telefono = json['telefono'] ?? '',
        email = json['email'] ?? '',
        direccion = json['direccion'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'auditor_id': auditor_id,
        'nombre': nombre,
        'telefono': telefono,
        'email': email,
        'direccion': direccion,
      };  
}