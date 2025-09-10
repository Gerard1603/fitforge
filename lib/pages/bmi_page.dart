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
        tip = "Consider a balanced diet with more calories.";
      } else if (bmi < 24.9) {
        result = "Normal";
        tip = "Great job! Keep maintaining your healthy lifestyle.";
      } else if (bmi < 29.9) {
        result = "Overweight";
        tip = "Try regular exercise and balanced nutrition.";
      } else {
        result = "Obese";
        tip = "Seek guidance from a healthcare professional.";
      }

      setState(() {
        _bmi = bmi;
        _result = result;
        _tip = tip;
      });

      // ✅ Save last BMI to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('last_bmi', bmi);
      await prefs.setString('last_bmi_result', result);
    } else {
      setState(() {
        _bmi = null;
        _result = "Enter valid values!";
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: scheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                // Icon header
                Icon(Icons.monitor_weight, size: 100, color: scheme.primary),
                const SizedBox(height: 16),

                Text(
                  "Body Mass Index",
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Calculate your BMI to understand your health status",
                  style:
                      text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Input Fields
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

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _calculateBMI,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: scheme.primary,
                          foregroundColor: scheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Calculate",
                            style: TextStyle(fontSize: 18)),
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
                const SizedBox(height: 32),

                // Result Section
                if (_bmi != null)
                  Card(
                    color: _getBMIColor().withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            _bmi!.toStringAsFixed(1),
                            style: text.displaySmall?.copyWith(
                              color: _getBMIColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _result,
                            style: text.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _getBMIColor(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _tip,
                            style: text.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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
