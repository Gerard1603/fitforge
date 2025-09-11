import 'package:flutter/material.dart';
import 'workouts_page.dart';
import 'progress_page.dart';
import 'nutrition_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const WorkoutsPage(),
    const ProgressPage(),
    const NutritionPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Nutrition'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back, Gerard 👋",
                        style: text.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onPrimary,
                        )),
                    const SizedBox(height: 6),
                    Text("Push harder than yesterday 💪",
                        style: text.bodyMedium?.copyWith(
                          color: scheme.onPrimary.withOpacity(0.8),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // STATS - Glassmorphism Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _glassStatCard("BMI", "22.5", Icons.monitor_weight, scheme),
                    _glassStatCard("Workouts", "12", Icons.fitness_center, scheme),
                    _glassStatCard("Calories", "1800", Icons.local_fire_department, scheme),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // WORKOUT OF THE DAY - Horizontal Scroll
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Workouts of the Day",
                    style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _workoutCard("Full Body Burn", "45 min • Intermediate", scheme),
                    _workoutCard("HIIT Blast", "30 min • Advanced", scheme),
                    _workoutCard("Yoga Flow", "25 min • Beginner", scheme),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // GOALS PROGRESS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("Your Goals",
                    style: text.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              _goalTile("Weekly Workouts", 4, 5, scheme),
              _goalTile("Calories Burned", 1800, 2500, scheme),
              _goalTile("Water Intake", 6, 8, scheme),
              const SizedBox(height: 20),

              // MOTIVATIONAL BANNER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage("assets/motivation.jpg"), // Add your image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Center(
                      child: Text(
                        "🏆 Discipline > Motivation.\nStay consistent!",
                        textAlign: TextAlign.center,
                        style: text.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // Glassmorphism Stat Card
  Widget _glassStatCard(String label, String value, IconData icon, ColorScheme scheme) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                )),
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  // Workout Card
  Widget _workoutCard(String title, String subtitle, ColorScheme scheme) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.fitness_center, color: scheme.onPrimary, size: 32),
          const Spacer(),
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: scheme.onPrimary)),
          Text(subtitle, style: TextStyle(color: scheme.onPrimary.withOpacity(0.8))),
        ],
      ),
    );
  }

  // Goal Progress
  Widget _goalTile(String label, int current, int target, ColorScheme scheme) {
    final progress = current / target;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: LinearProgressIndicator(
        value: progress,
        color: scheme.primary,
        backgroundColor: scheme.primary.withOpacity(0.2),
      ),
      trailing: Text("$current/$target"),
    );
  }
}
