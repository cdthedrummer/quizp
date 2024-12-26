import 'package:flutter/material.dart';

enum QuestionType { 
  singleChoice,
  multiChoice,
  scale
}

enum Attribute {
  strength,
  dexterity,
  constitution,
  intelligence,
  wisdom,
  charisma
}

class Question {
  final String text;
  final List<String> options;
  final QuestionType type;
  final Map<String, List<Attribute>> attributeScores;
  
  const Question({
    required this.text,
    required this.options,
    required this.type,
    required this.attributeScores,
  });
}

// Emojis for attributes
const Map<Attribute, String> attributeIcons = {
  Attribute.strength: '💪',
  Attribute.intelligence: '🧠',
  Attribute.wisdom: '🔮',
  Attribute.dexterity: '🎾',
  Attribute.charisma: '🌟',
  Attribute.constitution: '🛡️',
};

// Define the questions list
const List<Question> questions = [
  Question(
    text: 'How do you prefer to learn?',
    options: ['Reading or studying', 'Watching a video', 'Doing it yourself', 'Group setting'],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Reading or studying': [Attribute.intelligence],
      'Watching a video': [Attribute.intelligence, Attribute.wisdom],
      'Doing it yourself': [Attribute.dexterity],
      'Group setting': [Attribute.charisma],
    },
  ),
  Question(
    text: 'Where\'s your focus when it comes to trying to be healthy?',
    options: ['Eating well', 'Being active', 'Relaxing and taking it easy', 'Getting regular check-ups'],
    type: QuestionType.multiChoice,
    attributeScores: {
      'Eating well': [Attribute.constitution],
      'Being active': [Attribute.strength, Attribute.dexterity],
      'Relaxing and taking it easy': [Attribute.wisdom],
      'Getting regular check-ups': [Attribute.constitution],
    },
  ),
  // Add more questions from the document...
];