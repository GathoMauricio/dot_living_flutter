import 'Habitacion.dart';

class MediaHabitacion {
  late var id = 0;
  late var habitacion_id = 0;
  late var ruta = "habitacion.jpg";
  late var descripcion = "";
  late Habitacion habitacion = Habitacion();

  MediaHabitacion();

  MediaHabitacion.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        habitacion_id = json['habitacion_id'] ?? '',
        ruta = json['ruta'] ?? '',
        descripcion = json['descripcion'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'habitacion_id': habitacion_id,
        'ruta': ruta,
        'descripcion': descripcion,
      };
}
