
import org.json.JSONObject;
import org.json.JSONArray;

/**
 * Class that parses the information received from the json.
 */
public class Parser {
    /**
     * Parse the information received from the info url.
     * @param response json from the server
     * @return json information formatted in a class
     */
    public Info parseInfo(String response) {
        JSONObject parser  = new JSONObject(response);
        return new Info(parser);
    }

    /**
     * Parse the information received from the new url.
     * @param response json from the server
     * @return json information formatted in a class
     */
    public NewGame parseStrategy(String response) {
        JSONObject parser  = new JSONObject(response);
        return new NewGame(parser);
    }

    /**
     * Parse the information received from the play url.
     * @param response json from the server
     * @return json information formatted in a class
     */
    public MakeMove parseMove(String response) {
        JSONObject parser = new JSONObject(response);
        return new MakeMove(parser);
    }
}

/**
 * Class to parse the info url information.
 */
class Info {
    final int size;
    final JSONArray strategies;

    Info(JSONObject parser) {
        this.size = parser.getInt("size");
        this.strategies = parser.getJSONArray("strategies");
    }
}

/**
 * Class to parse the new url information.
 */
class NewGame {

    final boolean response;
    String pid;
    String reason;

    NewGame(JSONObject parser) {
        if (parser.has("reason")) {
            this.response = parser.getBoolean("response");
            this.reason = parser.getString("reason");
        } else {
            this.response = parser.getBoolean("response");
            this.pid = parser.getString("pid");
        }
    }
}

/**
 * Class to parse the play url information.
 */
class MakeMove {

    boolean response;
    Move ack_move;
    Move move;
    String reason;

    MakeMove(JSONObject parser) {
        if (parser.has("reason")) {
            this.response = parser.getBoolean("response");
            this.reason = parser.getString("reason");
        } else {
            this.response = parser.getBoolean("response");
            JSONObject player = parser.getJSONObject("ack_move");
            this.ack_move = new Move(player);
            if (parser.has("move")) {
                JSONObject computer = parser.getJSONObject("move");
                this.move = new Move(computer);
            } else {
                this.move = null;
            }
        }
    }
}

/**
 * Class to parse the ack_move and move objects in the json received from the play url.
 */
class Move {

    final int x;
    final int y;
    final boolean isWin;
    final boolean isDraw;
    final JSONArray row;

    Move(JSONObject move) {
        this.x = move.getInt("x");
        this.y = move.getInt("y");
        this.isWin = move.getBoolean("isWin");
        this.isDraw = move.getBoolean("isDraw");
        this.row = move.getJSONArray("row");
    }
}
