import 'package:flutter/material.dart';
import 'onboarding_get_started.dart';

class OnboardingFeatures extends StatelessWidget {
  const OnboardingFeatures({super.key});

  final List<Map<String, dynamic>> _features = const [
    {
      "icon": Icons.fitness_center,
      "title": "Personalized Workouts",
      "desc": "Get workouts tailored to your fitness level and goals."
    },
    {
      "icon": Icons.restaurant_menu,
      "title": "Smart Nutrition",
      "desc": "Track meals and receive healthy recommendations."
    },
    {
      "icon": Icons.bar_chart,
      "title": "Progress Tracking",
      "desc": "Visualize your journey and celebrate milestones."
    },
    {
      "icon": Icons.emoji_events,
      "title": "Rewards System",
      "desc": "Earn badges and stay motivated as you improve."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Icon
                Icon(Icons.fitness_center,
                    size: 90, color: scheme.onPrimary),
                const SizedBox(height: 16),

                // Title
                Text(
                  "Why Choose FitForge?",
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  "Everything you need in one fitness app.",
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onPrimary.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Features List (Centered in middle of screen)
                Expanded(
                  child: Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _features.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, i) {
                        final feature = _features[i];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: scheme.primary.withOpacity(0.1),
                                child: Icon(feature["icon"], color: scheme.primary),
                              ),
                              title: Text(
                                feature["title"],
                                style: text.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: scheme.onSurface,
                                ),
                              ),
                              subtitle: Text(
                                feature["desc"],
                                style: text.bodyMedium?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnboardingGetStarted(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: scheme.onPrimary,
                      foregroundColor: scheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      "Next",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
