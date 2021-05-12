/// Name: Janeth Meraz
/// Course: CS 3360
/// Professor: Yoonsik Cheon
/// TA: Ivan Gastelum
/// Assignment: Omok Dart Project

import 'dart:convert';

/// Class to parse the json inputs received from the server.
class ResponseParser {

  /// Return the size and strategies in the json formatted as a class.
  Info parseInfo(response) {
    var decode = json.decode(response);
    return Info(decode['size'],decode['strategies']);
  }

  /// Create a new game in the json.
  /// Decode values in the json that may not be present, such as "reason" in case there is an error in creating the game.
  /// Return the new game information formatted as a class.
  NewGame parseStrategy(response) {
    var decode = json.decode(response);
    var newGame = NewGame(decode['response'],decode['pid'], decode['reason']);
    if (newGame.reason != null) {
      throw('Server error in creating a new game.');
    }
    return newGame;
  }

  /// Decode the result of making a move on the server.
  /// Decode values in the json that may not be present, such as "reason" in case there is an error in making a move.
  /// Return the information of making a move formatted as a class.
  MakeMove parseMove(response) {
    var decode = json.decode(response);
    var move = MakeMove(decode['response'], decode['ack_move'], decode['move'], decode['reason']);
    if (move.reason != null) {
      throw('Server error in creating a making a move.');
    }
    return move;
  }
}

/// Class containing the information to create a game.
class Info {

  /// Variable containing the size of the board.
  final size;

  /// Variable contianing the strategies available.
  final strategies;

  Info(this.size, this.strategies);
}

/// Class containing the information when creating a new game.
class NewGame {

  /// Variable containing whether the new game was successfully created.
  final accepted;

  /// Variable containing the pid of the game.
  final pid;

  /// Variable containing the reason the game couldn't be created.
  final reason;

  NewGame(this.accepted, this.pid, this.reason);
}

/// Class containing the information for making a move.
class MakeMove {

  /// Variable containing whether the move was successfully made.
  var response;

  /// Variable containing the information for the user move.
  var ack_move;

  /// Variable containing the information for the computer move.
  var move;

  /// Variable containing the reason the move wasn't made.
  var reason;

  /// Constructor setting the values for MakeMove.
  /// If the computer doesn't exist, it is not set.
  MakeMove(response, ack_move, move, reason) {
    this.response = response;
    this.ack_move = Move(ack_move['x'], ack_move['y'], ack_move['isWin'], ack_move['isDraw'], ack_move['row']);
    if (move == null) {
      this.move = null;
    } else {
      this.move = Move(
          move['x'], move['y'], move['isWin'], move['isDraw'], move['row']);
    }
    this.reason = reason;
  }
}

/// Class containing detailed information for the player move.
class Move {

  /// Value containing the x-coordinate of the move.
  final x;

  /// Value containing the y-coordinate of the move.
  final y;

  /// Value containing if the move was a winning move.
  final isWin;

  /// Value containing the move resulted in a draw.
  final isDraw;

  /// Value containing the row of the winning move if it is a winning move.
  final row;

  Move(this.x, this.y, this.isWin, this.isDraw, this.row);
}