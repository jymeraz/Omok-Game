/**
 * Name: Janeth Meraz
 * Professor: Yoonsik Cheon
 * Project: Omok Java Project
 */

import org.json.JSONArray;
import java.util.Scanner;
import java.net.URL;

/**
 * Class that controls the user interface.
 */
public class ConsoleUI {

    /**
     * Board variable keeping track of the current state of the board.
     */
    private Board board;

    /**
     * Scanner variable to scan user input.
     */
    private final Scanner scanner = new Scanner(System.in);

    /**
     * Board setter.
     * @param board Board storing all the moves
     */
    public void setBoard(Board board) {
        this.board = board;
    }

    /**
     * Print the current state of the board.
     */
    void showBoard() {
        System.out.print("x ");
        for (int i = 0; i < board.size; i++) {
            System.out.print((i+1)%10 + " ");
        }
        System.out.println();
        System.out.print("y ");
        for (int i = 0; i < board.size; i++) {
            System.out.print("- ");
        }
        System.out.println();

        for (int i = 0; i < board.size; i++) {
            System.out.print((i+1)%10 + "| ");
            for (int j = 0; j < board.size; j++) {
                System.out.print(board.rows[i][j].stone + " ");
            }
            System.out.println();
        }
    }

    /**
     * Print a message to the console.
     * @param msg message being printed
     */
    void showMessage(String msg) {
        System.out.println(msg);
    }

    /**
     * Prompt the user to enter the server url.
     * Use the default url if no url was entered or if the entered url was invalid.
     * @param defaultURL default server url
     * @return chosen server url
     */
    String promptServer(String defaultURL) {
        System.out.print("Enter the server URL [default: " + defaultURL + "]");
        String userURL = scanner.nextLine();
        try {
            new URL(userURL).toURI();
            return userURL;
        } catch (Exception e) {
            return defaultURL;
        }
    }

    /**
     * Prompt the user to enter a strategy.
     * Print the strategies in the json.
     * Allow the user multiple tries if their input was invalid.
     * @param strategies list of strategies in the server
     * @return String strategy choice
     */
    public String promptStrategy(JSONArray strategies) {
        while (true) {
            try {
                int defaultStrategy = 1;
                System.out.print("Select the server strategy: ");
                for (int i = 0; i < strategies.length(); i++) {
                    System.out.print(i+1 + "." + strategies.get(i) + " ");
                }
                System.out.print("[default: " + defaultStrategy + "] ");

                String userInput = scanner.nextLine();

                if (userInput.length() == 0) {
                    System.out.println("Selected strategy: " + strategies.get(0));
                    return (String) strategies.get(0);
                }

                int convertedInput = Integer.parseInt(userInput);
                if (convertedInput <= 0 || convertedInput > strategies.length()) {
                    System.out.println("Invalid selection: " + convertedInput);
                } else {
                    System.out.println("Selected strategy: " + strategies.get(convertedInput-1));
                    return (String) strategies.get(convertedInput-1);
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid selection");
            }
        }
    }

    /**
     * Prompt the user to make a move.
     * Allow the user to reenter their move if their move was invalid.
     * Invalid moves are not empty or are out of bounds.
     * @return Index of the move
     */
    public Index promptMove() {
        while (true) {
            System.out.print("Enter x and y (1-" + board.size + ", e.g. 12 3): ");
            String userInput = scanner.nextLine();

            try {
                var formatInput = formatMoves(userInput);
                if (board.isEmpty(formatInput)) {
                    return formatInput;
                } else {
                    System.out.println("Not Empty!");
                }
            } catch (Exception e) {
                System.out.println("Invalid!");
            }
        }
    }

    /**
     * Format the user input.
     * Verify that the user made a well constructed move.
     * Well constructed moves are within the board and contain only two integer coordinates.
     * @param input user inputted move
     * @return formatted move
     * @throws Exception if the user did not make a well constructed move
     */
    private Index formatMoves(String input) throws Exception {
        String[] inputList = input.split(" ");
        int[] indices = new int[2];

        if (inputList.length != 2) {
            throw new Exception();
        }

        int i = 0;
        for (String index : inputList){
            int curr = Integer.parseInt(index);
            if (curr >= 1 && curr <= board.size){
                indices[i] = curr-1;
                i++;
            } else {
                throw new Exception();
            }
        }
        return new Index(indices[0], indices[1]);
    }
}

/**
 * Class that formats the coordinates of moves.
 */
class Index {
    /**
     * x coordinate
     */
    final int x;

    /**
     * y coordinate
     */
    final int y;

    /**
     * Class constructor.
     * @param x x coordinate
     * @param y y coordinate
     */
    Index(int x, int y) {
        this.x = x;
        this.y = y;
    }
}