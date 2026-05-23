import 'dart:async';

import 'package:controlelectoral/data/repositories/candidatos/candidato_repository_impl.dart';
import 'package:controlelectoral/domain/models/candidato.dart';
import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'candidato_event.dart';
part 'candidato_state.dart';

class CandidatoBloc extends Bloc<CandidatoEvent, CandidatoState> {
  final CandidatoRepositoryImpl _candidatoRepository =
      CandidatoRepositoryImpl();
  CandidatoBloc() : super(CandidatoInitial()) {
    on<GetCandidatoEvent>(_getCandidatoEvent);
  }

  Future<void> _getCandidatoEvent(
    GetCandidatoEvent event,
    Emitter<CandidatoState> emit,
  ) async {
    final candidatura = event.candidatura;
    print('Obteniendo candidatos para la candidatura de: ${candidatura.name}');
    final candidatos = await _candidatoRepository.getAllCandidatos(
      candidatura.codigo!,
    );
    emit(CandidatoLoaded(candidatos: candidatos));
  }
}
