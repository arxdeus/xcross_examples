import 'package:flutter/material.dart';
import 'package:flutter_example/src/firebase_page.dart';
import 'package:flutter_example/src/rust/api/simple.dart' as rust;
import 'package:flutter_example/src/rust/frb_generated.dart';
import 'package:flutter_example/src/rust_counter_page.dart';
import 'package:flutter_example/src/showcase_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const UnifiedApp());
}

class UnifiedApp extends StatelessWidget {
  const UnifiedApp({super.key, this.rustCounterFactory});

  final RustCounterFactory? rustCounterFactory;

  Future<RustCounter> _createRustCounter() async {
    final counter = await rust.Counter.newInstance();
    return NativeRustCounter(counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xcross Flutter Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: UnifiedHomePage(
        rustCounterFactory: rustCounterFactory ?? _createRustCounter,
      ),
    );
  }
}

class UnifiedHomePage extends StatelessWidget {
  const UnifiedHomePage({super.key, required this.rustCounterFactory});

  final RustCounterFactory rustCounterFactory;

  @override
  Widget build(BuildContext context) {
    final features = <_Feature>[
      _Feature(
        title: 'Rust counter',
        subtitle: 'State managed by flutter_rust_bridge native assets',
        icon: Icons.memory,
        page: RustCounterPage(counterFactory: rustCounterFactory),
      ),
      const _Feature(
        title: 'Firebase actions',
        subtitle: 'Authentication, Firestore, Storage, and Messaging',
        icon: Icons.local_fire_department,
        page: FirebaseActionsPage(),
      ),
      const _Feature(
        title: 'Fonts and icons',
        subtitle: 'Lato custom font and vector icon package',
        icon: Icons.auto_awesome,
        page: ShowcasePage(),
      ),
      const _Feature(
        title: 'Dart counter',
        subtitle: 'Basic counter with the merged native-assets dependencies',
        icon: Icons.add_circle_outline,
        page: DartCounterPage(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('xcross Flutter Examples')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: features.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final feature = features[index];
          return Card(
            child: ListTile(
              leading: Icon(feature.icon),
              title: Text(feature.title),
              subtitle: Text(feature.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute<void>(builder: (_) => feature.page)),
            ),
          );
        },
      ),
    );
  }
}

class _Feature {
  const _Feature({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;
}

class NativeRustCounter implements RustCounter {
  NativeRustCounter(this._counter);

  final rust.Counter _counter;

  @override
  int get value => _counter.getValue();

  @override
  void increment() => _counter.increment();
}
