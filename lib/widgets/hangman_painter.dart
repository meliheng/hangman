import 'package:flutter/material.dart';

class HangmanPainter extends CustomPainter {
  final int wrongGuesses;
  final BuildContext context;

  HangmanPainter(this.wrongGuesses, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).colorScheme.primary
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Base
    if (wrongGuesses > 0) {
      canvas.drawLine(
        Offset(size.width * 0.1, size.height * 0.9),
        Offset(size.width * 0.9, size.height * 0.9),
        paint,
      );
    }

    // Vertical pole
    if (wrongGuesses > 1) {
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.9),
        Offset(size.width * 0.5, size.height * 0.1),
        paint,
      );
    }

    // Top horizontal
    if (wrongGuesses > 2) {
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.1),
        Offset(size.width * 0.3, size.height * 0.1),
        paint,
      );
    }

    // Rope
    if (wrongGuesses > 3) {
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.1),
        Offset(size.width * 0.3, size.height * 0.2),
        paint,
      );
    }

    // Head
    if (wrongGuesses > 4) {
      canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.25),
        size.width * 0.08,
        paint,
      );
    }

    // Body and limbs
    if (wrongGuesses > 5) {
      // Body
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.33),
        Offset(size.width * 0.3, size.height * 0.5),
        paint,
      );

      // Arms
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.35),
        Offset(size.width * 0.2, size.height * 0.45),
        paint,
      );
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.35),
        Offset(size.width * 0.4, size.height * 0.45),
        paint,
      );

      // Legs
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.5),
        Offset(size.width * 0.2, size.height * 0.65),
        paint,
      );
      canvas.drawLine(
        Offset(size.width * 0.3, size.height * 0.5),
        Offset(size.width * 0.4, size.height * 0.65),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}