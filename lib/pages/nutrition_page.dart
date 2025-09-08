import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          Text('Today’s Nutrition', style: text.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _MacroCard(label: 'Calories', value: '1,450 / 2,200')),
              SizedBox(width: 12),
              Expanded(child: _MacroCard(label: 'Protein', value: '92g / 160g')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: _MacroCard(label: 'Carbs', value: '180g')),
              SizedBox(width: 12),
              Expanded(child: _MacroCard(label: 'Fats', value: '55g')),
            ],
          ),
          const SizedBox(height: 24),
          Text('Meals', style: text.titleMedium),
          const SizedBox(height: 8),
          const _MealTile(meal: 'Breakfast', detail: 'Oats, eggs, berries'),
          const _MealTile(meal: 'Lunch', detail: 'Chicken bowl, rice, veggies'),
          const _MealTile(meal: 'Snack', detail: 'Greek yogurt, almonds'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              // TODO: Add meal flow
            },
            icon: Icon(Icons.add, color: scheme.onTertiaryContainer),
            label: const Text('Add meal'),
          ),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String label;
  final String value;
  const _MacroCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 6),
            Text(value, style: text.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _MealTile extends StatelessWidget {
  final String meal;
  final String detail;
  const _MealTile({required this.meal, required this.detail});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Icon(Icons.restaurant_menu, color: scheme.onPrimaryContainer),
        ),
        title: Text(meal),
        subtitle: Text(detail),
        trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        onTap: () {},
      ),
    );
  }
}