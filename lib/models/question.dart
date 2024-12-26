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
  final Map<String, Map<Attribute, int>> attributeScores;
  
  const Question({
    required this.text,
    required this.options,
    required this.type,
    required this.attributeScores,
  });
}

// Emojis for attributes
const attributeIcons = {
  Attribute.strength: '💪',
  Attribute.intelligence: '🧠',
  Attribute.wisdom: '🔮',
  Attribute.dexterity: '🎾',
  Attribute.charisma: '🌟',
  Attribute.constitution: '🛡️',
};