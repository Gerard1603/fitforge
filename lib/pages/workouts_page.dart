import 'package:flutter/material.dart';
import 'workout_session_page.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  final List<Map<String, dynamic>> workouts = const [
    {
      "title": "Full Body",
      "icon": Icons.fitness_center,
      "color": Colors.blueAccent,
    },
    {
      "title": "Chest & Arms",
      "icon": Icons.accessibility_new,
      "color": Colors.redAccent,
    },
    {
      "title": "Leg Day",
      "icon": Icons.directions_run,
      "color": Colors.green,
    },
    {
      "title": "Core Strength",
      "icon": Icons.sports_gymnastics,
      "color": Colors.orangeAccent,
    },
    {
      "title": "Cardio",
      "icon": Icons.directions_bike,
      "color": Colors.purpleAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkoutSessionPage(title: workout["title"]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: workout["color"].withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: workout["color"], width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(workout["icon"], size: 50, color: workout["color"]),
                  const SizedBox(height: 12),
                  Text(
                    workout["title"],
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: workout["color"],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
