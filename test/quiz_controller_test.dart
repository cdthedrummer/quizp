import 'package:flutter_test/flutter_test.dart';
import 'package:quizp/controllers/quiz_controller.dart';
import 'package:quizp/models/question.dart';

void main() {
  test('scores are recalculated when answers change', () {
    final controller = QuizController();

    expect(controller.finalScores, isEmpty);

    controller.submitAnswer(['Reading or studying']);
    expect(controller.finalScores[Attribute.intelligence], 1);

    controller.submitAnswer(['Doing it yourself']);
    expect(controller.finalScores[Attribute.intelligence], isNull);
    expect(controller.finalScores[Attribute.dexterity], 1);

    controller.nextQuestion();
    controller.submitAnswer([]);
    controller.nextQuestion();

    controller.submitAnswer([
      'Competing in fast-paced games',
      'Building or fixing things',
    ]);

    expect(controller.finalScores[Attribute.dexterity], 2);
    expect(controller.finalScores[Attribute.strength], 2);
    expect(controller.finalScores[Attribute.constitution], 1);

    controller.submitAnswer(['Planning complex strategies']);

    expect(controller.finalScores[Attribute.dexterity], 1);
    expect(controller.finalScores[Attribute.strength], isNull);
    expect(controller.finalScores[Attribute.constitution], isNull);
    expect(controller.finalScores[Attribute.intelligence], 1);
    expect(controller.finalScores[Attribute.wisdom], 1);
  });
}
