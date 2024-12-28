import 'User.dart';
import 'Habitacion.dart';

class Contrato {
  late var id = 0;
  late var estatus = '';
  late var residente_id = 0;
  late var habitacion_id = 0;
  late var fecha_inicio = '';
  late var fecha_fin = '';
  late var deposito_num = 0;
  late var deposito_text = '';
  late var renta_num = 0;
  late var renta_text = '';
  late var firma = '';
  late var estatus_cama = '';
  late var observaciones_cama = '';
  late var estatus_colchon = '';
  late var observaciones_colchon = '';
  late var estatus_focos = '';
  late var observaciones_focos = '';
  late var estatus_ventana_vidrios = '';
  late var observaciones_ventana_vidrios = '';
  late var estatus_pintura = '';
  late var observaciones_pintura = '';
  late var estatus_perforacion_pared = '';
  late var observaciones_perforacion_pared = '';
  late var estatus_puertas_rayones = '';
  late var observaciones_puertas_rayones = '';
  late var estatus_chapa = '';
  late var observaciones_chapa = '';
  late var estatus_juego_llaves = '';
  late var observaciones_juego_llaves = '';
  late var estatus_regadera_fugas = '';
  late var observaciones_regadera_fugas = '';
  late var estatus_taza_bano_roturas = '';
  late var observaciones_taza_bano_roturas = '';
  late var estatus_lavabo_roturas = '';
  late var observaciones_lavabo_roturas = '';
  late var estatus_chapa_ventana = '';
  late var observaciones_chapa_ventana = '';
  late var estatus_enchufes = '';
  late var observaciones_enchufes = '';
  late var estatus_apagadores = '';
  late var observaciones_apagadores = '';
  late var estatus_cortinas = '';
  late var observaciones_cortinas = '';
  late var estatus_mueble_ropa = '';
  late var observaciones_mueble_ropa = '';
  late var notas = '';
  late var estatus_access_point = '';
  late var observaciones_access_point = '';
  late var estatus_internet = '';
  late var observaciones_internet = '';
  late var estatus_television = '';
  late var observaciones_television = '';
  late var estatus_sala = '';
  late var observaciones_sala = '';
  late var estatus_menaje_cocina = '';
  late var observaciones_menaje_cocina = '';
  late var estatus_refrigerador = '';
  late var observaciones_refrigerador = '';
  late var estatus_horno_microondas = '';
  late var observaciones_horno_microondas = '';
  late var estatus_estufa = '';
  late var observaciones_estufa = '';
  late var estatus_lavadora = '';
  late var observaciones_lavadora = '';
  late var estatus_area_tendido = '';
  late var observaciones_area_tendido = '';
  late var estatus_video_vigilancia = '';
  late var observaciones_video_vigilancia = '';
  late var created_at = '';
  late var updated_at = '';

  late User residente = User();
  late Habitacion habitacion = Habitacion();

  Contrato();

