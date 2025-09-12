import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitforge_onboarding_professional/onboarding/onboarding_welcome.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _workoutRemindersEnabled = true;
  String _selectedUnit = 'Metric';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Section: Account
            Text("Account", style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Account Settings'),
                    subtitle: const Text('Profile, privacy & security'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      debugPrint("Navigate to Account Settings");
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      _auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const OnboardingWelcome()),
                            (route) => false,
                      );
                      debugPrint('User signed out');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section: Preferences
            Text("Preferences", style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_active),
                    title: const Text('Workout Reminders'),
                    subtitle: const Text('Daily at 7:00 AM'),
                    value: _workoutRemindersEnabled,
                    onChanged: (val) {
                      setState(() => _workoutRemindersEnabled = val);
                      // Add reminder logic here
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.straighten),
                    title: const Text('Units'),
                    subtitle: Text(_selectedUnit),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _showUnitSelectionDialog(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section: Support
            Text("Support", style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help & FAQ'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      debugPrint("Navigate to Help Page");
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About FitForge'),
                    subtitle: const Text('Version 1.0.0'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'FitForge',
                        applicationVersion: '1.0.0',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUnitSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Select Units'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Metric (kg, cm)'),
                value: 'Metric',
                groupValue: _selectedUnit,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedUnit = value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Imperial (lb, in)'),
                value: 'Imperial',
                groupValue: _selectedUnit,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedUnit = value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
