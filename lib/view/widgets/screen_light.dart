import 'package:flutter/material.dart';

class ScreenLight extends StatelessWidget {
  const ScreenLight({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 160,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                blurRadius: 150,
                spreadRadius: 255
            )
          ]
      ),
    );
  }
}
