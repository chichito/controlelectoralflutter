part of 'lista_bloc.dart';

class ListaState {}

class ListaInitial extends ListaState {}

class ListaLoaded extends ListaState {
  final List<Lista> listas;
  ListaLoaded({this.listas = const []});

  ListaLoaded copyWith({List<Lista>? listas}) {
    return ListaLoaded(listas: listas ?? this.listas);
  }
}

class ListaFailed extends ListaState {}
