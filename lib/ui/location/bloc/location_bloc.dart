import 'dart:async';

import 'package:controlelectoral/data/repositories/ubicaciones/ubicaciones_repository_impl.dart';
import 'package:controlelectoral/domain/models/ubicacion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  UbicacionRepositoryImpl ubicacionRepository = UbicacionRepositoryImpl();

  LocationBloc() : super(LocationState()) {
    on<InitialLocationEvent>(_onInitialLocationEvent);
    on<StartTrackingUserEvent>(_onStartTrackingUserEvent);
    on<ToggleShowLocationEvent>(_onToggleShowLocationEvent);
    on<GetTrackingUserEvent>(_onGetTrackingUserEvent);
  }

  Future<void> _onInitialLocationEvent(
    InitialLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    final position = await Geolocator.getCurrentPosition();
    final latLang = LatLng(position.latitude, position.longitude);
    final speed = position.speed;
    List<Ubicacion> ubiHistory = await ubicacionRepository.getAllUbicaciones(
      event.cedula,
    );
    final List<LatLng> lstHis = List.generate(ubiHistory.length, (index) {
      return LatLng(
        ubiHistory[index].latitud ?? 0.0,
        ubiHistory[index].longitud ?? 0.0,
      );
    });

    emit(
      state.copyWith(
        lastKnownLocation: latLang,
        speed: speed,
        lstUbicaciones: ubiHistory,
        locationHistory: lstHis,
        showLocationHistory: true,
      ),
    );
    print('llego iniciar');
  }

  Future<void> _onStartTrackingUserEvent(
    StartTrackingUserEvent event,
    Emitter<LocationState> emit,
  ) async {
    return emit.forEach(
      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best, // High precision
          distanceFilter: 10, // Update on every tiny movement
        ),
      ),
      onData: (position) {
        final latLang = LatLng(position.latitude, position.longitude);
        // (lat4, long4)

        // [(lat1, long1), (lat2, long2), (lat3, long3), ]
        final lenghtantes = state.locationHistory.length;
        final List<LatLng> newHistory;
        final speed = position.speed;
        double currentDistance = 0;
        bool isGrabar = false;
        if (lenghtantes == 0) {
          newHistory = [...state.locationHistory, latLang];
          isGrabar = true;
        } else {
          if (state.locationHistory[lenghtantes - 1].latitude ==
                  position.latitude &&
              state.locationHistory[lenghtantes - 1].longitude ==
                  position.longitude) {
            newHistory = state.locationHistory;
            isGrabar = false;
          } else {
            newHistory = [...state.locationHistory, latLang];
            final lenght = newHistory.length;
            // [(lat1, long1), (lat2, long2), (lat3, long3), (lat4, long4)]

            if (lenght > 1) {
              currentDistance = Geolocator.distanceBetween(
                newHistory[lenght - 2].latitude,
                newHistory[lenght - 2].longitude,
                position.latitude,
                position.longitude,
              );
            }

            isGrabar = true;
          }
        }

        var updatedList = List<Ubicacion>.from(state.lstUbicaciones);
        if (isGrabar) {
          final ubicacion = Ubicacion(
            cedula: event.cedula,
            latitud: position.latitude,
            longitud: position.longitude,
            distancia: state.distance + currentDistance,
            fechahoraregistro: DateTime.now(),
          );
          // fire-and-forget save to repository to keep onData synchronous
          ubicacionRepository
              .sendUbicacion(ubicacion)
              .then((ubicacionr) {
                updatedList = updatedList..add(ubicacionr);
                //emit(state.copyWith(lstUbicaciones: state.lstUbicaciones));

                print('Grabar en la base de datos: ${ubicacionr.toJson()}');
              })
              .catchError((e) {
                // handle errors if needed
                print('Error al grabar en la base de datos: ${e.toString()}');
              });
        }
        print('start');
        return state.copyWith(
          lastKnownLocation: latLang,
          locationHistory: newHistory,
          speed: speed,
          distance: currentDistance,
          distanceAcumulada: state.distance + currentDistance,
          lstUbicaciones: updatedList,
        );
      },
    );
  }

  void _onToggleShowLocationEvent(
    ToggleShowLocationEvent event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(showLocationHistory: !state.showLocationHistory));
  }

  Future<void> _onGetTrackingUserEvent(
    GetTrackingUserEvent event,
    Emitter<LocationState> emit,
  ) async {
    List<Ubicacion> ubiHistory = await ubicacionRepository.getAllUbicaciones(
      event.sCedula,
    );
    state.copyWith(lstUbicaciones: ubiHistory);
  }
}
