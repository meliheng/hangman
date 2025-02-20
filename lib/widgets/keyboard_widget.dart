import 'package:flutter/material.dart';
import 'keyboard_button_widget.dart';

class KeyboardWidget extends StatelessWidget {
  final Set<String> triedLetters;
  final bool isGameOver;
  final Function(String) onLetterPressed;

  const KeyboardWidget({
    super.key,
    required this.triedLetters,
    required this.isGameOver,
    required this.onLetterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(26, (index) {
        final letter = String.fromCharCode(65 + index);
        final isUsed = triedLetters.contains(letter);
        return KeyboardButtonWidget(
          letter: letter,
          isUsed: isUsed,
          isGameOver: isGameOver,
          onLetterPressed: onLetterPressed,
        );
      }),
    );
  }
}