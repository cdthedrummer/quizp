import 'package:flutter/material.dart';
import '../controllers/quiz_controller.dart';
import '../models/question.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _controller = QuizController();

  void _handleAnswer(List<String> answers) {
    setState(() {
      _controller.submitAnswer(answers);
      if (_controller.hasNextQuestion) {
        _controller.nextQuestion();
      } else {
        // TODO: Navigate to results screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _controller.currentQuestion;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProgressBar(progress: _controller.progress),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: question.isSplash
                    ? _buildSplashScreen(question)
                    : QuestionCard(
                        key: ValueKey(_controller.currentIndex),
                        question: question.text,
                        options: question.options,
                        type: question.type,
                        previousAnswer: _controller.getAnswerForQuestion(_controller.currentIndex),
                        onAnswer: _handleAnswer,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplashScreen(Question question) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (question.splashIcon != null)
              Text(
                question.splashIcon!,
                style: const TextStyle(fontSize: 48),
              ),
            const SizedBox(height: 24),
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (question.encouragementText != null)
              Text(
                question.encouragementText!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _handleAnswer([]),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
