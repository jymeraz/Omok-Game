/// Name: Janeth Meraz
/// Course: CS 3360
/// Professor: Yoonsik Cheon
/// TA: Ivan Gastelum
/// Assignment: Omok Dart Project

import 'package:omokDart/SuggestMove.dart';
import 'ConsoleUI.dart';

/// Class that contains the structure of the board that will be played on.
class Board {

  /// Character that identifies the winning row.
  static final _WIN = Player('W');

  /// Character that identifies an empty space.
  static final _EMPTY = Player('.');

  /// Character that suggests where to the player where to place their stone.
  static final _SUGGESTION = Player('*');

  /// integer that stores the size of the board.
  int size;

  /// List of lists containing a type Player in each index.
  var rows;

  /// Board constructor.
  /// Makes use of language features unique to dart such as .generate.
  Board(size){
    this.size = size;
    rows = List<List<Player>>.generate(size, (row) => List<Player>.generate(size, (column) => _EMPTY));
  }

  /// Returns true the index is empty.
  bool isEmpty(Index index) => rows[index.x][index.y].stone == '.';

  /// Change the index to the player type passed in the parameters.
  /// There is no need to check if it is empty since that was done in the user interface class.
  void place(Player player, index) => rows[index.x][index.y] = player;

  /// Change the values of the winning row to display the special winning character.
  void winRow(row) {
    for (var i = 0; i < row.length; i = i + 2) {
      rows[row[i]][row[i+1]] = _WIN;
    }
  }

  /// Remove the suggested move from the board.
  makeEmpty(indices) {
    place(_EMPTY, indices);
  }

  /// Suggest a move to the player.
  /// Create an instance of the class Suggest.
  /// Place the indices of the suggested move on the board.
  /// Return the indices of the move.
  suggestMove(player, computer){
    var suggest = Suggest();
    var move = suggest.suggestMove(player, computer, rows, _EMPTY);
    if (move != null) {
      place(_SUGGESTION, move);
    }
    return move;
  }
}

/// Player class used to identify the contents of each place in the board.
class Player {
  /// String variable to denote the type of character stored in each place.
  String stone;
  Player(this.stone);
}
