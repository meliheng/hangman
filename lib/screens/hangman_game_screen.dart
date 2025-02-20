import 'package:flutter/material.dart';
import 'dart:math';
import '../models/word_data.dart';
import '../widgets/hangman_painter.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          currentWord.word.split('').map((letter) {
            final index = currentWord.word.indexOf(letter);
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
    );
  }

  Widget buildKeyboard() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List.generate(26, (index) {
        final letter = String.fromCharCode(65 + index);
        final isUsed = triedLetters.contains(letter);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ElevatedButton(
            onPressed:
                isUsed || isGameLost() || isGameWon()
                    ? null
                    : () => guessLetter(letter),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(45, 45),
              padding: EdgeInsets.zero,
              disabledBackgroundColor: Colors.grey.shade200,
              disabledForegroundColor: Colors.grey.shade400,
            ).copyWith(
              elevation: isUsed ? MaterialStateProperty.all(0) : MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.pressed) ? 2 : 4,
              ),
            ),
            child: Text(
              letter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }

  Widget buildGameOverDialog() {
    if (!isGameWon() && !isGameLost()) return const SizedBox.shrink();
    
    return AlertDialog(
      title: Text(
        isGameWon() ? 'Congratulations!' : 'Game Over',
        style: TextStyle(
          color: isGameWon() ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        isGameWon()
            ? 'You won the game!'
            : 'The word was: ${currentWord.word}',
        style: const TextStyle(fontSize: 18),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => setState(() => startNewGame()),
          child: const Text('Play Again'),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
          if (isGameWon() || isGameLost())
            Container(
              color: Colors.black54,
              child: Center(child: buildGameOverDialog()),
            ),
        ],
      ),
    );
  }
}