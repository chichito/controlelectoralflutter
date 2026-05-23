import 'package:controlelectoral/domain/models/candidatura.dart';
import 'package:controlelectoral/ui/core/ui/widgets/globo_advanced_avatar.dart';
import 'package:flutter/material.dart';

class ItemHome extends StatelessWidget {
  const ItemHome({super.key, required this.candidatura});
  final Candidatura candidatura;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.blueGrey.shade100,
      clipBehavior: Clip
          .antiAliasWithSaveLayer, // Ensures image follows card's rounded corners
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          candidatura.imageUrl != null
              ? Container(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                    ),
                    child: Image.memory(
                      candidatura.imageUrl!,
                      fit: BoxFit.fill,
                      height: 90,
                      width: 90,
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  height: 90,
                  width: 90,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.image, size: 48, color: Colors.grey),
                ),
          Flexible(
            flex: 1,
            child: FractionallySizedBox(
              widthFactor:
                  0.90, // Define que ocupará el 90% del espacio de su padre
              alignment: Alignment.centerLeft,
              child: RichText(
                maxLines: 4,
                softWrap: true,
                text: TextSpan(
                  text: candidatura.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: GloboAdvancedAvatar(name: '23'),
          ),
        ],
      ),
    );
  }
}
