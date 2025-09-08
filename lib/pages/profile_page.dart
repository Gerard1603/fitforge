import 'package:flutter/material.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: scheme.primaryContainer,
              child: Icon(Icons.person, size: 50, color: scheme.onPrimaryContainer),
            ),
            const SizedBox(height: 14),
            Text("John Doe",
                style: Theme.of(context).textTheme.titleMedium),
            Text("john.doe@email.com",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
