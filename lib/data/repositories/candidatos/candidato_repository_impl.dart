import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:controlelectoral/data/repositories/candidatos/candidato_repository.dart';
import 'package:controlelectoral/domain/models/candidato.dart';
import 'package:controlelectoral/domain/models/candidatobatch.dart';
import 'package:sqflite/sqflite.dart';

class CandidatoRepositoryImpl extends CandidatoRepository {
  @override
  Future<Candidato> sendCandidato(Candidato candidato) async {
    final db = await SQLiteHelper().database;
    db.rawInsert(
      'INSERT INTO candidatos (codigo, codigolista, nombre, imageUrl) VALUES (?, ?, ?, ?)',
      [
        candidato.codigo,
        candidato.codigolista,
        candidato.nombre,
        candidato.imageUrl,
      ],
    );
    return candidato;
  }

  @override
  Future<CandidatoBatch> sendCandidatoBatch(
    CandidatoBatch candidatoBatch,
  ) async {
    final db = await SQLiteHelper().database;
    db.insert(
      "candidatos",
      candidatoBatch.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return candidatoBatch;
  }

  @override
  Future<List<Candidato>?> batchInsertCandidatos(
    List<CandidatoBatch> candidatoList,
  ) async {
    final db = await SQLiteHelper().database;
    final batch = db.batch();
    for (final candidatoBatch in candidatoList) {
      await sendCandidatoBatch(candidatoBatch);
    }
    await batch.commit();
    return null;
  }

  @override
  Future<List<Candidato>> getAllCandidatos(String candidaturaCodigo) async {
    final db = await SQLiteHelper().database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT candidatos.*, listas.name AS nombrelista, listas.imageUrl AS imageUrllista FROM candidatos, listas WHERE candidatos.codigolista = listas.codigo AND candidatos.codigocandidatura = ?',
      [candidaturaCodigo],
    );
    return List.generate(maps.length, (index) {
      return Candidato(
        codigo: maps[index]['codigo'],
        codigolista: maps[index]['codigolista'],
        nombrelista: maps[index]['nombrelista'],
        imageUrllista: maps[index]['imageUrllista'],
        nombre: maps[index]['nombre'],
        imageUrl: maps[index]['imageUrl'],
      );
    });
  }
}
