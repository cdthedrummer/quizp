class Question {
  final String text;
  final List<String> options;
  final Map<String, int> attributeScores;
  final bool isMultiSelect;

  Question({
    required this.text,
    required this.options,
    required this.attributeScores,
    this.isMultiSelect = false,
  });
}