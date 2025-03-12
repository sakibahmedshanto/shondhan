import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

class LaunchAppButton extends StatelessWidget {
  const LaunchAppButton({super.key});

  Future<void> _launchArchViz(BuildContext context) async {
    if (!Platform.isAndroid) {
      _showSnackbar(context, "Unsupported platform!");
      return;
    }

    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: 'com.DefaultCompany.ArchViz',
        componentName: 'com.unity3d.player.UnityPlayerActivity',
        flags: <int>[0x10000000], // FLAG_ACTIVITY_NEW_TASK
      );
      await intent.launch();
    } catch (e) {
      _showSnackbar(context, "Error launching ArchViz: $e");
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "launch_archviz",
      onPressed: () => _launchArchViz(context),
      backgroundColor: Colors.deepPurple,
      child: const Icon(Icons.view_in_ar, color: Colors.white, size: 28),
    );
  }
}
