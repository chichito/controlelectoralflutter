import 'package:controlelectoral/domain/models/ubicacion.dart';

abstract class UbicacionRepository {
  // funcion para enviar mensajes y gaurdar en la base de datos
  Future<Ubicacion> sendUbicacion(Ubicacion ubicacion);

  // Obtener la lista de mensajes del chat
  Future<List<Ubicacion>> getAllUbicaciones(String sCedula);
  Future<Ubicacion?> getUbicacionByValidate(String fechaRegistro);
}
