import 'package:flutter/material.dart';
import 'workout_session_page.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        "name": "Push Ups",
        "sets": "3 x 12",
        "icon": Icons.fitness_center,
        "description": "A bodyweight exercise to strengthen chest and triceps."
      },
      {
        "name": "Squats",
        "sets": "4 x 10",
        "icon": Icons.accessibility_new,
        "description": "Great for legs, glutes, and overall core stability."
      },
      {
        "name": "Plank",
        "sets": "3 x 45s",
        "icon": Icons.self_improvement,
        "description": "Core-strengthening static hold exercise."
      },
      {
        "name": "Burpees",
        "sets": "3 x 15",
        "icon": Icons.directions_run,
        "description": "Full-body exercise for strength and conditioning."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final ex = exercises[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(ex["icon"] as IconData,
                    color: Theme.of(context).colorScheme.primary, size: 28),
              ),
              title: Text(
                ex["name"] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                "${ex["sets"]}\n${ex["description"]}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => WorkoutSessionPage(exercise: ex),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
