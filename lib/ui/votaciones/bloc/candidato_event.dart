part of 'candidato_bloc.dart';

class CandidatoEvent {}

class GetCandidatoEvent extends CandidatoEvent {
  final Candidatura candidatura;
  GetCandidatoEvent({required this.candidatura});
}
