import 'package:flutter/material.dart';

class WorkoutSessionPage extends StatefulWidget {
  final Map<String, dynamic> exercise;
  const WorkoutSessionPage({super.key, required this.exercise});

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  int completedSets = 0;

  @override
  Widget build(BuildContext context) {
    final ex = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: Text(ex["name"] as String),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(ex["icon"] as IconData,
                    size: 50, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              ex["name"] as String,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              ex["description"] as String,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Sets: ${ex["sets"]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // Progress tracker
            LinearProgressIndicator(
              value: completedSets / 3,
              minHeight: 12,
              backgroundColor: Colors.grey.shade300,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 16),
            Text("Completed: $completedSets/3 sets",
                style: const TextStyle(fontSize: 16)),

            const Spacer(),

            // Complete Set button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (completedSets < 3) {
                      completedSets++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${ex["name"]} session finished! ✅")),
                      );
                    }
                  });
                },
                icon: const Icon(Icons.check_circle),
                label: const Text("Complete Set"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
