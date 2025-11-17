import "package:flutter/material.dart";
import "start_screen_view_model.dart";

class StartScreenMobile extends StatelessWidget {
  final StartScreenViewModel viewModel;

  const StartScreenMobile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mythral")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                "assets/images/mythral_logo.png",
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Start by creating a new vault or opening an existing one.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () async {
                await viewModel.createVault();
              },
              icon: const Icon(Icons.add),
              label: const Text("Create new vault"),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                await viewModel.openVault();
              },
              icon: const Icon(Icons.folder_open),
              label: const Text("Open existing vault"),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
