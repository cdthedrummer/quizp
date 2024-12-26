import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final List<String> options;
  final QuestionType type;
  final List<String>? previousAnswer;
  final void Function(List<String>) onAnswer;

  const QuestionCard({
    super.key,
    required this.question,
    required this.options,
    required this.type,
    required this.onAnswer,
    this.previousAnswer,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  final List<String> _selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    if (widget.previousAnswer != null) {
      _selectedAnswers.addAll(widget.previousAnswer!);
    }
  }

  void _handleSelection(String option, bool? value) {
    setState(() {
      if (widget.type == QuestionType.singleChoice) {
        _selectedAnswers
          ..clear()
          ..add(option);
        widget.onAnswer(_selectedAnswers);
      } else if (widget.type == QuestionType.multiChoice) {
        if (value ?? false) {
          _selectedAnswers.add(option);
        } else {
          _selectedAnswers.remove(option);
        }
      } else if (widget.type == QuestionType.scale) {
        _selectedAnswers
          ..clear()
          ..add(option);
        widget.onAnswer(_selectedAnswers);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand',
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (widget.type == QuestionType.scale)
              _buildScaleOptions()
            else
              ...widget.options.map((option) => _buildOption(option)),
            if (widget.type == QuestionType.multiChoice)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: _selectedAnswers.isNotEmpty ? () => widget.onAnswer(_selectedAnswers) : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String option) {
    final isSelected = _selectedAnswers.contains(option);
    final color = Theme.of(context).primaryColor;

    if (widget.type == QuestionType.singleChoice) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          color: isSelected ? color.withAlpha(20) : null,
        ),
        child: RadioListTile<String>(
          title: Text(
            option,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? color : null,
            ),
          ),
          value: option,
          groupValue: _selectedAnswers.isNotEmpty ? _selectedAnswers.first : null,
          onChanged: (value) => _handleSelection(option, true),
          activeColor: color,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          color: isSelected ? color.withAlpha(20) : null,
        ),
        child: CheckboxListTile(
          title: Text(
            option,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? color : null,
            ),
          ),
          value: isSelected,
          onChanged: (value) => _handleSelection(option, value),
          activeColor: color,
          checkColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  Widget _buildScaleOptions() {
    final color = Theme.of(context).primaryColor;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.options.map((option) {
        final isSelected = _selectedAnswers.contains(option);
        return GestureDetector(
          onTap: () => _handleSelection(option, true),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? color : Colors.grey.shade100,
              border: Border.all(
                color: isSelected ? color : Colors.grey.shade300,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withAlpha(76),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}