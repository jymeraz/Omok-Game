/**
 * Name: Janeth Meraz
 * Professor: Yoonsik Cheon
 * Project: Omok Java Project
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Class interacting with the server.
 */
public class WebClient {
    /**
     * Default server.
     */
    final static String DEFAULT_SERVER = "http://www.cs.utep.edu/cheon/cs3360/project/omok";

    /**
     * Url for the info API.
     */
    private final static String INFO = "/info/";

    /**
     * Url for the new API.
     */
    private final static String NEW = "/new/";

    /**
     * Url for the play API.
     */
    private final static String PLAY = "/play/";

    /**
     * Url to set the strategy.
     */
    private final static String SET_STRATEGY = "?strategy";

    /**
     * Url to specify the pid.
     */
    private final static String PID = "?pid";

    /**
     * Url to make a move.
     */
    private final static String MOVE = "move";

    /**
     * Variable with the server url that is used for the game.
     */
    private final String serverUrl;

    /**
     * Variable storing the object reference to the parser.
     */
    private final Parser parse = new Parser();

    /**
     * Class constructor.
     * @param serverUrl server url that will be used for the fame.
     */
    WebClient(String serverUrl) {
        this.serverUrl = serverUrl;
    }

    /**
     * Send a GET request to the url.
     * @param urlString server url
     * @return null if the connection fails else the response
     */
    public String sendGet(String urlString) {
        HttpURLConnection con = null;
        try {
            URL url = new URL(urlString);
            con = (HttpURLConnection) url.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = in.readLine()) != null) {
                response.append(line);
            }
            return response.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                con.disconnect();
            }
        }
        return null;
    }

    /**
     * Class requesting the information from the info url.
     * @return information returned from the url
     */
    public Info getInfo() {
        String response = sendGet(serverUrl + INFO);
        return parse.parseInfo(response);
    }

    /**
     * Class requesting the information from the new url.
     * @param strategy strategy choice of the user
     * @return information returned from the url
     */
    public NewGame newGame(String strategy) {
        String response = sendGet(serverUrl + NEW + SET_STRATEGY + "=" + strategy);
        return parse.parseStrategy(response);
    }

    /**
     * Class requesting the information from the play url.
     * @param pid player identification for the game
     * @param move choice of move by the user
     * @return information returned from the url
     */
    public MakeMove play(String pid, Index move) {
        String response = sendGet(serverUrl + PLAY + PID + "=" + pid + "&" + MOVE + "=" + move.x + "," + move.y);
        return parse.parseMove(response);
    }
}