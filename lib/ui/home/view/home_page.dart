import 'package:controlelectoral/main.dart';
import 'package:controlelectoral/ui/auth/bloc/auth_bloc.dart';
import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/core/ui/widgets/globo_avatar.dart';
import 'package:controlelectoral/ui/core/ui/widgets/wg_location.dart';
import 'package:controlelectoral/ui/home/bloc/candidaturas_bloc.dart';
import 'package:controlelectoral/ui/home/widgets/item_home.dart';
import 'package:controlelectoral/ui/home/widgets/map_home.dart';
import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    final cedula = authState is AuthStateLoggedIn
        ? authState.user.cedula ?? ''
        : '';

    // 1. Instanciar el BLoC y lanzar el primer evento
    var locationBloc = context.read<LocationBloc>();
    locationBloc.add(InitialLocationEvent(cedula: cedula));
    // 2. Esperar el estado de éxito para lanzar el segundo evento
    locationBloc.stream.firstWhere((state) => state.showLocationHistory).then((
      _,
    ) {
      if (mounted) {
        locationBloc.add(StartTrackingUserEvent(cedula: cedula));
      }
    });
    /*
    context.read<LocationBloc>().add(InitialLocationEvent());
    context.read<LocationBloc>().add(StartTrackingUserEvent());

    context.read<LocationBloc>()
      ..add(InitialLocationEvent(cedula: cedula))
      ..add(StartTrackingUserEvent(cedula: cedula));
      */
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthStateLoggedIn ? authState.user : null;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red[50],
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Welcome ${user?.name}',
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          //Navigator.pushNamed(context, AppNavigator.profile);
                        },
                        child: GloboAvatar(name: user?.name ?? ''),
                      ),
                    ],
                  ),
                  Gap(20),
                  Expanded(
                    child: BlocBuilder<CandidaturasBloc, CandidaturasState>(
                      builder: (context, state) {
                        if (state is CandidaturasInitial) {
                          return Text(
                            'Loading candidaturas...',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                        if (state is CandidaturasFailed) {
                          return Text(
                            'Error: Failed to load candidaturas',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                        if (state is CandidaturasLoaded) {
                          return ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState
                                      ?.pushNamedAndRemoveUntil(
                                        AppNavigator.votaciones,
                                        (route) => false,
                                        arguments: state.candidaturas[index],
                                      );
                                },
                                child: ItemHome(
                                  candidatura: state.candidaturas[index],
                                ),
                              );
                            },
                            itemCount: state.candidaturas.length,
                          );
                        }
                        return Text(
                          'Unknown state',
                          style: TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  ),
                  Gap(20),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (dialogContext) {
                        // 1. Obtener la cédula una sola vez usando el context original
                        final authState = context.read<AuthBloc>().state;
                        final String cedula = authState is AuthStateLoggedIn
                            ? authState.user.cedula ?? ''
                            : '';
                        // 2. Retornar el BlocProvider limpio
                        return BlocProvider(
                          create: (_) {
                            final bloc = context.read<LocationBloc>();
                            // 1. Añade el primer evento inmediatamente
                            bloc.add(InitialLocationEvent(cedula: cedula));
                            // 2. Agenda el segundo evento para el siguiente ciclo del event loop
                            // Esto garantiza que el BLoC registre primero el evento de inicialización
                            Future.microtask(() {
                              bloc.add(StartTrackingUserEvent(cedula: cedula));
                            });
                            return bloc;
                          },
                          child: MapHome(user: user),
                        );
                      },
                    );
                  },
                  child: WgLocation(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Sincronizar con el servidor'),
          ),
        ),
      ),
    );
  }
}
