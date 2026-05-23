import 'package:controlelectoral/domain/models/lista.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.lista});
  final Lista lista;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // 2. Transform the card (Scale & Translation)
        transform: isHovered
            ? (Matrix4.identity()
                ..translate(0, -10)
                ..scale(1.02))
            : Matrix4.identity(),
        child: Card(
          // 3. Dynamic elevation for a shadow "lift" effect
          //elevation: isHovered ? 12 : 4,
          child: Container(
            width: 200,
            height: 150,
            alignment: Alignment.center,
            child: Text(widget.lista.name),
          ),
        ),
      ),
    );
  }
}
