import 'package:flutter/material.dart';
import 'package:puzzle/theme/theme.dart';

/// {@template number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class NumberOfMovesAndTilesLeft extends StatelessWidget {
  /// {@macro number_of_moves_and_tiles_left}
  const NumberOfMovesAndTilesLeft({
    Key? key,
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    required this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The number of tiles left to be displayed.
  final int numberOfTilesLeft;

  /// The color of texts that display [numberOfMoves] and [numberOfTilesLeft].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textColor = color;

    // TODO обратить внимание
    const mainAxisAlignment = MainAxisAlignment.center;

    return Semantics(
      label: '${numberOfMoves.toString()} ${numberOfTilesLeft.toString()}',
      child: ExcludeSemantics(
        child: Row(
          key: const Key('number_of_moves_and_tiles_left'),
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            AnimatedDefaultTextStyle(
              key: const Key('number_of_moves_and_tiles_left_moves'),
              style: PuzzleTextStyle.headline4.copyWith(
                color: textColor,
              ),
              duration: Duration(milliseconds: 530),
              child: Text(numberOfMoves.toString()),
            ),
            AnimatedDefaultTextStyle(
              style: PuzzleTextStyle.bodySmall.copyWith(
                color: textColor,
              ),
              duration: Duration(milliseconds: 530),
              child: Text(' Moves | '),
            ),
            AnimatedDefaultTextStyle(
              key: const Key('number_of_moves_and_tiles_left_tiles_left'),
              style: PuzzleTextStyle.headline4.copyWith(
                color: textColor,
              ),
              duration: Duration(milliseconds: 530),
              child: Text(numberOfTilesLeft.toString()),
            ),
            AnimatedDefaultTextStyle(
              style: PuzzleTextStyle.bodySmall.copyWith(
                color: textColor,
              ),
              duration: Duration(milliseconds: 530),
              child: Text(' Tiles'),
            ),
          ],
        ),
      ),
    );
  }
}
