import 'package:flutter/material.dart';

class StartScreenDesktop extends StatelessWidget {
  const StartScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 120,
                    height: 120,
                  ),
                ),
                const Text(
                  'Welcome to Mythral',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Work with a single project file that stores everything. Secure and local on your machine.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => _onCreateNewFile(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Create new file'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _onOpenExistingFile(context),
                  icon: const Icon(Icons.folder_open),
                  label: const Text('Open existing file'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCreateNewFile(BuildContext context) {
    debugPrint('Desktop: create new file');
  }

  void _onOpenExistingFile(BuildContext context) {
    debugPrint('Desktop: open existing file');
  }
}
