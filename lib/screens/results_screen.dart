import 'package:flutter/material.dart';
import '../models/question.dart';

class ResultsScreen extends StatelessWidget {
  final Map<Attribute, int> scores;

  const ResultsScreen({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    final highestScore = scores.values.reduce((a, b) => a > b ? a : b);
    final primaryAttributes = scores.entries
        .where((entry) => entry.value == highestScore)
        .map((entry) => entry.key)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withAlpha(204),
                Theme.of(context).primaryColorDark,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Text(
                'Quest Complete! ✨',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Your Primary Attributes:',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        children: primaryAttributes.map((attribute) {
                          return _buildAttributeCard(attribute);
                        }).toList(),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'All Attributes:',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _buildAttributeBars(context),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttributeCard(Attribute attribute) {
    final score = scores[attribute] ?? 0;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              attributeIcons[attribute]!,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              attribute.toString().split('.').last.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Score: $score',
              style: const TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeBars(BuildContext context) {
    final maxScore = scores.values.reduce((a, b) => a > b ? a : b);

    return ListView.separated(
      itemCount: Attribute.values.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final attribute = Attribute.values[index];
        final score = scores[attribute] ?? 0;
        final progress = maxScore > 0 ? score / maxScore : 0.0;

        return Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                attributeIcons[attribute]!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 32,
              child: Text(
                score.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
