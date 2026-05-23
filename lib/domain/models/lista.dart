import 'dart:convert';
import 'dart:typed_data';

Lista listaFromJson(String str) => Lista.fromJson(json.decode(str));

String listaToJson(Lista data) => json.encode(data.toJson());

class Lista {
  final String? codigo;
  final String name;
  final String? lista;
  final Uint8List? imageUrl;

  Lista({this.codigo, required this.name, this.lista, this.imageUrl});

  factory Lista.fromJson(Map<dynamic, dynamic> json) => Lista(
    codigo: json["codigo"],
    name: json["name"],
    lista: json["lista"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "codigo": codigo,
    "name": name,
    "lista": lista,
    "imageUrl": imageUrl,
  };

  // Obtener una lista de Listas a partir de un array de Maps
  static List<Lista> fromJsonArray(List object) {
    return object.map((item) {
      return Lista.fromJson(item);
    }).toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  Map<String, dynamic> toMap() {
    return {
      "codigo": codigo,
      "name": name,
      "lista": lista,
      "imageUrl": imageUrl,
    };
  }
}
