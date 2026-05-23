import 'package:controlelectoral/domain/models/candidato.dart';
import 'package:controlelectoral/domain/models/candidatobatch.dart';

abstract class CandidatoRepository {
  // funcion para enviar mensajes y gaurdar en la base de datos
  Future<Candidato> sendCandidato(Candidato candidato);

  // Obtener la lista de candidatos del sistema
  Future<List<Candidato>> getAllCandidatos(String candidaturaCodigo);
  Future<CandidatoBatch> sendCandidatoBatch(CandidatoBatch candidatoBatch);
  Future<List<Candidato>?> batchInsertCandidatos(
    List<CandidatoBatch> candidatoList,
  );
}
