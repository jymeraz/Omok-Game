import 'ConsoleUI.dart';
import 'WebClient.dart';
import 'Model.dart';

/// Class that coordinates the tasks.
class Controller {
  /// Create the user interface, web client, and board classes.
  /// Coordinate the set up of the game and connection to server.
  /// Call a helper function to play the game.
  void start() async {
    var ui = ConsoleUI();

    ui.showMessage('Welcome to Omok!');
    var server = ui.promptServer(WebClient.DEFAULT_SERVER);

    ui.showMessage('Obtaining server information...');
    var web = WebClient(server);
    var info = await web.getInfo();
    var strategy = ui.promptStrategy(info.strategies);

    ui.showMessage('Creating a new game...');
    var newGame = await web.newGame(strategy);
    var player = Player('X');
    var computer = Player('O');
    var board = Board(info.size);
    ui.board = board;

    await play(ui, web, newGame, board, player, computer);
  }

  /// Play the game until there is a win or draw.
  /// Prompt the user to make a move and place their move on the board.
  /// Include a hint on the board if the user asks for one.
  /// Save the server's counter move on the board.
  /// In a win, change the winning row and return.
  /// In a draw, return.
  /// Notify the user of their win/lose/draw status.
  Future<Null> play(ui, web, newGame, board, player, computer) async {
    while (true) {
      ui.showBoard();
      ui.showMessage('Enter * to receive a hint');

      var prompt = ui.promptMove();
      if (prompt == '*') {
        var suggested = board.suggestMove(player, computer);
        ui.showBoard();
        if (suggested != null) {
          board.makeEmpty(suggested);
          ui.showMessage('Suggested move: ${suggested.x+1} ${suggested.y+1}');
        }
        prompt = ui.promptMove();
      }

      board.place(player, prompt);
      var makeMove = await web.play(newGame.pid,prompt);

      if (makeMove.ack_move.isWin) {
        board.winRow(makeMove.ack_move.row);
        ui.showBoard();
        ui.showMessage('You Won!');
        return null;
      } else if (makeMove.move.isWin) {
        board.winRow(makeMove.move.row);
        ui.showBoard();
        ui.showMessage('You Lost :(');
        return null;
      } else if (makeMove.ack_move.isDraw || makeMove.move.isDraw) {
        ui.showMessage('Draw Game!');
        return null;
      }
      board.place(computer, makeMove.move);
    }
  }
}
