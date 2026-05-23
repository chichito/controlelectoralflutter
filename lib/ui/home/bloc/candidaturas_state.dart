part of 'candidaturas_bloc.dart';

class CandidaturasState {}

class CandidaturasInitial extends CandidaturasState {}

class CandidaturasLoaded extends CandidaturasState {
  final List<Candidatura> candidaturas;
  CandidaturasLoaded({this.candidaturas = const []});

  CandidaturasLoaded copyWith({List<Candidatura>? candidaturas}) {
    return CandidaturasLoaded(candidaturas: candidaturas ?? this.candidaturas);
  }
}

class CandidaturasFailed extends CandidaturasState {}
