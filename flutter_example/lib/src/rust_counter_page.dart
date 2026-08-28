import 'package:flutter/material.dart';

typedef RustCounterFactory = Future<RustCounter> Function();

abstract interface class RustCounter {
  int get value;

  void increment();
}

class RustCounterPage extends StatefulWidget {
  const RustCounterPage({super.key, required this.counterFactory});

  final RustCounterFactory counterFactory;

  @override
  State<RustCounterPage> createState() => _RustCounterPageState();
}

class _RustCounterPageState extends State<RustCounterPage> {
  RustCounter? _counter;
  Object? _error;
  int _value = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final counter = await widget.counterFactory();
      if (!mounted) return;
      setState(() {
        _counter = counter;
        _value = counter.value;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  void _increment() {
    final counter = _counter;
    if (counter == null) return;
    setState(() {
      counter.increment();
      _value = counter.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rust counter')),
      body: Center(
        child: _error == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Counter value from Rust'),
                  Text(
                    '$_value',
                    key: const ValueKey('rust-counter-value'),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  if (_counter == null) const CircularProgressIndicator(),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Rust counter unavailable: $_error'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counter == null ? null : _increment,
        tooltip: 'Increment Rust counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
