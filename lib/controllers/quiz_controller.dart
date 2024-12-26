import '../models/question.dart';

class QuizController {
  int _currentIndex = 0;
  final Map<int, List<String>> _answers = {};
  final Map<Attribute, int> _scores = {};

  // Getters
  int get currentIndex => _currentIndex;
  Question get currentQuestion => questions[_currentIndex];
  bool get hasNextQuestion => _currentIndex < questions.length - 1;
  bool get hasPreviousQuestion => _currentIndex > 0;
  double get progress => (_currentIndex + 1) / questions.length;

  // Navigation
  void nextQuestion() {
    if (hasNextQuestion) {
      _currentIndex++;
    }
  }

  void previousQuestion() {
    if (hasPreviousQuestion) {
      _currentIndex--;
    }
  }

  // Answer management
  void submitAnswer(List<String> selectedAnswers) {
    _answers[_currentIndex] = selectedAnswers;
    _updateScores(selectedAnswers);
  }

  List<String>? getAnswerForQuestion(int index) {
    return _answers[index];
  }

  // Score calculation
  void _updateScores(List<String> selectedAnswers) {
    if (currentQuestion.isSplash) return;

    for (final answer in selectedAnswers) {
      final attributes = currentQuestion.attributeScores[answer] ?? [];
      for (final attribute in attributes) {
        _scores[attribute] = (_scores[attribute] ?? 0) + 1;
      }
    }
  }

  Map<Attribute, int> get finalScores => Map.unmodifiable(_scores);

  // Reset
  void reset() {
    _currentIndex = 0;
    _answers.clear();
    _scores.clear();
  }
}
