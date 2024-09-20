import 'package:DotLiving/models/EstatusPago.dart';
import 'package:DotLiving/models/TipoPago.dart';

class Pago {
  late var id = 0;
  late var estatus_id = 0;
  late var residente_id = 0;
  late var tipo_id = 0;
  late var comprobante = "";
  late var descripcion = "";
  late var fecha = "";
  late var cantidad = 0;
  late EstatusPago estatus = EstatusPago();
  late TipoPago tipo = TipoPago();

  Pago();

  Pago.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        estatus_id = json['estatus_id'] ?? '',
        residente_id = json['residente_id'] ?? '',
        tipo_id = json['tipo_id'] ?? '',
        comprobante = json['comprobante'] ?? '',
        descripcion = json['descripcion'] ?? '',
        fecha = json['fecha'] ?? '',
        cantidad = json['cantidad'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'estatus_id': estatus_id,
        'residente_id': residente_id,
        'tipo_id': tipo_id,
        'comprobante': comprobante,
        'descripcion': descripcion,
        'fecha': fecha,
        'cantidad': cantidad,
      };
}
