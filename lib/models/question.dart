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
  final String? encouragementText; // For splash screens
  final String? splashIcon; // Emoji for splash screens

  const Question({
    required this.text,
    this.options = const [], // Empty for splash screens
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
    options: [
      'Reading or studying',
      'Watching a video',
      'Doing it yourself',
      'Group setting'
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Reading or studying': [Attribute.intelligence],
      'Watching a video': [Attribute.intelligence, Attribute.wisdom],
      'Doing it yourself': [Attribute.dexterity],
      'Group setting': [Attribute.charisma],
    },
  ),
  Question(
    text: 'Ready to explore your heroic mix? Tap continue to start the journey.',
    type: QuestionType.splash,
    encouragementText:
        'You can always revisit a question. Every answer polishes your final build.',
    splashIcon: '🧭',
  ),
  Question(
    text: 'Select the challenges that energize you the most.',
    options: [
      'Planning complex strategies',
      'Helping friends talk through problems',
      'Competing in fast-paced games',
      'Building or fixing things',
      'Performing or presenting in front of others'
    ],
    type: QuestionType.multiChoice,
    attributeScores: {
      'Planning complex strategies': [Attribute.intelligence, Attribute.wisdom],
      'Helping friends talk through problems': [Attribute.wisdom, Attribute.charisma],
      'Competing in fast-paced games': [Attribute.dexterity, Attribute.strength],
      'Building or fixing things': [Attribute.strength, Attribute.constitution],
      'Performing or presenting in front of others': [Attribute.charisma],
    },
  ),
  Question(
    text: 'A teammate comes to you with a tricky puzzle. What do you do first?',
    options: [
      'Break it into smaller steps',
      'Look for hidden patterns',
      'Test different solutions quickly',
      'Ask clarifying questions',
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Break it into smaller steps': [Attribute.intelligence],
      'Look for hidden patterns': [Attribute.wisdom],
      'Test different solutions quickly': [Attribute.dexterity],
      'Ask clarifying questions': [Attribute.charisma, Attribute.wisdom],
    },
  ),
  Question(
    text: 'How much do you enjoy physical challenges? (1 = not at all, 7 = love them)',
    options: ['1', '2', '3', '4', '5', '6', '7'],
    type: QuestionType.scale,
    attributeScores: {
      '1': [Attribute.intelligence],
      '2': [Attribute.wisdom],
      '3': [Attribute.wisdom, Attribute.constitution],
      '4': [Attribute.constitution],
      '5': [Attribute.constitution, Attribute.strength],
      '6': [Attribute.strength, Attribute.dexterity],
      '7': [Attribute.strength, Attribute.dexterity],
    },
  ),
  Question(
    text: 'Pick the traits teammates rely on you for.',
    options: [
      'Keeping everyone motivated',
      'Finding creative solutions',
      'Staying calm under pressure',
      'Training and preparation',
      'Coordinating the group'
    ],
    type: QuestionType.multiChoice,
    attributeScores: {
      'Keeping everyone motivated': [Attribute.charisma, Attribute.wisdom],
      'Finding creative solutions': [Attribute.intelligence, Attribute.dexterity],
      'Staying calm under pressure': [Attribute.constitution, Attribute.wisdom],
      'Training and preparation': [Attribute.strength, Attribute.constitution],
      'Coordinating the group': [Attribute.charisma, Attribute.intelligence],
    },
  ),
  Question(
    text: 'You\'re closing in on your build! Take a breath and continue when ready.',
    type: QuestionType.splash,
    encouragementText: 'Two more steps to reveal your final character sheet.',
    splashIcon: '🌟',
  ),
  Question(
    text: 'When plans change at the last minute, how do you respond?',
    options: [
      'Adapt instantly and improvise',
      'Organize a quick huddle',
      'Check risks before acting',
      'Stick to the original plan',
    ],
    type: QuestionType.singleChoice,
    attributeScores: {
      'Adapt instantly and improvise': [Attribute.dexterity, Attribute.charisma],
      'Organize a quick huddle': [Attribute.charisma, Attribute.wisdom],
      'Check risks before acting': [Attribute.wisdom, Attribute.intelligence],
      'Stick to the original plan': [Attribute.constitution, Attribute.intelligence],
    },
  ),
];