  Contrato.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        estatus = json['estatus'] ?? '',
        residente_id = json['residente_id'] ?? 0,
        habitacion_id = json['habitacion_id'] ?? 0,
        fecha_inicio = json['fecha_inicio'] ?? '',
        fecha_fin = json['fecha_fin'] ?? '',
        deposito_num = json['deposito_num'] ?? 0,
        deposito_text = json['deposito_text'] ?? '',
        renta_num = json['renta_num'] ?? 0,
        renta_text = json['renta_text'] ?? '',
        firma = json['firma'] ?? '',
        estatus_cama = json['estatus_cama'],
        observaciones_cama = json['observaciones_cama'],
        estatus_colchon = json['estatus_colchon'],
        observaciones_colchon = json['observaciones_colchon'],
        estatus_focos = json['estatus_focos'],
        observaciones_focos = json['observaciones_focos'],
        estatus_ventana_vidrios = json['estatus_ventana_vidrios'],
        observaciones_ventana_vidrios = json['observaciones_ventana_vidrios'],
        estatus_pintura = json['estatus_pintura'],
        observaciones_pintura = json['observaciones_pintura'],
        estatus_perforacion_pared = json['estatus_perforacion_pared'],
        observaciones_perforacion_pared =
            json['observaciones_perforacion_pared'],
        estatus_puertas_rayones = json['estatus_puertas_rayones'],
        observaciones_puertas_rayones = json['observaciones_puertas_rayones'],
        estatus_chapa = json['estatus_chapa'],
        observaciones_chapa = json['observaciones_chapa'],
        estatus_juego_llaves = json['estatus_juego_llaves'],
        observaciones_juego_llaves = json['observaciones_juego_llaves'],
        estatus_regadera_fugas = json['estatus_regadera_fugas'],
        observaciones_regadera_fugas = json['observaciones_regadera_fugas'],
        estatus_taza_bano_roturas = json['estatus_taza_bano_roturas'],
        observaciones_taza_bano_roturas =
            json['observaciones_taza_bano_roturas'],
        estatus_lavabo_roturas = json['estatus_lavabo_roturas'],
        observaciones_lavabo_roturas = json['observaciones_lavabo_roturas'],
        estatus_chapa_ventana = json['estatus_chapa_ventana'],
        observaciones_chapa_ventana = json['observaciones_chapa_ventana'],
        estatus_enchufes = json['estatus_enchufes'],
        observaciones_enchufes = json['observaciones_enchufes'],
        estatus_apagadores = json['estatus_apagadores'],
        observaciones_apagadores = json['observaciones_apagadores'],
        estatus_cortinas = json['estatus_cortinas'],
        observaciones_cortinas = json['observaciones_cortinas'],
        estatus_mueble_ropa = json['estatus_mueble_ropa'],
        observaciones_mueble_ropa = json['observaciones_mueble_ropa'],
        notas = json['notas'] ?? '',
        estatus_access_point = json['estatus_access_point'],
        observaciones_access_point = json['observaciones_access_point'],
        estatus_internet = json['estatus_internet'],
        observaciones_internet = json['observaciones_internet'],
        estatus_television = json['estatus_television'],
        observaciones_television = json['observaciones_television'],
        estatus_sala = json['estatus_sala'],
        observaciones_sala = json['observaciones_sala'],
        estatus_menaje_cocina = json['estatus_menaje_cocina'],
        observaciones_menaje_cocina = json['observaciones_menaje_cocina'],
        estatus_refrigerador = json['estatus_refrigerador'],
        observaciones_refrigerador = json['observaciones_refrigerador'],
        estatus_horno_microondas = json['estatus_horno_microondas'],
        observaciones_horno_microondas = json['observaciones_horno_microondas'],
        estatus_estufa = json['estatus_estufa'],
        observaciones_estufa = json['observaciones_estufa'],
        estatus_lavadora = json['estatus_lavadora'],
        observaciones_lavadora = json['observaciones_lavadora'],
        estatus_area_tendido = json['estatus_area_tendido'],
        observaciones_area_tendido = json['observaciones_area_tendido'],
        estatus_video_vigilancia = json['estatus_video_vigilancia'],
        observaciones_video_vigilancia = json['observaciones_video_vigilancia'],
        created_at = json['created_at'] ?? '',
        updated_at = json['updated_at'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'estatus': estatus,
        'residente_id': residente_id,
        'habitacion_id': habitacion_id,
        'fecha_inicio': fecha_inicio,
        'fecha_fin': fecha_fin,
        'deposito_num': deposito_num,
        'deposito_text': deposito_text,
        'renta_num': renta_num,
        'renta_text': renta_text,
        'firma': firma,
        'notas': notas,
        'estatus_cama': estatus_cama,
        'observaciones_cama': observaciones_cama,
        'estatus_colchon': estatus_colchon,
        'observaciones_colchon': observaciones_colchon,
        'estatus_focos': estatus_focos,
        'observaciones_focos': observaciones_focos,
        'estatus_ventana_vidrios': estatus_ventana_vidrios,
        'observaciones_ventana_vidrios': observaciones_ventana_vidrios,
        'estatus_pintura': estatus_pintura,
        'observaciones_pintura': observaciones_pintura,
        'estatus_perforacion_pared': estatus_perforacion_pared,
        'observaciones_perforacion_pared': observaciones_perforacion_pared,
        'estatus_puertas_rayones': estatus_puertas_rayones,
        'observaciones_puertas_rayones': observaciones_puertas_rayones,
        'estatus_chapa': estatus_chapa,
        'observaciones_chapa': observaciones_chapa,
        'estatus_juego_llaves': estatus_juego_llaves,
        'observaciones_juego_llaves': observaciones_juego_llaves,
        'estatus_regadera_fugas': estatus_regadera_fugas,
        'observaciones_regadera_fugas': observaciones_regadera_fugas,
        'estatus_taza_bano_roturas': estatus_taza_bano_roturas,
        'observaciones_taza_bano_roturas': observaciones_taza_bano_roturas,
        'estatus_lavabo_roturas': estatus_lavabo_roturas,
        'observaciones_lavabo_roturas': observaciones_lavabo_roturas,
        'estatus_chapa_ventana': estatus_chapa_ventana,
        'observaciones_chapa_ventana': observaciones_chapa_ventana,
        'estatus_enchufes': estatus_enchufes,
        'observaciones_enchufes': observaciones_enchufes,
        'estatus_apagadores': estatus_apagadores,
        'observaciones_apagadores': observaciones_apagadores,
        'estatus_cortinas': estatus_cortinas,
        'observaciones_cortinas': observaciones_cortinas,
        'estatus_mueble_ropa': estatus_mueble_ropa,
        'observaciones_mueble_ropa': observaciones_mueble_ropa,
        'estatus_access_point': estatus_access_point,
        'observaciones_access_point': observaciones_access_point,
        'estatus_internet': estatus_internet,
        'observaciones_internet': observaciones_internet,
        'estatus_television': estatus_television,
        'observaciones_television': observaciones_television,
        'estatus_sala': estatus_sala,
        'observaciones_sala': observaciones_sala,
        'estatus_menaje_cocina': estatus_menaje_cocina,
        'observaciones_menaje_cocina': observaciones_menaje_cocina,
        'estatus_refrigerador': estatus_refrigerador,
        'observaciones_refrigerador': observaciones_refrigerador,
        'estatus_horno_microondas': estatus_horno_microondas,
        'observaciones_horno_microondas': observaciones_horno_microondas,
        'estatus_estufa': estatus_estufa,
        'observaciones_estufa': observaciones_estufa,
        'estatus_lavadora': estatus_lavadora,
        'observaciones_lavadora': observaciones_lavadora,
        'estatus_area_tendido': estatus_area_tendido,
        'observaciones_area_tendido': observaciones_area_tendido,
        'estatus_video_vigilancia': estatus_video_vigilancia,
        'observaciones_video_vigilancia': observaciones_video_vigilancia,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
