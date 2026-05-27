part of 'location_bloc.dart';

class LocationEvent {}

// Evento para obtener la ubicación inicial del usuario
class InitialLocationEvent extends LocationEvent {
  final String cedula;

  InitialLocationEvent({required this.cedula});
}

// Evento para obtener actualizaciones de la posición del usuario
class StartTrackingUserEvent extends LocationEvent {
  final String cedula;
  StartTrackingUserEvent({required this.cedula});
}

// Evento para mostrar/ocultar la ruta del historial de ubicaciones
class ToggleShowLocationEvent extends LocationEvent {}

class GetTrackingUserEvent extends LocationEvent {
  final String sCedula;

  GetTrackingUserEvent({required this.sCedula});
}
