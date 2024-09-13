class User{
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
  late var foto = "";
  late var email = "";
  
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
        foto = json['foto'] ?? '',
        email = json['email'] ?? '';

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
        'foto': foto,
        'email': email,
      };    
}