enum QuestionType { 
  singleChoice,
  multiChoice,
  scale,
  splash
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
  final String? encouragementText;  // For splash screens
  final String? splashIcon;         // Emoji for splash screens
  
  const Question({
    required this.text,
    this.options = const [],        // Empty for splash screens
    required this.type,
    this.attributeScores = const {}, // Empty for splash screens
    this.encouragementText,
    this.splashIcon,
  });

  bool get isSplash => type == QuestionType.splash;
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
  // ... rest of questions remain the same ...
];