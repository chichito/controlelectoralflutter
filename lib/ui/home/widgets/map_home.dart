import 'package:controlelectoral/domain/models/user.dart';
import 'package:controlelectoral/ui/auth/bloc/auth_bloc.dart';
import 'package:controlelectoral/ui/home/widgets/track_home.dart';
import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapHome extends StatelessWidget {
  final User? user;
  const MapHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: size.width * 0.90,
            height: size.height * 0.90,
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                return FlutterMap(
                  options: MapOptions(
                    initialCenter:
                        state.lastKnownLocation ??
                        (state.locationHistory.isNotEmpty
                            ? state.locationHistory.last
                            : LatLng(0, 0)),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.controlelectoral',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.locationHistory,
                          color: Colors.blue,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'El usuario: ${user!.name}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => BlocProvider(
                        create: (context) => LocationBloc()
                          ..add(
                            InitialLocationEvent(
                              cedula:
                                  context.read<AuthBloc>().state
                                      is AuthStateLoggedIn
                                  ? (context.read<AuthBloc>().state
                                                as AuthStateLoggedIn)
                                            .user
                                            .cedula ??
                                        ''
                                  : '',
                            ),
                          )
                          ..add(
                            StartTrackingUserEvent(
                              cedula:
                                  context.read<AuthBloc>().state
                                      is AuthStateLoggedIn
                                  ? (context.read<AuthBloc>().state
                                                as AuthStateLoggedIn)
                                            .user
                                            .cedula ??
                                        ''
                                  : '',
                            ),
                          ),
                        child: TrackHome(user: user),
                      ),
                    );
                  },
                  child: Text('Reportee'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('salir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
