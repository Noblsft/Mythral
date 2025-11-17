import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:core/core.dart";

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<VaultRepository>(create: (context) => ZipVaultRepository()),
        ChangeNotifierProvider<StartScreenViewModel>(
          create: (context) => StartScreenViewModel(
            vaultRepository: context.read<VaultRepository>(),
          ),
        ),
      ],
      child: const MythralApp(),
    ),
  );
}

class MythralApp extends StatelessWidget {
  const MythralApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<StartScreenViewModel>(
        builder: (context, viewModel, child) {
          return StartScreen(viewModel: viewModel);
        },
      ),
    );
  }
}
