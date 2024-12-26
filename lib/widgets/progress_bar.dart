import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  static const double _height = 8.0;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(_height / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(_height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: -16,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: progress >= 0.99 ? 1.0 : 0.0,
                  child: const Text('✨', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
