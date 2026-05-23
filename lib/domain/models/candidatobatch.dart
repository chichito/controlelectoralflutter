import 'dart:convert';
import 'dart:typed_data';

CandidatoBatch candidatoBatchFromJson(String str) =>
    CandidatoBatch.fromJson(json.decode(str));

String candidatoBatchToJson(CandidatoBatch data) => json.encode(data.toJson());

class CandidatoBatch {
  final String? codigo;
  final String? codigocandidatura;
  final String? codigolista;
  final String nombre;
  final Uint8List? imageUrl;

  CandidatoBatch({
    this.codigo,
    this.codigocandidatura,
    this.codigolista,
    required this.nombre,
    this.imageUrl,
  });

  factory CandidatoBatch.fromJson(Map<dynamic, dynamic> json) => CandidatoBatch(
    codigo: json["codigo"],
    codigocandidatura: json["codigocandidatura"],
    codigolista: json["codigolista"],
    nombre: json["nombre"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "codigocandidatura": codigocandidatura,
    "codigolista": codigolista,
    "nombre": nombre,
    "imageUrl": imageUrl,
  };

  // Obtener una lista de Listas a partir de un array de Maps
  static List<CandidatoBatch> fromJsonArray(List object) {
    return object.map((item) {
      return CandidatoBatch.fromJson(item);
    }).toList()..sort((a, b) => a.nombre.compareTo(b.nombre));
  }

  Map<String, dynamic> toMap() {
    return {
      "codigo": codigo,
      "codigocandidatura": codigocandidatura,
      "codigolista": codigolista,
      "nombre": nombre,
      "imageUrl": imageUrl,
    };
  }
}
