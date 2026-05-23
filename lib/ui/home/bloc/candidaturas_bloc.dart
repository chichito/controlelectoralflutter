import 'package:controlelectoral/data/repositories/candidaturas/candidatura_repository_impl.dart';
import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'candidaturas_event.dart';
part 'candidaturas_state.dart';

class CandidaturasBloc extends Bloc<CandidaturasEvent, CandidaturasState> {
  final CandidaturasRepositoryImpl _candidaturasRepository =
      CandidaturasRepositoryImpl();
  CandidaturasBloc() : super(CandidaturasInitial()) {
    on<GetCandidaturasEvent>(_getCandidaturasEvent);
  }

  Future<void> _getCandidaturasEvent(
    GetCandidaturasEvent event,
    Emitter<CandidaturasState> emit,
  ) async {
    final candidaturas = await _candidaturasRepository.getAllCandidaturas();
    emit(CandidaturasLoaded(candidaturas: candidaturas));
  }
}
