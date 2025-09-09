import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutSessionPage extends StatefulWidget {
  final String planName;
  final List<String> exerciseNames;

  const WorkoutSessionPage({
    super.key,
    required this.planName,
    required this.exerciseNames,
  });

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  late final List<_Exercise> _exercises;
  int _currentIndex = 0;

  bool _running = false;
  int _elapsedSec = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _exercises = widget.exerciseNames.map((e) => _Exercise(name: e)).toList();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _running = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _elapsedSec++;
      });
    });
  }

  void _toggleTimer() {
    if (_running) {
      _timer?.cancel();
      _running = false;
    } else {
      _startTimer();
    }
    setState(() {});
  }

  void _resetTimer() {
    _timer?.cancel();
    _running = false;
    _elapsedSec = 0;
    setState(() {});
  }

  void _addSet(_ExerciseSet set) {
    setState(() {
      _exercises[_currentIndex].sets.add(set);
    });
  }

  void _nextExercise() {
    setState(() {
      if (_currentIndex < _exercises.length - 1) {
        _exercises[_currentIndex].completed = true;
        _currentIndex++;
        _resetTimer();
      } else {
        _finishWorkout();
      }
    });
  }

  void _finishWorkout() {
    _resetTimer();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Workout Complete!')),
    );
  }

  String get _formattedTime {
    final minutes = (_elapsedSec ~/ 60).toString().padLeft(2, '0');
    final seconds = (_elapsedSec % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final currentExercise = _exercises[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.planName),
        actions: [
          IconButton(
            onPressed: _finishWorkout,
            icon: const Icon(Icons.check_circle_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timer
              Card(
                color: scheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_formattedTime, style: text.headlineMedium),
                      const SizedBox(width: 16),
                      FloatingActionButton.small(
                        onPressed: _toggleTimer,
                        child: Icon(_running ? Icons.pause : Icons.play_arrow),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton.small(
                        onPressed: _resetTimer,
                        child: const Icon(Icons.replay),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Current Exercise
              Center(
                child: Text(currentExercise.name,
                    style: text.headlineMedium,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16),

              // Input sets
              _SetInput(onAddSet: _addSet),
              const SizedBox(height: 16),

              // Sets list
              Expanded(
                child: ListView.builder(
                  itemCount: currentExercise.sets.length,
                  itemBuilder: (context, index) {
                    final set = currentExercise.sets[index];
                    return ListTile(
                      title: Text('Set ${index + 1}'),
                      trailing: Text('${set.weight} kg x ${set.reps} reps'),
                    );
                  },
                ),
              ),

              // Next Button
              ElevatedButton.icon(
                onPressed: _nextExercise,
                icon: const Icon(Icons.arrow_forward),
                label: Text(
                  _currentIndex == _exercises.length - 1
                      ? 'Finish Workout'
                      : 'Next Exercise',
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SetInput extends StatefulWidget {
  final void Function(_ExerciseSet) onAddSet;

  const _SetInput({required this.onAddSet});

  @override
  State<_SetInput> createState() => _SetInputState();
}

class _SetInputState extends State<_SetInput> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  void _addSet() {
    final weight = double.tryParse(_weightController.text);
    final reps = int.tryParse(_repsController.text);

    if (weight != null && reps != null && weight > 0 && reps > 0) {
      widget.onAddSet(_ExerciseSet(weight: weight, reps: reps));
      _weightController.clear();
      _repsController.clear();
      FocusScope.of(context).unfocus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid weight and reps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Weight (kg)'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: _repsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Reps'),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _addSet,
          icon: const Icon(Icons.add_box_rounded),
          color: Theme.of(context).colorScheme.primary,
          iconSize: 40,
        ),
      ],
    );
  }
}

class _Exercise {
  final String name;
  final int targetSets;
  final List<_ExerciseSet> sets;
  bool completed;

  _Exercise({
    required this.name,
    this.targetSets = 3,
    List<_ExerciseSet>? sets,
    this.completed = false,
  }) : sets = sets ?? [];
}

class _ExerciseSet {
  final double weight;
  final int reps;

  const _ExerciseSet({
    required this.weight,
    required this.reps,
  });
}
