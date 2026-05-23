import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:controlelectoral/main.dart';
import 'package:controlelectoral/ui/auth/bloc/auth_bloc.dart';
import 'package:controlelectoral/ui/core/navigation/app_navigator.dart';
import 'package:controlelectoral/ui/core/ui/widgets/globo_avatar.dart';
import 'package:controlelectoral/ui/fecha_hora/bloc/clock_bloc.dart';
import 'package:controlelectoral/ui/votaciones/bloc/candidato_bloc.dart';
import 'package:controlelectoral/ui/votaciones/widgets/item_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VotacionesPage extends StatefulWidget {
  const VotacionesPage({super.key});
  @override
  State<VotacionesPage> createState() => _VotacionesPageState();
}

class _VotacionesPageState extends State<VotacionesPage> {
  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration.zero, () {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Candidatura? candidatura =
          ModalRoute.of(context)!.settings.arguments as Candidatura?;
      context.read<CandidatoBloc>().add(
        GetCandidatoEvent(candidatura: candidatura!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final user = authState is AuthStateLoggedIn ? authState.user : null;
    final Candidatura? candidatura =
        ModalRoute.of(context)!.settings.arguments as Candidatura?;

    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<ClockBloc, ClockState>(
                      builder: (context, state) {
                        final now = state.now;

                        return Text(
                          'Welcome ${user?.name} ${now.hour}:${now.minute}:${now.second}',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pushNamed(context, AppNavigator.profile);
                      },
                      child: GloboAvatar(name: user?.name ?? ''),
                    ),
                  ],
                ),
                Text(
                  candidatura?.name ?? 'No candidatura selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: const Color.fromARGB(255, 141, 137, 137),
                child: Center(
                  child: BlocBuilder<CandidatoBloc, CandidatoState>(
                    builder: (context, state) {
                      if (state is CandidatoInitial) {
                        return Text(
                          'Loading candidatos...',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      if (state is CandidatoFailed) {
                        return Text(
                          'Error: Failed to load candidatos',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      if (state is CandidatoLoaded) {
                        return GridView.builder(
                          itemCount: state.candidatos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                print(
                                  'Candidato tapped: ${state.candidatos[index].nombre}',
                                );
                              },
                              child: ItemAvatar(
                                candidato: state.candidatos[index],
                              ), //ItemCard(candidato: state.candidatos[index]),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Cantain de columnas
                                mainAxisSpacing:
                                    12.0, // Separación vertical entre filas
                                crossAxisSpacing:
                                    20, // Separación horizontal entre columnas
                                childAspectRatio:
                                    0.7, // Controla la relación ancho/alto de los contenedores
                              ),
                        );
                      }
                      return Text(
                        'Unknown state',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppNavigator.home,
                (route) => false,
              );
            },
            child: const Text('Regresar a elegir candidatura'),
          ),
        ),
      ),
    );
  }
}
