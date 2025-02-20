import 'package:flutter/material.dart';

class KeyboardButtonWidget extends StatelessWidget {
  final String letter;
  final bool isUsed;
  final bool isGameOver;
  final Function(String) onLetterPressed;

  const KeyboardButtonWidget({
    super.key,
    required this.letter,
    required this.isUsed,
    required this.isGameOver,
    required this.onLetterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: isUsed || isGameOver ? null : () => onLetterPressed(letter),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(45, 45),
          padding: EdgeInsets.zero,
          disabledBackgroundColor: Colors.grey.shade200,
          disabledForegroundColor: Colors.grey.shade400,
        ).copyWith(
          elevation:
              isUsed
                  ? const WidgetStatePropertyAll(0)
                  : WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.pressed) ? 2 : 4,
                  ),
        ),
        child: Text(
          letter,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
