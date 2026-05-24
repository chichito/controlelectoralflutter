import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WgLocation extends StatelessWidget {
  const WgLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Text('Ubicación actual:'),
              BlocConsumer<LocationBloc, LocationState>(
                listener: (BuildContext context, LocationState state) {},
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //spacing: 12,
                        children: [
                          Text('Latitud: ${state.lastKnownLocation?.latitude}'),
                          VerticalDivider(color: Colors.grey[300]),
                          Text(
                            'Longitud: ${state.lastKnownLocation?.longitude}',
                          ),
                          //VerticalDivider(color: Colors.grey[300]),
                          //Text('Distancia: ${state.distance}'),
                        ],
                      ),
                      Text('Distancia: ${state.distance}'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
