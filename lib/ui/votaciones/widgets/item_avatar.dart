import 'package:controlelectoral/domain/models/candidato.dart';
import 'package:controlelectoral/ui/core/ui/widgets/globo_avatar.dart';
import 'package:flutter/material.dart';

class ItemAvatar extends StatefulWidget {
  const ItemAvatar({super.key, required this.candidato});

  final Candidato candidato;

  @override
  State<ItemAvatar> createState() => _ItemAvatarState();
}

class _ItemAvatarState extends State<ItemAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 350,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey, // Change color here
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.candidato.imageUrllista!.isNotEmpty
              ? Image.memory(
                  widget.candidato.imageUrllista!,
                  fit: BoxFit.scaleDown,
                  width: 50,
                  height: 50,
                )
              : const Text('No hay imagen para mostrar'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: RichText(
                  maxLines: 4,
                  softWrap: true,
                  text: TextSpan(
                    text: widget.candidato.nombrelista ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GloboAvatar(name: widget.candidato.codigolista ?? ''),
            ],
          ),
          const SizedBox(height: 8),
          widget.candidato.imageUrllista!.isNotEmpty
              ? PhysicalModel(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  elevation: 5.0,
                  child: Image.memory(
                    widget.candidato.imageUrllista!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                )
              : const Text('No hay imagen para mostrar'),
          const SizedBox(height: 8),
          Flexible(
            child: RichText(
              maxLines: 4,
              softWrap: true,
              text: TextSpan(
                text: widget.candidato.nombre ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
 */
