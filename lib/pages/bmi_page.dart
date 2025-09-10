import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _result = "";
  String _tip = "";

  void _calculateBMI() async {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      final heightMeters = height / 100;
      final bmi = weight / (heightMeters * heightMeters);

      String result;
      String tip;
      if (bmi < 18.5) {
        result = "Underweight";
        tip = "Add calorie-rich meals and strength training.";
      } else if (bmi < 24.9) {
        result = "Normal";
        tip = "Keep up the good work with balanced meals & activity.";
      } else if (bmi < 29.9) {
        result = "Overweight";
        tip = "Focus on portion control and consistent workouts.";
      } else {
        result = "Obese";
        tip = "Seek professional health guidance and active lifestyle.";
      }

      setState(() {
        _bmi = bmi;
        _result = result;
        _tip = tip;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('last_bmi', bmi);
      await prefs.setString('last_bmi_result', result);
    } else {
      setState(() {
        _bmi = null;
        _result = "Please enter valid values.";
        _tip = "";
      });
    }
  }

  void _reset() {
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmi = null;
      _result = "";
      _tip = "";
    });
  }

  Color _getBMIColor() {
    if (_bmi == null) return Colors.grey;
    if (_bmi! < 18.5) return Colors.orange;
    if (_bmi! < 24.9) return Colors.green;
    if (_bmi! < 29.9) return Colors.yellow.shade700;
    return Colors.red;
  }

  /// ✅ Modern BMI Scale with Arrow Marker
  Widget _buildBMIChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                flex: 185, child: Container(height: 20, color: Colors.orange)),
            Expanded(
                flex: 64, child: Container(height: 20, color: Colors.green)),
            Expanded(
                flex: 50,
                child: Container(height: 20, color: Colors.yellow.shade700)),
            Expanded(
                flex: 101, child: Container(height: 20, color: Colors.red)),
          ],
        ),
        const SizedBox(height: 8),
        if (_bmi != null)
          LayoutBuilder(
            builder: (context, constraints) {
              final clamped = _bmi!.clamp(10, 40);
              final relative = (clamped - 10) / 30;
              final pos = constraints.maxWidth * relative;

              return Padding(
                padding: EdgeInsets.only(left: pos - 20),
                child: Column(
                  children: [
                    const Icon(Icons.arrow_drop_down,
                        size: 32, color: Colors.black),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getBMIColor(),
                            _getBMIColor().withOpacity(0.7)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _bmi!.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("10"),
            Text("20"),
            Text("30"),
            Text("40"),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: scheme.primary,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                Icon(Icons.health_and_safety, size: 90, color: scheme.primary),
                const SizedBox(height: 16),
                Text(
                  "Body Mass Index",
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Track your BMI to stay on top of your fitness goals",
                  style:
                      text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    prefixIcon: const Icon(Icons.height),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    prefixIcon: const Icon(Icons.monitor_weight_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _calculateBMI,
                        icon: const Icon(Icons.calculate),
                        label: const Text("Calculate"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: scheme.primary,
                          foregroundColor: scheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      color: scheme.secondary,
                      tooltip: "Reset",
                    )
                  ],
                ),
                const SizedBox(height: 28),
                if (_bmi != null)
                  Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                _getBMIColor().withOpacity(0.85),
                                _getBMIColor().withOpacity(0.65)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _result,
                                style: text.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _tip,
                                style: text.bodyMedium
                                    ?.copyWith(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildBMIChart(),
                    ],
                  )
                else if (_result.isNotEmpty)
                  Text(
                    _result,
                    style: TextStyle(color: scheme.error, fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
