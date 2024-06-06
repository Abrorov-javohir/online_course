import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Sahifasi"),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text("Profil sahifasiga xush kelibsiz!"),
          ),
        ],
      ),
    );
  }
}