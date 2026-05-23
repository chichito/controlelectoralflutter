part of 'location_bloc.dart';

class LocationEvent {}

// Evento para obtener la ubicación inicial del usuario
class InitialLocationEvent extends LocationEvent {}

// Evento para obtener actualizaciones de la posición del usuario
class StartTrackingUserEvent extends LocationEvent {
  final String cedula;
  StartTrackingUserEvent({required this.cedula});
}

// Evento para mostrar/ocultar la ruta del historial de ubicaciones
class ToggleShowLocationEvent extends LocationEvent {}
