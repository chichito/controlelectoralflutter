import 'package:controlelectoral/domain/models/candidatura.dart';

abstract class CandidaturasRepository {
  // funcion para enviar mensajes y gaurdar en la base de datos
  Future<Candidatura> sendCandidatura(Candidatura candidatura);

  // Obtener la lista de candidaturas del sistema
  Future<List<Candidatura>> getAllCandidaturas();
  Future<List<Candidatura>> batchInsertCandidatura(
    List<Candidatura> candidaturaList,
  );
}
