part of 'candidato_bloc.dart';

class CandidatoState {}

class CandidatoInitial extends CandidatoState {}

class CandidatoLoaded extends CandidatoState {
  final List<Candidato> candidatos;
  CandidatoLoaded({this.candidatos = const []});

  CandidatoLoaded copyWith({List<Candidato>? candidatos}) {
    return CandidatoLoaded(candidatos: candidatos ?? this.candidatos);
  }
}

class CandidatoFailed extends CandidatoState {}
