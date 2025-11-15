import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'start_screen_mobile.dart';
import 'start_screen_desktop.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isDesktopLike =
        width >= 800 || kIsWeb || isDesktopPlatform(defaultTargetPlatform);

    if (isDesktopLike) {
      return const StartScreenDesktop();
    } else {
      return const StartScreenMobile();
    }
  }

  bool isDesktopPlatform(TargetPlatform platform) {
    return platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;
  }
}
