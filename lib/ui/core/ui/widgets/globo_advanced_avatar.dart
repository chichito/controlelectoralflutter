import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

class GloboAdvancedAvatar extends StatelessWidget {
  const GloboAdvancedAvatar({
    super.key,
    this.photoUrl,
    required this.name,
    this.radius = 50,
  });

  final String? photoUrl;
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return (photoUrl != null)
        ? CircleAvatar(backgroundImage: NetworkImage(photoUrl!), radius: radius)
        : AdvancedAvatar(name: name, size: radius);
  }
}
