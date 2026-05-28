import 'package:controlelectoral/domain/models/user.dart';
import 'package:controlelectoral/ui/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TrackHome extends StatefulWidget {
  final User? user;
  const TrackHome({super.key, this.user});

  @override
  State<TrackHome> createState() => _TrackHomeState();
}

class _TrackHomeState extends State<TrackHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: size.width * 0.70,
        height: size.height * 0.80,
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
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Tracking [${widget.user!.name}]",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                BlocConsumer<LocationBloc, LocationState>(
                  listener: (context, state) {
                    CircularProgressIndicator.adaptive();
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.lstUbicaciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 30,
                                color: Colors.amber,
                                child: Center(
                                  child: Text((index + 1).toString()),
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 40,
                                  color: Colors.grey,
                                  child: Center(
                                    child: RichText(
                                      maxLines: 2,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: DateFormat('yyyy-MM-dd h:mm:ss')
                                            .format(
                                              state
                                                  .lstUbicaciones[index]
                                                  .fechahoraregistro!,
                                            ),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  color: Colors.blueGrey,
                                  child: Center(
                                    child: Text(
                                      state.lstUbicaciones[index].latitud
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  color: Colors.teal,
                                  child: Center(
                                    child: Text(
                                      state.lstUbicaciones[index].longitud
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 40,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      state.lstUbicaciones[index].distancia
                                          .toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('salir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
