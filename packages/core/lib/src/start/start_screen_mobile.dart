// TODO Implement this library.
import 'package:flutter/material.dart';

class StartScreenMobile extends StatelessWidget {
  const StartScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My App')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start by creating a new file or opening an existing one.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => _onCreateNewFile(context),
              icon: const Icon(Icons.add),
              label: const Text('Create new file'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _onOpenExistingFile(context),
              icon: const Icon(Icons.folder_open),
              label: const Text('Open existing file'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _onCreateNewFile(BuildContext context) {
    debugPrint('Mobile: create new file');
  }

  void _onOpenExistingFile(BuildContext context) {
    debugPrint('Mobile: open existing file');
  }
}
