import 'package:flutter/material.dart';

class WorkoutSessionPage extends StatelessWidget {
  final String title;

  const WorkoutSessionPage({super.key, required this.title});

  final List<Map<String, dynamic>> exercises = const [
    {
      "name": "Push Ups",
      "sets": "3 sets x 12 reps",
      "icon": Icons.accessibility_new,
    },
    {
      "name": "Squats",
      "sets": "4 sets x 15 reps",
      "icon": Icons.fitness_center,
    },
    {
      "name": "Plank",
      "sets": "3 sets x 60s hold",
      "icon": Icons.sports_gymnastics,
    },
    {
      "name": "Jumping Jacks",
      "sets": "3 sets x 30 reps",
      "icon": Icons.directions_run,
    },
    {
      "name": "Bicep Curls",
      "sets": "3 sets x 10 reps",
      "icon": Icons.sports,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                child: Icon(exercise["icon"], color: scheme.primary),
              ),
              title: Text(
                exercise["name"],
                style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(exercise["sets"]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Later: Navigate to detailed exercise tutorial/video page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selected: ${exercise["name"]}")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
