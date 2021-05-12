import org.json.JSONArray;

/**
 * Class that contains the structure of the board.
 */
class Board {

    /**
     * Character that identifies a winning row.
     */
    private static final Player WIN = new Player('W');

    /**
     * Character that identifies an empty space.
     */
    private static final Player EMPTY = new Player('.');

    /**
     * Integer that stores the size of the board..
     */
    int size;

    /**
     * Array of type Player that makes up the board..
     */
    Player[][] rows;

    /**
     * Class constructor.
     * Creates a size x size board of empty spaces.
     * @param size size of the board from json
     */
    Board(int size){
        this.size = size;
        rows = new Player[size][size];

        for (int i = 0; i < rows.length; i++) {
            for (int j = 0; j < rows.length; j++) {
                rows[i][j] = EMPTY;
            }
        }
    }

    /**
     *
     * @param index object of type index with x and y coordinates
     * @return true if the space is empty
     */
    boolean isEmpty(Index index) {
        return rows[index.x][index.y].stone == '.';
    }

    /**
     * Place the player in the identified spot.
     * @param player Player variable with a specific stone
     * @param x x coordinate of the board
     * @param y y coordinate of the board
     */
    void place(Player player, int x, int y) {
        rows[x][y] = player;
    }

    /**
     * Replace the characters of the winning row.
     * @param row JSONArray with indices of the winning row
     */
    public void winRow(JSONArray row) {
        for (int i = 0; i < row.length(); i = i + 2) {
            rows[(int) row.get(i)][(int) row.get(i+1)] = WIN;
        }
    }
}

/**
 * Class of Player.
 * Makes up the board.
 */
class Player {

    /**
     * char variable denoting the type of character stored in each place.
     */
    char stone;

    /**
     * Class constructor.
     * @param stone char that will be placed in the spot
     */
    Player(char stone) {
        this.stone = stone;
    }
}

