import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final FirebaseAuth Gauth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          children: [
            // Account section
            ListTile(
              leading: Icon(Icons.person, color: scheme.primary),
              title: const Text('Account'),
              subtitle: const Text('Profile, privacy, security'),
              onTap: () {
                // TODO: Implement navigation to account settings page
                debugPrint('Navigating to Account Settings');
              },
            ),
            const Divider(height: 1),

            // Reminders switch
            SwitchListTile(
              title: const Text('Workout reminders'),
              subtitle: const Text('Daily at 7:00 AM'),
              value: _workoutRemindersEnabled,
              onChanged: (bool value) {
                setState(() {
                  _workoutRemindersEnabled = value;
                });
                // TODO: Implement logic to enable/disable reminders
              },
              secondary: Icon(
                  _workoutRemindersEnabled
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: scheme.primary),
            ),
            const Divider(height: 1),

            // Units selection
            ListTile(
              leading: Icon(Icons.straighten, color: scheme.primary),
              title: const Text('Units'),
              subtitle: Text(_selectedUnit),
              onTap: () {
                _showUnitSelectionDialog(context);
              },
            ),
            const Divider(height: 1),

            // About section
            ListTile(
              leading: Icon(Icons.info, color: scheme.primary),
              title: const Text('About'),
              subtitle: const Text('Version, licenses'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'FitForge',
                  applicationVersion: '1.0.0',
                );
              },
            ),
            const Divider(height: 1),

            // Sign out button
            ListTile(
              leading: Icon(Icons.logout, color: scheme.error),
              title: Text(
                'Sign Out',
                style: TextStyle(color: scheme.error),
              ),
              onTap: () {
                // TODO: Implement sign out logic
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingWelcome(),
                    ),
                    (route) => false);
                Gauth.signOut();
                debugPrint('User signed out');
              },
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
          title: const Text('Select Units'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Metric (kg, cm)'),
                value: 'Metric',
                groupValue: _selectedUnit,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedUnit = value;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('Imperial (lb, in)'),
                value: 'Imperial',
                groupValue: _selectedUnit,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedUnit = value;
                    });
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
