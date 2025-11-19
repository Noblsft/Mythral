import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "start_screen_desktop.dart";
import "start_screen_mobile.dart";
import "start_screen_view_model.dart";

class StartScreen extends StatelessWidget {
  final StartScreenViewModel viewModel;

  const StartScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktopLike =
        width >= 800 || kIsWeb || isDesktopPlatform(Theme.of(context).platform);

    if (isDesktopLike) {
      return StartScreenDesktop(viewModel: viewModel);
    } else {
      return StartScreenMobile(viewModel: viewModel);
    }
  }

  bool isDesktopPlatform(TargetPlatform platform) {
    return platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;
  }
}
