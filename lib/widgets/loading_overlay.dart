import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
