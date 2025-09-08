import 'package:flutter/material.dart';
import 'workout_session_page.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  // Example workout data to display.
  static const List<Map<String, dynamic>> _workouts = [
    {
      'name': 'Full Body Strength',
      'description': '3 days a week. Focus on compound lifts.',
      'exercises': ['Squats', 'Bench Press', 'Deadlifts'],
    },
    {
      'name': 'Upper/Lower Split',
      'description': '4 days a week. Upper and lower body focus.',
      'exercises': ['Pull-ups', 'Overhead Press', 'Bent-over Rows'],
    },
    {
      'name': '5x5 Program',
      'description': 'Classic program for building strength.',
      'exercises': ['Squats', 'Deadlifts', 'Bench Press', 'Barbell Rows'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workouts'),
      ),
      body: ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          final workout = _workouts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(workout['name']!),
              subtitle: Text(workout['description']!),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // This is the key change! It navigates to the workout session page.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutSessionPage(
                      planName: workout['name']!,
                      exerciseNames: workout['exercises'] as List<String>,
                    ),
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