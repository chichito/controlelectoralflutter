part of 'votaciones_bloc.dart';

class VotacionesEvent {}

class GetVotacionEvent extends VotacionesEvent {}

class SetVotacionEvent extends VotacionesEvent {
  final Votacion votacion;

  SetVotacionEvent({required this.votacion});
}
