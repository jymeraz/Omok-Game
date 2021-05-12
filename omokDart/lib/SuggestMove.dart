import 'Model.dart';
import 'ConsoleUI.dart';
import 'dart:math';

/// Class to suggest moves to player.
class Suggest {

  /// Constructor.
  Suggest();

  /// Returns an index of the suggested move to player.
  /// The returned coordinates prioritize winning over blocking.
  /// If there is not a winning row, then it will block.
  suggestMove(Player player, Player computer, rows, empty){
    var fourRow = checkRows(player, 4, rows, empty);
    if (fourRow != null) {
      return fourRow;
    }
    var fourCol = checkCols(player, 4, rows, empty);
    if (fourCol != null) {
      return fourCol;
    }
    var fourRightDiag = rightDiag(player, 4, rows, empty);
    if (fourRightDiag != null) {
      return fourRightDiag;
    }
    var fourLeftDiag = leftDiag(player, 4, rows, empty);
    if (fourLeftDiag != null) {
      return fourLeftDiag;
    }

    var blockRow = checkRows(computer, 4, rows, empty);
    if (blockRow != null) {
      return blockRow;
    }
    var blockCol = checkCols(computer, 4, rows, empty);
    if (blockCol != null) {
      return blockCol;
    }
    var blockRightDiag = rightDiag(computer, 4, rows, empty);
    if (blockRightDiag != null) {
      return blockRightDiag;
    }
    var blockLeftDiag = leftDiag(computer, 4, rows, empty);
    if (blockLeftDiag != null) {
      return blockLeftDiag;
    }

    blockRow = checkRows(computer, 3, rows, empty);
    if (blockRow != null) {
      return blockRow;
    }
    blockCol = checkCols(computer, 3, rows, empty);
    if (blockCol != null) {
      return blockCol;
    }
    blockRightDiag = rightDiag(computer, 3, rows, empty);
    if (blockRightDiag != null) {
      return blockRightDiag;
    }
    blockLeftDiag = leftDiag(computer, 3, rows, empty);
    if (blockLeftDiag != null) {
      return blockLeftDiag;
    }

    var threeRow = checkRows(player, 3, rows, empty);
    if (threeRow != null) {
      return threeRow;
    }
    var threeCol = checkCols(player, 3, rows, empty);
    if (threeCol != null) {
      return threeCol;
    }
    var threeRightDiag = rightDiag(player, 3, rows, empty);
    if (threeRightDiag != null) {
      return threeRightDiag ;
    }
    var threeLeftDiag = leftDiag(player, 3, rows, empty);
    if (threeLeftDiag != null) {
      return threeLeftDiag;
    }

    var twoRow = checkRows(player, 2, rows, empty);
    if (twoRow != null) {
      return twoRow;
    }
    var twoCol = checkCols(player, 2, rows, empty);
    if (twoCol != null) {
      return twoCol;
    }
    var twoRightDiag = rightDiag(player, 2, rows, empty);
    if (twoRightDiag != null) {
      return twoRightDiag;
    }
    var twoLeftDiag = leftDiag(player, 2, rows, empty);
    if (twoLeftDiag != null) {
      return twoLeftDiag;
    }

    blockRow = checkRows(computer, 2, rows, empty);
    if (blockRow != null) {
      return blockRow;
    }
    blockCol = checkCols(computer, 2, rows, empty);
    if (blockCol != null) {
      return blockCol;
    }
    blockRightDiag = rightDiag(computer, 2, rows, empty);
    if (blockRightDiag != null) {
      return blockRightDiag;
    }
    blockLeftDiag = leftDiag(computer, 2, rows, empty);
    if (blockLeftDiag != null) {
      return blockLeftDiag;
    }

    blockRow = checkRows(computer, 1, rows, empty);
    if (blockRow != null) {
      return blockRow;
    }
    blockCol = checkCols(computer, 1, rows, empty);
    if (blockCol != null) {
      return blockCol;
    }
    blockRightDiag = rightDiag(computer, 1, rows, empty);
    if (blockRightDiag != null) {
      return blockRightDiag;
    }
    blockLeftDiag = leftDiag(computer, 1, rows, empty);
    if (blockLeftDiag != null) {
      return blockLeftDiag;
    }

    var oneRow = checkRows(player, 1, rows, empty);
    if (oneRow != null) {
      return oneRow;
    }
    var oneCol = checkCols(player, 1, rows, empty);
    if (oneCol != null) {
      return oneCol;
    }
    var oneRightDiag = rightDiag(player, 1, rows, empty);
    if (oneRightDiag != null) {
      return oneRightDiag;
    }
    var oneLeftDiag = leftDiag(player, 1, rows, empty);
    if (oneLeftDiag != null) {
      return oneLeftDiag;
    }
    return randomIndex(rows, empty);
  }

  /// Returns an random index to start the game.
  randomIndex(rows, empty) {
    var random = Random();
    var row =  random.nextInt(rows.length-1);
    var col =  random.nextInt(rows.length-1);
    return Index(row, col);
  }

