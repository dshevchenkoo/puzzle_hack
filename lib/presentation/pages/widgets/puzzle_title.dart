import 'package:flutter/material.dart';
import 'package:puzzle/theme/theme.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleTitle({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  /// The color of [title], defaults to [PuzzleTheme.titleColor].
  final Color color;

  @override
  Widget build(BuildContext context) {
    final titleColor = color;

    final textStyle = PuzzleTextStyle.headline3.copyWith(color: titleColor);
    final textAlign = TextAlign.center;

    return Center(
      child: SizedBox(
        width: 300,
        child: Center(
          child: AnimatedDefaultTextStyle(
            style: textStyle,
            duration: Duration(milliseconds: 530),
            child: Text(
              title,
              textAlign: textAlign,
            ),
          ),
        ),
      ),
    );
  }
}
