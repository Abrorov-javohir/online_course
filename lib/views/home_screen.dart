import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh Sahifa"),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/ikkinchi-sahifa',
              arguments: "Javohir Bro Pro Max!",
            );
          },
          child: const Text("Ikkinchi Sahifaga o'tish"),
        ),
      ),
    );
  }
}