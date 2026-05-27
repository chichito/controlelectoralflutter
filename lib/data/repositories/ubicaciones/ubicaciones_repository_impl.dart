import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:controlelectoral/data/repositories/ubicaciones/ubicaciones_repository.dart';
import 'package:controlelectoral/domain/models/ubicacion.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class UbicacionRepositoryImpl extends UbicacionRepository {
  @override
  Future<Ubicacion> sendUbicacion(Ubicacion ubicacion) async {
    final db = await SQLiteHelper().database;
    db.insert(
      "ubicaciones",
      ubicacion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return ubicacion;
  }

  @override
  Future<List<Ubicacion>> getAllUbicaciones(String sCedula) async {
    final db = await (SQLiteHelper()).database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM ubicaciones WHERE cedula = ?',
      [sCedula],
    );

    return List.generate(maps.length, (index) {
      return Ubicacion(
        id: maps[index]['id'],
        cedula: maps[index]['cedula'],
        latitud: maps[index]['latitud'],
        longitud: maps[index]['longitud'],
        distancia: maps[index]['distancia'],
        fechahoraregistro: DateTime.parse(maps[index]['fechahoraregistro']),
        synced: maps[index]['synced'],
      );
    });
  }

  @override
  Future<Ubicacion?> getUbicacionByValidate(String fechaRegistro) async {
    final db = await (SQLiteHelper()).database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT id,cedula,latitud,longitud FROM ubicaciones WHERE fechahoraregistro = ?',
      [fechaRegistro],
    );
    if (maps.isNotEmpty) {
      return Ubicacion(
        id: maps[0]['id'],
        cedula: maps[0]['cedula'],
        latitud: maps[0]['latitud'],
        longitud: maps[0]['longitud'],
        distancia: maps[0]['distancia'],
        fechahoraregistro: maps[0]['fechahoraregistro'],
        synced: maps[0]['synced'],
      );
    }
    return null;
  }
}