  /// Returns an index of the suggested move to player.
  /// Checks the rows of the board.
  checkRows(Player player, rowSize, rows, empty) {
    for (var i = 0; i < rows.length; i++) {
      for (var j = 0; j < rows.length-4; j++) {
        if (rowSize == 4) {
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+4);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == player.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == player.stone) {
            return Index(i, j+1);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == player.stone) {
            return Index(i, j+3);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == player.stone) {
            return Index(i, j+2);
          }
        }

        if (rowSize == 3) {
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+3);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+2);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+1);
          }
        }

        if (rowSize == 2) {
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+2);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
        }

        if (rowSize == 1) {
          if (rows[i][j].stone == player.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+1);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == player.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == player.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+1);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == player.stone &&
              rows[i][j + 4].stone == empty.stone) {
            return Index(i, j+2);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i][j + 1].stone == empty.stone &&
              rows[i][j + 2].stone == empty.stone &&
              rows[i][j + 3].stone == empty.stone &&
              rows[i][j + 4].stone == player.stone) {
            return Index(i, j+3);
          }
        }
      }
    }
  }

  /// Returns an index of the suggested move to player.
  /// Checks the columns of the board.
  checkCols(Player player, colSize, rows, empty) {
    for (var j = 0; j < rows.length; j++) {
      for (var i = 0; i < rows.length-4; i++) {
        if (colSize == 4) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+4, j);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == player.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == player.stone) {
            return Index(i+3, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == empty.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == player.stone) {
            return Index(i+1, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == empty.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == player.stone) {
            return Index(i+2, j);
          }
        }

        if (colSize == 3) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+3, j);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == empty.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+1, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == empty.stone &&
              rows[i + 3][j].stone == player.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+2, j);
          }
        }

        if (colSize == 2) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == empty.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+2, j);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i, j);
          }
        }

        if (colSize == 1) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j].stone == empty.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i+1, j);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j].stone == player.stone &&
              rows[i + 2][j].stone == player.stone &&
              rows[i + 3][j].stone == empty.stone &&
              rows[i + 4][j].stone == empty.stone) {
            return Index(i, j);
          }
        }
      }
    }
  }

  /// Returns an index of the suggested move to player.
  /// Checks the right diagonals of the board.
  rightDiag(Player player, diagSize, rows, empty) {
    for (var i = 0; i < rows.length-4; i++) {
      for (var j = 0; j < rows.length-4; j++) {
        if (diagSize == 4) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+4, j+4);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == player.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == empty.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == player.stone) {
            return Index(i+1, j+1);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == player.stone) {
            return Index(i+3, j+3);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == empty.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == player.stone) {
            return Index(i+2, j+2);
          }
        }

        if (diagSize == 3) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+3, j+3);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == empty.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+1, j+1);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == empty.stone &&
              rows[i + 3][j + 3].stone == player.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+2, j+2);
          }
        }

        if (diagSize == 2) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == empty.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+2, j+2);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == player.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
        }

        if (diagSize == 1) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j + 1].stone == empty.stone &&
              rows[i + 2][j + 2].stone == empty.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i+1, j+1);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j + 1].stone == player.stone &&
              rows[i + 2][j + 2].stone == empty.stone &&
              rows[i + 3][j + 3].stone == empty.stone &&
              rows[i + 4][j + 4].stone == empty.stone) {
            return Index(i, j);
          }
        }
      }
    }
  }

  /// Returns an index of the suggested move to player.
  /// Checks the left diagonals of the board.
  leftDiag(Player player, diagSize, rows, empty) {
    for (var i = 0; i < rows.length-4; i++) {
      for (var j = rows.length-1; j > 3; j--) {
        if (diagSize == 4) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+4, j-4);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == player.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == player.stone) {
            return Index(i+3, j-3);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == empty.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == player.stone) {
            return Index(i+1, j-1);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == empty.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == player.stone) {
            return Index(i+2, j-2);
          }
        }

        if (diagSize == 3) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+3, j-3);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i, j);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == empty.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+1, j-1);
          }
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == empty.stone &&
              rows[i + 3][j - 3].stone == player.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+2, j-2);
          }
        }

        if (diagSize == 2) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == empty.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+2, j-2);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == player.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i, j);
          }
        }

        if (diagSize == 1) {
          if (rows[i][j].stone == player.stone &&
              rows[i + 1][j - 1].stone == empty.stone &&
              rows[i + 2][j - 2].stone == empty.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i+1, j-1);
          }
          if (rows[i][j].stone == empty.stone &&
              rows[i + 1][j - 1].stone == player.stone &&
              rows[i + 2][j - 2].stone == empty.stone &&
              rows[i + 3][j - 3].stone == empty.stone &&
              rows[i + 4][j - 4].stone == empty.stone) {
            return Index(i, j);
          }
        }
      }
    }
  }
}

