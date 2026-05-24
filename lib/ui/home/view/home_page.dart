import 'package:controlelectoral/main.dart';
import 'package:controlelectoral/ui/auth/bloc/auth_bloc.dart';
import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/core/ui/widgets/globo_avatar.dart';
import 'package:controlelectoral/ui/core/ui/widgets/wg_location.dart';
import 'package:controlelectoral/ui/home/bloc/candidaturas_bloc.dart';
import 'package:controlelectoral/ui/home/widgets/item_home.dart';
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
    // context.read<LocationBloc>().add(InitialLocationEvent());
    // context.read<LocationBloc>().add(StartTrackingUserEvent());

    context.read<LocationBloc>()
      ..add(InitialLocationEvent())
      ..add(
        StartTrackingUserEvent(
          cedula: context.read<AuthBloc>().state is AuthStateLoggedIn
              ? (context.read<AuthBloc>().state as AuthStateLoggedIn)
                        .user
                        .cedula ??
                    ''
              : '',
        ),
      );
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
              Positioned(child: WgLocation()),
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
