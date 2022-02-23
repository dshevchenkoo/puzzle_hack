import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle/model/tile.dart';
import 'package:puzzle/presentation/bloc/puzzle_bloc.dart';
import 'package:puzzle/presentation/bloc/puzzle_event.dart';
import 'package:puzzle/presentation/pages/widgets/puzzle_layout_delegate.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PuzzleView();
  }
}

/// {@template puzzle_view}
/// Displays the content for the [PuzzlePage].
/// {@endtemplate}
class PuzzleView extends StatelessWidget {
  /// {@macro puzzle_view}
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO (dsh) перемешивать или нет
    const bool shufflePuzzle = true;

    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 530),
        decoration: BoxDecoration(color: Colors.white),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              // TODO количество ячеек пазла
              create: (context) => PuzzleBloc(4)
                ..add(
                  PuzzleInitialized(
                    shufflePuzzle: shufflePuzzle,
                  ),
                ),
            ),
          ],
          child: const _Puzzle(
            key: Key('puzzle_view_puzzle'),
          ),
        ),
      ),
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: const [
                    // PuzzleHeader(),
                    PuzzleSections(),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

/// {@template puzzle_sections}
/// Displays start and end sections of the puzzle.
/// {@endtemplate}
class PuzzleSections extends StatelessWidget {
  /// {@macro puzzle_sections}
  const PuzzleSections({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PuzzleBoard(),
      ],
    );
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
@visibleForTesting
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    const layoutDelegate = SimplePuzzleLayoutDelegate();

    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    return Column(
      children: [
        layoutDelegate.startSectionBuilder(state),
        layoutDelegate.boardBuilder(
          size,
          puzzle.tiles
              .map(
                (tile) => _PuzzleTile(
                  key: Key('puzzle_tile_${tile.value.toString()}'),
                  tile: tile,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;
  static const layoutDelegate = SimplePuzzleLayoutDelegate();

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    return tile.isWhitespace
        ? layoutDelegate.whitespaceTileBuilder()
        : layoutDelegate.tileBuilder(tile, state);
  }
}

/// The global key of [PuzzleTitle].
///
/// Used to animate the transition of [PuzzleTitle] when changing a theme.
final puzzleTitleKey = GlobalKey(debugLabel: 'puzzle_title');

/// The global key of [NumberOfMovesAndTilesLeft].
///
/// Used to animate the transition of [NumberOfMovesAndTilesLeft]
/// when changing a theme.
final numberOfMovesAndTilesLeftKey =
    GlobalKey(debugLabel: 'number_of_moves_and_tiles_left');
