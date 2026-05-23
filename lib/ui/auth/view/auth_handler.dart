import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/db/bloc/db_bloc.dart';
import 'package:controlelectoral/ui/location/bloc/gps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthHandler extends StatelessWidget {
  const AuthHandler({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GpsBloc, GpsState>(
          listener: (context, state) {
            if (!state.isAllEnable) {
              if (!state.isLocationPermissionsGranted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    AppNavigator.permissionsGps,
                    (route) => false,
                  );
                });
                //return const PermissionsGps();
              } else if (!state.isGpsEnabled) {
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  AppNavigator.enableGps,
                  (route) => false,
                );
              }
            } else {
              context.read<DbBloc>().add(DBInitialStatusEvent());
            }
          },
        ),
        BlocListener<DbBloc, DbState>(
          listener: (context, state) {
            print(
              'DB State changed: isAllEnable = ${navigatorKey.currentContext}',
            );
            if (state.isAllEnable) {
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppNavigator.login,
                (route) => false,
              );
            } else {
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppNavigator.errordb,
                (route) => false,
              );
            }
          },
        ),
      ],
      child: child,
    );
    /*
    return BlocListener<DbBloc, DbState>(
      listener: (context, state) {
        if (state.isAllEnable) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppNavigator.login,
            (route) => false,
          );
        } else {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            AppNavigator.errordb,
            (route) => false,
          );
        }
      },
      child: child,
    );
    */
  }
}
