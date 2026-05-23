import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:controlelectoral/data/repositories/candidaturas/candidaturas_repository.dart';
import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class CandidaturasRepositoryImpl extends CandidaturasRepository {
  @override
  Future<Candidatura> sendCandidatura(Candidatura candidatura) async {
    final db = await SQLiteHelper().database;
    db.insert(
      "candidaturas",
      candidatura.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return candidatura;
  }

  @override
  Future<List<Candidatura>> batchInsertCandidatura(
    List<Candidatura> candidaturaList,
  ) async {
    final db = await SQLiteHelper().database;
    final batch = db.batch();
    for (final candidatura in candidaturaList) {
      await sendCandidatura(candidatura);
    }
    await batch.commit();
    return await getAllCandidaturas();
  }

  @override
  Future<List<Candidatura>> getAllCandidaturas() async {
    final db = await SQLiteHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('candidaturas');
    return List.generate(maps.length, (index) {
      return Candidatura(
        codigo: maps[index]['codigo'],
        name: maps[index]['name'],
        imageUrl: maps[index]['imageUrl'],
      );
    });
  }
}
