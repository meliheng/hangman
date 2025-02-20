import 'package:flutter/material.dart';
import '../constants/strings.dart';

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
            isWon ? AppStrings.congratulationsTitle : AppStrings.gameOverTitle,
            style: TextStyle(
              color: isWon ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            isWon
                ? AppStrings.youWonMessage
                : AppStrings.wordWasFormat.replaceAll('%s', word),
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            ElevatedButton(
              onPressed: onPlayAgain,
              child: Text(AppStrings.playAgainButton),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
