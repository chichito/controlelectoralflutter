import 'dart:convert';
import 'dart:typed_data';

Candidatura candidaturaFromJson(String str) =>
    Candidatura.fromJson(json.decode(str));

String candidaturaToJson(Candidatura data) => json.encode(data.toJson());

class Candidatura {
  final String? codigo;
  final String name;
  final Uint8List? imageUrl;

  Candidatura({this.codigo, required this.name, this.imageUrl});

  factory Candidatura.fromJson(Map<dynamic, dynamic> json) => Candidatura(
    codigo: json["codigo"],
    name: json["name"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "name": name,
    "imageUrl": imageUrl,
  };

  // Obtener una lista de Candidaturas a partir de un array de Maps
  static List<Candidatura> fromJsonArray(List object) {
    return object.map((item) {
      return Candidatura.fromJson(item);
    }).toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  Map<String, dynamic> toMap() {
    return {"codigo": codigo, "name": name, "imageUrl": imageUrl};
  }
}
