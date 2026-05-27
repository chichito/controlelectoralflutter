part of 'location_bloc.dart';

class LocationState {
  final LatLng? lastKnownLocation;
  final List<LatLng> locationHistory;
  final bool showLocationHistory;
  final double speed;
  final double distance;
  final List<Ubicacion> lstUbicaciones;

  LocationState({
    this.lastKnownLocation,
    this.locationHistory = const [],
    this.showLocationHistory = false,
    this.speed = 0.0,
    this.distance = 0.0,
    this.lstUbicaciones = const [],
  });

  LocationState copyWith({
    LatLng? lastKnownLocation,
    List<LatLng>? locationHistory,
    bool? showLocationHistory,
    double? speed,
    double? distance,
    List<Ubicacion>? lstUbicaciones,
  }) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      locationHistory: locationHistory ?? this.locationHistory,
      showLocationHistory: showLocationHistory ?? this.showLocationHistory,
      speed: speed ?? this.speed,
      distance: distance ?? this.distance,
      lstUbicaciones: lstUbicaciones ?? this.lstUbicaciones,
    );
  }
}

class LocationLoaded extends LocationState {}
