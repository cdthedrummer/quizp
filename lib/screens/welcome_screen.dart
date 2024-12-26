import 'package:flutter/material.dart';
import '../models/question.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isPortrait = size.height > size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withAlpha(204), // 0.8 opacity
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
        child: SafeArea(
          // ... rest of the widget tree remains the same ...
        ),
      ),
    );
  }
}