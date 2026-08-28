import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ShowcasePage extends StatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fonts and icons')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Custom Lato font',
              style: TextStyle(fontFamily: 'Lato', fontSize: 30),
            ),
            SizedBox(height: 24),
            Wrap(
              spacing: 24,
              children: [
                _ShowcaseIcon(
                  icon: MaterialCommunityIcons.auto_fix,
                  label: 'Auto Fix',
                ),
                _ShowcaseIcon(
                  icon: MaterialCommunityIcons.incognito,
                  label: 'Incognito',
                ),
                _ShowcaseIcon(icon: FontAwesome5Brands.apple, label: 'Apple'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowcaseIcon extends StatelessWidget {
  const _ShowcaseIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 42), const SizedBox(height: 8), Text(label)],
    );
  }
}

class DartCounterPage extends StatefulWidget {
  const DartCounterPage({super.key});

  @override
  State<DartCounterPage> createState() => _DartCounterPageState();
}

class _DartCounterPageState extends State<DartCounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Counter value from Dart'),
            Text(
              '$_counter',
              key: const ValueKey('dart-counter-value'),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: 'Increment Dart counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
