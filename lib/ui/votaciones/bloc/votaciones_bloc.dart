import 'dart:async';

import 'package:controlelectoral/data/repositories/votacion/votacion_repository_impl.dart';
import 'package:controlelectoral/domain/models/votacion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'votaciones_event.dart';
part 'votaciones_state.dart';

class VotacionesBloc extends Bloc<VotacionesEvent, VotacionesState> {
  final VotacionRepositoryImpl _votacionRepository = VotacionRepositoryImpl();

  VotacionesBloc() : super(VotacionesInitial()) {
    on<GetVotacionEvent>(_getVotacionEvent);
    on<SetVotacionEvent>(_setVotacionEvent);
  }

  FutureOr<void> _getVotacionEvent(
    VotacionesEvent event,
    Emitter<VotacionesState> emit,
  ) {}

  FutureOr<void> _setVotacionEvent(
    SetVotacionEvent event,
    Emitter<VotacionesState> emit,
  ) {
    print('votacion antes');
    Votacion votacion = Votacion(
      codigocandidatura: event.votacion.codigocandidatura,
      codigocandidato: event.votacion.codigocandidato,
      codigolista: event.votacion.codigolista,
      codigousuario: event.votacion.codigousuario,
      fechahoraregistro: DateTime.now(),
      latitud: 12,
      longitud: 13,
      distancia: 0.0,
    );
    print(votacion.toJson());
  }
}
