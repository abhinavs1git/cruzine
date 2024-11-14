// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final ValueChanged<bool> onProToggle;

  const ProfilePage({super.key, required this.onProToggle});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isPro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pro Mode'),
            Switch(
              value: isPro,
              onChanged: (value) {
                setState(() {
                  isPro = value;
                  widget.onProToggle(isPro);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
