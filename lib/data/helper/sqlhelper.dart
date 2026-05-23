import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:controlelectoral/data/repositories/candidatos/candidato_repository_impl.dart';
import 'package:controlelectoral/data/repositories/candidaturas/candidatura_repository_impl.dart';
import 'package:controlelectoral/data/repositories/lista/lista_repository_impl.dart';
import 'package:controlelectoral/data/repositories/user/user_repository_impl.dart';
import 'package:controlelectoral/domain/models/candidatobatch.dart';
import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:controlelectoral/domain/models/lista.dart';
import 'package:controlelectoral/domain/models/user.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class SQLiteHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    //_database = await initWinDB();
    return _database!;
  }

  // Platform Specific
  void closeDB() async {
    // _database?.close() ?? Future.value();
  }

  Future<Database> initWinDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = Directory.current;
    final dbPath = join(appDocumentsDir.path, "databases", "data.db");
    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(onCreate: _onCreate, version: 1),
    );
  }

  Future<Database> initDB() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      final appDocumentsDir =
          Directory.current; //await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentsDir.path, "databases", "data.db");
      final winLinuxDB = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(version: 1, onCreate: _onCreate),
      );
      return winLinuxDB;
    } else if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, "data.db");
      final iOSAndroidDB = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
      return iOSAndroidDB;
    }

    throw Exception("Unsupported platform");
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;

    await db.execute(""" CREATE TABLE IF NOT EXISTS ubicaciones(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cedula TEXT,
            latitud REAL,
            longitud REAL,
            distancia REAL,
            fechahoraregistro TEXT,
            synced INTEGER DEFAULT 0
          )
 """);

    await db.execute(""" CREATE TABLE IF NOT EXISTS users(
            cedula TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT,
            celular TEXT
          )
 """);
    await db.execute(""" CREATE TABLE IF NOT EXISTS candidaturas(
            codigo TEXT PRIMARY KEY,
            name TEXT,
            imageUrl BLOB
          )
 """);
    await db.execute(""" CREATE TABLE IF NOT EXISTS listas(
            codigo TEXT PRIMARY KEY,
            name TEXT,
            lista TEXT,
            imageUrl BLOB
          )
 """);
    await db.execute(""" CREATE TABLE IF NOT EXISTS candidatos(
            codigo TEXT PRIMARY KEY,
            codigocandidatura TEXT,
            codigolista TEXT,
            nombre TEXT,
            imageUrl BLOB
          )
 """);
  }

  Future<void> insertInitialData() async {
    final userRepository = UserRepositoryImpl();
    final listaRepository = ListaRepositoryImpl();
    final candidatoRepository = CandidatoRepositoryImpl();
    final candidaturaRepository = CandidaturasRepositoryImpl();

    // Insertar usuarios de ejemplo
    await userRepository.sendUser(
      User(
        cedula: "111",
        name: "Admin Admin",
        email: "111",
        password: "111",
        celular: "1111",
      ),
    );

    await candidaturaRepository.batchInsertCandidatura([
      Candidatura(
        codigo: '1',
        name: 'Prefectos',
        imageUrl: await getImageBytes(
          'http://192.168.2.5/ImagenCandidatura/Prefectos.jpg',
        ),
      ),
      Candidatura(
        codigo: '2',
        name: 'Alcaldes',
        imageUrl: await getImageBytes(
          'http://192.168.2.5/ImagenCandidatura/Alcaldes.jpg',
        ),
      ),
      Candidatura(codigo: '3', name: 'Concejales', imageUrl: null),
      Candidatura(
        codigo: '4',
        name: 'Presidentes de juntas parroquiales',
        imageUrl: null,
      ),
      Candidatura(
        codigo: '5',
        name: 'Consejeros de juntas parroquiales',
        imageUrl: null,
      ),
    ]);

    await listaRepository.batchInsertLista([
      Lista(
        codigo: '1',
        name: 'Lista uno',
        lista: '1',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com//wp-content/uploads/2026/04/mobil-home-CAT.jpg',
        ),
      ),
      Lista(
        codigo: '2',
        name: 'Lista dos',
        lista: '2',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2026/04/web-home-CAT.jpg',
        ),
      ),
      Lista(
        codigo: '3',
        name: 'Lista tres',
        lista: '3',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      Lista(
        codigo: '4',
        name: 'Lista cuatro',
        lista: '4',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      Lista(
        codigo: '5',
        name: 'Lista cinco',
        lista: '5',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      Lista(
        codigo: '6',
        name: 'Lista seis',
        lista: '6',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
    ]);

    await candidatoRepository.batchInsertCandidatos([
      CandidatoBatch(
        codigo: '1',
        codigocandidatura: '1',
        codigolista: '1',
        nombre: 'Candidato uno',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com//wp-content/uploads/2026/04/mobil-home-CAT.jpg',
        ),
      ),
      CandidatoBatch(
        codigo: '2',
        codigocandidatura: '1',
        codigolista: '2',
        nombre: 'Candidato dos',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2026/04/web-home-CAT.jpg',
        ),
      ),
      CandidatoBatch(
        codigo: '3',
        codigocandidatura: '2',
        codigolista: '3',
        nombre: 'Candidato tres',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      CandidatoBatch(
        codigo: '4',
        codigocandidatura: '2',
        codigolista: '4',
        nombre: 'Candidato cuatro',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      CandidatoBatch(
        codigo: '5',
        codigocandidatura: '2',
        codigolista: '5',
        nombre: 'Candidato cinco',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
      CandidatoBatch(
        codigo: '6',
        codigocandidatura: '2',
        codigolista: '6',
        nombre: 'Candidato seis',
        imageUrl: await getImageBytes(
          'https://tarracoviva.com/wp-content/uploads/2021/05/favicon_tv-2-300x300.png',
        ),
      ),
    ]);
    print("Datos iniciales insertados correctamente");
  }

  Future<Uint8List?> getImageBytes(String url) async {
    try {
      final dio = Dio();

      // 1. Realizar la petición GET especificando ResponseType.bytes
      final response = await dio.get<Uint8List>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      // 2. Obtener los bytes directamente
      return response.data;
    } catch (e) {
      print("Error al descargar la imagen: $e");
      return null;
    }
  }
}
