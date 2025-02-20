import 'dart:math';

import 'package:flutter/material.dart';

import '../models/word_data.dart';
import '../widgets/game_over_dialog_widget.dart';
import '../widgets/hangman_painter.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/word_display_widget.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  State<HangmanGame> createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  late WordData currentWord;
  late List<bool> guessedLetters;
  Set<String> triedLetters = {};
  int wrongGuesses = 0;
  final int maxWrongGuesses = 6;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    final random = Random();
    currentWord = wordList[random.nextInt(wordList.length)];
    guessedLetters = List.filled(currentWord.word.length, false);
    triedLetters = {};
    wrongGuesses = 0;
  }

  void guessLetter(String letter) {
    if (triedLetters.contains(letter)) return;

    setState(() {
      triedLetters.add(letter);
      bool found = false;

      for (int i = 0; i < currentWord.word.length; i++) {
        if (currentWord.word[i] == letter) {
          guessedLetters[i] = true;
          found = true;
        }
      }

      if (!found) {
        wrongGuesses++;
      }
    });
  }

  bool isGameWon() {
    return guessedLetters.every((letter) => letter);
  }

  bool isGameLost() {
    return wrongGuesses >= maxWrongGuesses;
  }

  Widget buildHangman() {
    return CustomPaint(
      size: const Size(200, 250),
      painter: HangmanPainter(wrongGuesses, context),
    );
  }

  Widget buildWord() {
    return WordDisplayWidget(
      word: currentWord.word,
      description: currentWord.description,
      guessedLetters: guessedLetters,
    );
  }

  Widget buildKeyboard() {
    return KeyboardWidget(
      triedLetters: triedLetters,
      isGameOver: isGameLost() || isGameWon(),
      onLetterPressed: guessLetter,
    );
  }

  Widget buildGameOverDialog() {
    if (!isGameWon() && !isGameLost()) return const SizedBox.shrink();

    return GameOverDialogWidget(
      isWon: isGameWon(),
      word: currentWord.word,
      onPlayAgain: () => setState(() => startNewGame()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text(
          'Hangman Game',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => setState(() => startNewGame()),
              tooltip: 'New Game',
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildHangman(),
                  Text(
                    currentWord.description,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  buildWord(),
                  Text(
                    'Wrong Guesses: $wrongGuesses/$maxWrongGuesses',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Tried Letters: ${triedLetters.join(", ")}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  buildKeyboard(),
                ],
              ),
            ),
          ),
          if (isGameWon() || isGameLost()) buildGameOverDialog(),
        ],
      ),
    );
  }
}
