import 'package:controlelectoral/main.dart';
import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/location/bloc/gps_bloc.dart';
//import 'package:controlelectoral/ui/location/widgets/enable_gps.dart';
//import 'package:controlelectoral/ui/location/widgets/permissions_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GpsPage extends StatelessWidget {
  const GpsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        if (!state.isLocationPermissionsGranted) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppNavigator.permissionsGps,
            (route) => false,
          );
          //return const PermissionsGps();
        } else if (!state.isGpsEnabled) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppNavigator.enableGps,
            (route) => false,
          );
          //return const EnableGps();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
