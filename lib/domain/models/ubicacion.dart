import 'dart:convert';

Ubicacion ubicacionFromJson(String str) => Ubicacion.fromJson(json.decode(str));

String ubicacionToJson(Ubicacion data) => json.encode(data.toJson());

class Ubicacion {
  final int? id;
  final String cedula;
  final double? latitud;
  final double? longitud;
  final double? distancia;
  final DateTime? fechahoraregistro;
  final int? synced;

  Ubicacion({
    this.id,
    required this.cedula,
    this.latitud,
    this.longitud,
    this.distancia,
    this.fechahoraregistro,
    this.synced,
  });

  factory Ubicacion.fromJson(Map<dynamic, dynamic> json) => Ubicacion(
    id: json["id"],
    cedula: json["cedula"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    distancia: json["distancia"],
    fechahoraregistro: json["fechahoraregistro"],
    synced: json["synced"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cedula": cedula,
    "latitud": latitud,
    "longitud": longitud,
    "distancia": distancia,
    "fechahoraregistro": fechahoraregistro?.toIso8601String(),
    "synced": synced,
  };

  // Obtener una lista de Ubicacion a partir de un array de Maps
  static List<Ubicacion> fromJsonArray(List object) {
    return object.map((item) {
      return Ubicacion.fromJson(item);
    }).toList()..sort((a, b) => a.cedula.compareTo(b.cedula));
  }

  Map<String, dynamic> toMap() {
    return {
      "cedula": cedula,
      "latitud": latitud,
      "longitud": longitud,
      "distancia": distancia,
      "fechahoraregistro": fechahoraregistro?.toIso8601String(),
    };
  }
}
