import 'package:flutter/material.dart';

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

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      final heightMeters = height / 100;
      final bmi = weight / (heightMeters * heightMeters);

      String result;
      if (bmi < 18.5) {
        result = "Underweight";
      } else if (bmi < 24.9) {
        result = "Normal";
      } else if (bmi < 29.9) {
        result = "Overweight";
      } else {
        result = "Obese";
      }

      setState(() {
        _bmi = bmi;
        _result = result;
      });
    } else {
      setState(() {
        _bmi = null;
        _result = "Enter valid values!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // keeps centered
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monitor_weight, size: 80, color: scheme.primary),
                const SizedBox(height: 16),

                Text(
                  "Check Your BMI",
                  style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Enter your height and weight",
                  style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Input fields
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Calculate button
                SizedBox(
                  width: double.infinity,
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
                    child: const Text(
                      "Calculate",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Results section
                if (_bmi != null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.only(top: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            _bmi!.toStringAsFixed(1),
                            style: text.displaySmall?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _result,
                            style: text.titleMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
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
