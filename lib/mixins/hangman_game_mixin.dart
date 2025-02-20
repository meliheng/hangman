import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hangman/widgets/game_over_dialog_widget.dart';
import '../models/word_data.dart';

mixin HangmanGameMixin<T extends StatefulWidget> on State<T> {
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
    setState(() {});
  }

  bool get isGameWon {
    return guessedLetters.every((letter) => letter);
  }

  bool get isGameLost {
    return wrongGuesses >= maxWrongGuesses;
  }

  Widget buildGameOverDialog() {
    if (!isGameWon && !isGameLost) return const SizedBox.shrink();

    return GameOverDialogWidget(
      isWon: isGameWon,
      word: currentWord.word,
      onPlayAgain: () => setState(() => startNewGame()),
    );
  }
}
