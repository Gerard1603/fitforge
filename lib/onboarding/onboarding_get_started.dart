import 'package:flutter/material.dart';
import '../routes.dart';

class OnboardingGetStarted extends StatelessWidget {
  const OnboardingGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Illustration / Icon inside a Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Icon(
                        Icons.fitness_center,
                        size: 100,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Headline
                  Text(
                    "Ready to Transform?",
                    style: text.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    "Track workouts, log progress,\n and crush your fitness goals.",
                    style: text.bodyLarge?.copyWith(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Get Started Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: scheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.login);
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Skip button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.signup);
                    },
                    child: const Text(
                      "Skip for now",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
