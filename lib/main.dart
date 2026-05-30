import 'package:bot_toast/bot_toast.dart';
import 'package:controlelectoral/ui/auth/bloc/auth_bloc.dart';
import 'package:controlelectoral/ui/auth/view/auth_handler.dart';
import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/core/themes/theme.dart';
import 'package:controlelectoral/ui/db/bloc/db_bloc.dart';
import 'package:controlelectoral/ui/error/error_db.dart';
import 'package:controlelectoral/ui/fecha_hora/bloc/clock_bloc.dart';
import 'package:controlelectoral/ui/home/bloc/candidaturas_bloc.dart';
import 'package:controlelectoral/ui/home/view/home_page.dart';
import 'package:controlelectoral/ui/location/bloc/gps_bloc.dart';
import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:controlelectoral/ui/location/pages/gps_page.dart';
import 'package:controlelectoral/ui/location/widgets/enable_gps.dart';
import 'package:controlelectoral/ui/location/widgets/permissions_gps.dart';
import 'package:controlelectoral/ui/login/cubit/login_cubit.dart';
import 'package:controlelectoral/ui/login/view/login_page.dart';
import 'package:controlelectoral/ui/root/view/root_page.dart';
import 'package:controlelectoral/ui/votaciones/bloc/candidato_bloc.dart';
import 'package:controlelectoral/ui/votaciones/bloc/lista_bloc.dart';
import 'package:controlelectoral/ui/votaciones/bloc/votaciones_bloc.dart';
import 'package:controlelectoral/ui/votaciones/view/votaciones_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  /*
return MultiBlocProvider(
      providers: [
        BlocProvider<DbBloc>(
          create: (context) => DbBloc()..add(DBInitialStatusEvent()),
        ),
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (context) => AuthBloc()..add(CheckUserEvent()),
        ),
      ],
 */
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GpsBloc()
            ..add(GpsInitialStatusEvent())
            ..add(ChangeGpsStatusEvent()),
        ),
        BlocProvider<DbBloc>(create: (context) => DbBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(context.read<AuthBloc>()),
        ),
      ],
      child: AuthHandler(
        navigatorKey: navigatorKey,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          theme: AppTheme.light,
          builder: BotToastInit(), // 1. Initialize BotToast
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ], // 2. Register observer
          routes: {
            AppNavigator.main: (_) => RootPage(),
            AppNavigator.gpspage: (_) => GpsPage(),
            AppNavigator.enableGps: (_) => EnableGps(),
            AppNavigator.permissionsGps: (_) => PermissionsGps(),
            AppNavigator.errordb: (_) => ErrorDBPage(),
            AppNavigator.login: (_) => LoginPage(),
            AppNavigator.home: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
                BlocProvider<CandidaturasBloc>(
                  create: (context) =>
                      CandidaturasBloc()..add(GetCandidaturasEvent()),
                ),
                BlocProvider<ClockBloc>(
                  create: (context) => ClockBloc()..add(StartClock()),
                ),
              ],
              child: HomePage(),
            ),
            AppNavigator.votaciones: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<ClockBloc>(
                  create: (context) => ClockBloc()..add(StartClock()),
                ),
                BlocProvider<ListaBloc>(create: (context) => ListaBloc()),
                BlocProvider<CandidatoBloc>(
                  create: (context) => CandidatoBloc(),
                ),
                BlocProvider<VotacionesBloc>(
                  create: (context) => VotacionesBloc(),
                ),
              ],
              child: VotacionesPage(),
            ),
          },
        ),
      ),
    );
  }
}

/*
 return BlocProvider(
      create: (context) => DbBloc()..add(DBInitialStatusEvent()),
      child: AuthHandler(
        navigatorKey: navigatorKey,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          theme: AppTheme.light,
          builder: BotToastInit(), // 1. Initialize BotToast
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ], // 2. Register observer
          routes: {
            AppNavigator.main: (_) => RootPage(),
            AppNavigator.login: (_) => MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
                BlocProvider<LoginCubit>(
                  create: (context) =>
                      LoginCubit(authBloc: BlocProvider.of<AuthBloc>(context)),
                ),
              ],
              child: LoginPage(),
            ),
            //AppNavigator.signUp: (context) => const SignUpPage(),
            AppNavigator.votaciones: (_) => const VotacionesPage(),
            //AppNavigator.profile: (context) => const ProfilePage(),
          },
        ),
      ),
    );
 */
