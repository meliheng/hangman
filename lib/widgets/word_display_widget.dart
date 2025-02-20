import 'package:flutter/material.dart';

class WordDisplayWidget extends StatelessWidget {
  final String word;
  final String description;
  final List<bool> guessedLetters;

  const WordDisplayWidget({
    super.key,
    required this.word,
    required this.description,
    required this.guessedLetters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.split('').map((letter) {
            final index = word.indexOf(letter);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                guessedLetters[index] ? letter : '_',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}