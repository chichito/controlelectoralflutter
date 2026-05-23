import 'dart:async';

import 'package:controlelectoral/data/repositories/lista/lista_repository_impl.dart';
import 'package:controlelectoral/domain/models/lista.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lista_event.dart';
part 'lista_state.dart';

class ListaBloc extends Bloc<ListaEvent, ListaState> {
  final ListaRepositoryImpl _listaRepository = ListaRepositoryImpl();
  ListaBloc() : super(ListaInitial()) {
    on<GetListaEvent>(_onGetListaEvent);
  }

  FutureOr<void> _onGetListaEvent(
    GetListaEvent event,
    Emitter<ListaState> emit,
  ) async {
    final listas = await _listaRepository.getAllListas();
    emit(ListaLoaded(listas: listas));
  }
}
