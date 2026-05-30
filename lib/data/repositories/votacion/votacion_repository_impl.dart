import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:controlelectoral/data/repositories/votacion/votaciones_repository.dart';
import 'package:controlelectoral/domain/models/votacion.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class VotacionRepositoryImpl extends VotacionesRepository {
  @override
  Future<Votacion> sendCandidatura(Votacion votacion) async {
    final db = await SQLiteHelper().database;
    db.insert(
      "users",
      votacion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return votacion;
  }

  @override
  Future<List<Votacion>> getAllVotaciones() async {
    final db = await (SQLiteHelper()).database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (index) {
      return Votacion(
        codigocandidatura: '',
        codigocandidato: '',
        codigolista: '',
        codigousuario: '',
      );
    });
  }
}
