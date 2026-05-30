import 'package:controlelectoral/domain/models/votacion.dart';

abstract class VotacionesRepository {
  // funcion para enviar mensajes y gaurdar en la base de datos
  Future<Votacion> sendCandidatura(Votacion votacion);

  // Obtener la lista de candidaturas del sistema
  Future<List<Votacion>> getAllVotaciones();
}
