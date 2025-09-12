import 'package:flutter/material.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER with gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [scheme.primary, scheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: scheme.onPrimary.withOpacity(0.2),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/profile.jpg"), // replace with NetworkImage if using Firebase
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: scheme.primary,
                          child: const Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text("John Doe",
                        style: text.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onPrimary,
                        )),
                    Text("john.doe@email.com",
                        style: text.bodyMedium?.copyWith(
                          color: scheme.onPrimary.withOpacity(0.9),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // QUICK STATS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCard("Workouts", "24", Icons.fitness_center, scheme),
                    _statCard("Calories", "12k", Icons.local_fire_department, scheme),
                    _statCard("Progress", "76%", Icons.show_chart, scheme),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // PROFILE DETAILS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _detailTile(Icons.person, "Full Name", "John Doe"),
                    _detailTile(Icons.cake, "Age", "25"),
                    _detailTile(Icons.monitor_weight, "Weight", "70 kg"),
                    _detailTile(Icons.height, "Height", "175 cm"),
                    _detailTile(Icons.flag, "Goal", "Build Muscle"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // SETTINGS BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text("Settings"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: scheme.primary,
                    foregroundColor: scheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Quick stats widget
  Widget _statCard(String label, String value, IconData icon, ColorScheme scheme) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.primary.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: scheme.primary, size: 28),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: scheme.primary,
                )),
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  // Profile detail tile
  Widget _detailTile(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Future: open edit field
        },
      ),
    );
  }
}
