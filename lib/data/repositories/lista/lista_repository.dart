import 'package:controlelectoral/domain/models/lista.dart';

abstract class ListaRepository {
  // funcion para enviar mensajes y gaurdar en la base de datos
  Future<Lista> sendLista(Lista lista);

  // Obtener la lista de listas del sistema
  Future<List<Lista>> getAllListas();
  Future<List<Lista>> batchInsertLista(List<Lista> listaList);
}
