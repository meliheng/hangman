# Hangman Game

A modern implementation of the classic Hangman game built with Flutter. This interactive game features a clean UI, animated components, and an engaging gameplay experience.

## Features

- Interactive keyboard interface
- Visual hangman progression
- Word descriptions for hints
- Game state tracking (tried letters, wrong guesses)
- Win/lose detection with game over dialog
- New game functionality
- Responsive design

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK (latest version)
- iOS Simulator or Android Emulator

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/meliheng/hangman.git
   cd hangman
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## How to Play

1. The game starts with a hidden word and its description as a hint
2. Click on the letter buttons to make guesses
3. Correct guesses reveal the letter in the word
4. Wrong guesses progress the hangman drawing
5. Win by guessing the word before the hangman is complete
6. Lose if the hangman drawing completes before guessing the word
7. Click the refresh button to start a new game at any time

## Project Structure

```
lib/
├── constants/
│   └── strings.dart         # App string constants
├── mixins/
│   └── hangman_game_mixin.dart  # Game logic
├── models/
│   └── word_data.dart       # Word data structure
├── screens/
│   └── hangman_game_screen.dart  # Main game screen
├── theme/
│   └── app_theme.dart       # App theming
├── widgets/
│   ├── game_over_dialog_widget.dart
│   ├── hangman_painter.dart
│   ├── keyboard_button_widget.dart
│   ├── keyboard_widget.dart
│   └── word_display_widget.dart
└── main.dart               # App entry point
```

## Technical Implementation

- Built with Flutter for cross-platform compatibility
- Uses Material Design components
- Implements custom painting for the hangman drawing
- Utilizes Flutter's state management
- Modular architecture with separated concerns
- Custom widgets for reusability

## License

This project is licensed under the MIT License - see the LICENSE file for details.
