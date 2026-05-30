import 'dart:convert';

Votacion votacionFromJson(String str) => Votacion.fromJson(json.decode(str));

String votacionToJson(Votacion data) => json.encode(data.toJson());

class Votacion {
  final int? id;
  final String codigocandidatura;
  final String codigocandidato;
  final String codigolista;
  final String codigousuario;
  final DateTime? fechahoraregistro;
  final double? latitud;
  final double? longitud;
  final double? distancia;
  final int? synced;

  Votacion({
    this.id,
    required this.codigocandidatura,
    required this.codigocandidato,
    required this.codigolista,
    required this.codigousuario,
    this.fechahoraregistro,
    this.latitud,
    this.longitud,
    this.distancia,
    this.synced,
  });

  factory Votacion.fromJson(Map<dynamic, dynamic> json) => Votacion(
    id: json["id"],
    codigocandidatura: json["codigocandidatura"],
    codigocandidato: json["codigocandidato"],
    codigolista: json["codigolista"],
    codigousuario: json["codigousuario"],
    fechahoraregistro: json["fechahoraregistro"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    distancia: json["distancia"],
    synced: json["synced"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "codigocandidatura": codigocandidatura,
    "codigocandidato": codigocandidato,
    "codigolista": codigolista,
    "codigousuario": codigousuario,
    "fechahoraregistro": fechahoraregistro?.toIso8601String(),
    "latitud": latitud,
    "longitud": longitud,
    "distancia": distancia,
    "synced": synced,
  };

  // Obtener una lista de Users a partir de un array de Maps
  static List<Votacion> fromJsonArray(List object) {
    return object.map((item) {
      return Votacion.fromJson(item);
    }).toList()..sort((a, b) => a.codigolista.compareTo(b.codigolista));
  }

  Map<String, dynamic> toMap() {
    return {
      "codigocandidatura": codigocandidatura,
      "codigocandidato": codigocandidato,
      "codigolista": codigolista,
      "codigousuario": codigousuario,
      "fechahoraregistro": fechahoraregistro?.toIso8601String(),
      "latitud": latitud,
      "longitud": longitud,
      "distancia": distancia,
    };
  }
}
