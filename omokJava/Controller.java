
/**
 * Class that coordinates the tasks.
 */
public class Controller {
    /**
     * Configure the game settings.
     * Welcome the player, prompt them to enter the server url.
     * Prompt the player to input the difficulty level.
     * Begin the game.
     */
    public void start(){
        ConsoleUI ui = new ConsoleUI();
        ui.showMessage("Welcome to Omok!");

        String server = ui.promptServer(WebClient.DEFAULT_SERVER);
        ui.showMessage("Obtaining server information...");

        WebClient web = new WebClient(server);
        Info info = web.getInfo();

        String strategy = ui.promptStrategy(info.strategies);

        ui.showMessage("Creating a new game...");
        NewGame newGame = web.newGame(strategy);

        Board board = new Board(info.size);
        ui.setBoard(board);
        play(ui, web, newGame, board, new Player('X'), new Player('O'));
    }

    /**
     * Play the game until there is a win or draw.
     * Prompt the user to make a move and place their move on the board.
     * Notify the user of the game's results.
     * @param ui user interface object
     * @param web web client object connected to the server
     * @param newGame object with the information of the game
     * @param board object with the current state of the board
     * @param player object with the player's stone
     * @param computer object with the computer's stone
     */
    void play(ConsoleUI ui, WebClient web, NewGame newGame, Board board, Player player, Player computer) {
        while (true) {
            ui.showBoard();

            Index prompt = ui.promptMove();
            board.place(player, prompt.x, prompt.y);

            MakeMove makeMove = web.play(newGame.pid,prompt);

            if (makeMove.ack_move.isWin) {
                board.winRow(makeMove.ack_move.row);
                ui.showBoard();
                ui.showMessage("You Won!");
                return;
            } else if (makeMove.move.isWin) {
                board.winRow(makeMove.move.row);
                ui.showBoard();
                ui.showMessage("You Lost :(");
                return;
            } else if (makeMove.ack_move.isDraw || makeMove.move.isDraw) {
                ui.showMessage("Draw Game!");
                return;
            }
            board.place(computer, makeMove.move.x, makeMove.move.y);
        }
    }
}
