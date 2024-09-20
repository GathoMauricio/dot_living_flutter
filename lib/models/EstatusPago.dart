class EstatusPago {
  late var id = 0;
  late var nombre = "";

  EstatusPago();

  EstatusPago.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        nombre = json['nombre'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };
}
