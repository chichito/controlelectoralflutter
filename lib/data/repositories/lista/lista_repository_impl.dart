import 'package:controlelectoral/data/helper/sqlhelper.dart';
import 'package:controlelectoral/data/repositories/lista/lista_repository.dart';
import 'package:controlelectoral/domain/models/lista.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ListaRepositoryImpl extends ListaRepository {
  @override
  Future<Lista> sendLista(Lista lista) async {
    final db = await SQLiteHelper().database;
    db.insert(
      "listas",
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lista;
  }

  Future<List<Lista>> batchInsertLista(List<Lista> listaList) async {
    final db = await SQLiteHelper().database;
    final batch = db.batch();
    for (final lista in listaList) {
      await sendLista(lista);
    }
    await batch.commit();
    return await getAllListas();
  }

  @override
  Future<List<Lista>> getAllListas() async {
    final db = await SQLiteHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('listas');
    return List.generate(maps.length, (index) {
      return Lista(
        codigo: maps[index]['codigo'],
        name: maps[index]['name'],
        lista: maps[index]['lista'],
        imageUrl: maps[index]['imageUrl'],
      );
    });
  }
}
