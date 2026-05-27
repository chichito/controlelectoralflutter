import 'package:controlelectoral/ui/home/widgets/track_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapHome extends StatelessWidget {
  const MapHome({super.key});

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
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(-2.170998, -79.922359),
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.controlelectoral',
                ),
                //PolylineLayer(
                  //polylines: [
                    //Polyline(points: State.)
                  //],
                //),
              ],
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
                      builder: (context) => TrackHome(),
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
