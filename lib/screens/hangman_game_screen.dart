import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../widgets/hangman_painter.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/word_display_widget.dart';
import '../mixins/hangman_game_mixin.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  State<HangmanGame> createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> with HangmanGameMixin {
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
      isGameOver: isGameLost || isGameWon,
      onLetterPressed: guessLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          AppStrings.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => setState(() => startNewGame()),
              tooltip: AppStrings.newGameTooltip,
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
                    AppStrings.wrongGuessesFormat
                        .replaceAll('%d', wrongGuesses.toString())
                        .replaceAll('%d', maxWrongGuesses.toString()),
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    AppStrings.triedLettersFormat.replaceAll(
                      '%s',
                      triedLetters.join(", "),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  buildKeyboard(),
                ],
              ),
            ),
          ),
          if (isGameWon || isGameLost) buildGameOverDialog(),
        ],
      ),
    );
  }
}
