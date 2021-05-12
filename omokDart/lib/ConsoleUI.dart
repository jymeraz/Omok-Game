/// Name: Janeth Meraz
/// Course: CS 3360
/// Professor: Yoonsik Cheon
/// TA: Ivan Gastelum
/// Assignment: Omok Dart Project

import 'dart:io';
import 'Model.dart';

/// Class that controls the user interface.
class ConsoleUI {
  /// The board storing the empty places and spaces being taken up in the game.
  Board _board;

  /// The board setter.
  set board(Board board){
    _board = board;
  }

  /// Displays the current state of the board.
  /// Makes use of language features unique to Dart such as .generate, .forEach, and .map.
  void showBoard(){
    var columnIndices = List<int>.generate(_board.size,(i)=>(i+1)%10).join(' ');
    stdout.writeln(' x $columnIndices');

    var separator = List<String>.generate(_board.size,(i)=>'-').join(' ');
    stdout.writeln('y $separator');

    _board.rows.forEach((row) => stdout.writeln('${(_board.rows.indexOf(row)+1)%10}| ${row.map((player) => player.stone).join(' ')}'));
  }

  /// Shows a message to the console.
  void showMessage(msg) {
    stdout.writeln(msg);
  }

  /// Prompts the user to enter a URL.
  /// If the user URL is not valid, the default URL will be used.
  /// Returns the string of the chosen URL.
  String promptServer(defaultURL) {
    stdout.write('Enter the server URL [default: $defaultURL]');
    var userURL = stdin.readLineSync();
    if (!Uri.parse(userURL).isAbsolute){
      userURL = defaultURL;
    }
    return userURL;
  }

  /// Prompts the user to enter the strategy they want to use.
  /// Displays the strategies available in the server.
  /// If the user does not select a strategy, a default one is chosen.
  /// If the user inputs an invalid strategy, they are notified and can try again.
  /// Returns the selected strategy.
  String promptStrategy(strategies) {
    while (true) {
      try {
        var defaultStrategy = 1;
        stdout.write('Select the server strategy: ');
        strategies.forEach((strategy) =>  stdout.write('${strategies.indexOf(strategy)+1}. $strategy '));
        stdout.write('[default: $defaultStrategy] ');

        var userInput = stdin.readLineSync();
        if (userInput.isEmpty){
          stdout.writeln('Selected strategy: ${strategies[defaultStrategy-1]}');
          return strategies[defaultStrategy-1];
        }

        var convertedInput = int.parse(userInput);
        if (convertedInput <= 0 || convertedInput > strategies.length){
          stdout.writeln('Invalid selection: $convertedInput');
        } else {
          stdout.writeln('Selected strategy: ${strategies[convertedInput-1]}');
          return strategies[convertedInput-1];
        }
      } on FormatException {
        stdout.writeln('Invalid selection');
        stdout.writeln('Failed to store play data');
      }
    }
  }

  /// Prompt the user to make a move on the board.
  /// User input is sent to a helper method to format it appropriately.
  /// If the user picks a spot that is not empty, they are notified and can try again.
  /// If the user does not type valid indices, they are notified and can try again.
  /// Returns the selected move.
  promptMove() {
    while (true) {
      stdout.write('Enter x and y (1-${_board.size}, e.g. 12 3): ');
      var userInput = stdin.readLineSync().trim();
      if (userInput == '*') {
        return userInput;
      }
      try {
        var formatInput = _formatMoves(userInput);
        if (_board.isEmpty(formatInput)) {
          return formatInput;
        } else {
          stdout.writeln('Not Empty!');
          continue;
        }
      } on FormatException {
        stdout.writeln('Invalid!');
      }
    }
  }

  /// Format the inputted moves of the user.
  /// Split the moves based on white space and iterate through them.
  /// Throws a format exception if the user entered more than two numbers.
  /// Throws a format exception if the user entered values other than numbers.
  /// Throws a format exception if the user entered number out of bounds.
  /// Returns the indices by creating an Index object.
  Index _formatMoves(input){
    var inputList = input.split(' ');
    var indices = <int>[];

    if (inputList.length != 2) {
      throw FormatException();
    }

    for (var index in inputList){
      var curr = int.parse(index);
      if (curr >= 1 && curr <= _board.size){
          indices.add(curr-1);
      } else {
        throw FormatException();
      }
    }
    return Index(indices[0], indices[1]);
  }
}

/// Class that keeps track of the x and y coordinates of moves.
class Index {
  /// x-coordinate in board.
  final int x;

  /// y-coordinate in board.
  final int y;
  Index(this.x, this.y);
}