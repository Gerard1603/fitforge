import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  double? _lastBMI;
  String? _lastResult;

  @override
  void initState() {
    super.initState();
    _loadLastBMI();
  }

  Future<void> _loadLastBMI() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastBMI = prefs.getDouble('last_bmi');
      _lastResult = prefs.getString('last_bmi_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Progress Overview",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (_lastBMI != null && _lastResult != null)
              Text(
                "Last BMI: ${_lastBMI!.toStringAsFixed(1)} ($_lastResult)",
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              )
            else
              const Text("No BMI calculated yet."),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, Routes.bmi)
                    .then((_) => _loadLastBMI()); // refresh when returning
              },
              icon: const Icon(Icons.monitor_weight),
              label: const Text("Check your BMI"),
            ),
          ],
        ),
      ),
    );
  }
}
