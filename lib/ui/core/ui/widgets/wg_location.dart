import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WgLocation extends StatelessWidget {
  const WgLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state.lastKnownLocation?.latitude != null) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //spacing: 12,
                          children: [
                            Text('Lat: ${state.lastKnownLocation?.latitude}'),
                            VerticalDivider(color: Colors.grey[300]),
                            Text('Lon: ${state.lastKnownLocation?.longitude}'),
                            //VerticalDivider(color: Colors.grey[300]),
                            //Text('Distancia: ${state.distance}'),
                          ],
                        ),
                        Text('Dis: ${state.distanceAcumulada}'),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator.adaptive();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
