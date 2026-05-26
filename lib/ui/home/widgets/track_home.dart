import 'package:flutter/material.dart';

class TrackHome extends StatelessWidget {
  const TrackHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: size.width * 0.70,
        height: size.height * 0.70,
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
            Column(children: [Text("Listado")]),
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
