import 'package:flutter/material.dart';

class GameOverDialogWidget extends StatelessWidget {
  final bool isWon;
  final String word;
  final VoidCallback onPlayAgain;

  const GameOverDialogWidget({
    super.key,
    required this.isWon,
    required this.word,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: AlertDialog(
          title: Text(
            isWon ? 'Congratulations!' : 'Game Over',
            style: TextStyle(
              color: isWon ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            isWon ? 'You won the game!' : 'The word was: $word',
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              onPressed: onPlayAgain,
              child: const Text('Play Again'),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}