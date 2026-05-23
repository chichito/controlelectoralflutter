import 'dart:convert';
import 'dart:typed_data';

Candidato candidatoFromJson(String str) => Candidato.fromJson(json.decode(str));

String candidatoToJson(Candidato data) => json.encode(data.toJson());

class Candidato {
  final String? codigo;
  final String? codigocandidatura;
  final String? nombrecandidatura;
  final String? codigolista;
  final String? nombrelista;
  final Uint8List? imageUrllista;
  final String? nombre;
  final Uint8List? imageUrl;

  Candidato({
    this.codigo,
    this.codigocandidatura,
    this.nombrecandidatura,
    this.codigolista,
    this.nombrelista,
    this.imageUrllista,
    this.nombre,
    this.imageUrl,
  });

  factory Candidato.fromJson(Map<dynamic, dynamic> json) => Candidato(
    codigo: json["codigo"],
    codigocandidatura: json["codigocandidatura"],
    nombrecandidatura: json["nombrecandidatura"],
    codigolista: json["codigolista"],
    nombrelista: json["nombrelista"],
    imageUrllista: json["imageUrllista"],
    nombre: json["nombre"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "codigocandidatura": codigocandidatura,
    "nombrecandidatura": nombrecandidatura,
    "codigolista": codigolista,
    "nombrelista": nombrelista,
    "imageUrllista": imageUrllista,
    "nombre": nombre,
    "imageUrl": imageUrl,
  };

  Map<String, dynamic> toMap() {
    return {
      "codigo": codigo,
      "codigocandidatura": codigocandidatura,
      "nombrecandidatura": nombrecandidatura,
      "codigolista": codigolista,
      "nombrelista": nombrelista,
      "imageUrllista": imageUrllista,
      "nombre": nombre,
      "imageUrl": imageUrl,
    };
  }
}
