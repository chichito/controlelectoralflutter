import 'package:flutter/material.dart';

class ErrorDBPage extends StatelessWidget {
  const ErrorDBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error DB')),
      body: const Center(
        child: Text('Error al conectar con la base de datos!'),
      ),
    );
  }
}
