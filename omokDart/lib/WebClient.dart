/// Name: Janeth Meraz
/// Course: CS 3360
/// Professor: Yoonsik Cheon
/// TA: Ivan Gastelum
/// Assignment: Omok Dart Project

import 'dart:io';
import 'package:http/http.dart' as http;
import 'ResponseParser.dart';

/// Class interacting with the server.
class WebClient {
  static const DEFAULT_SERVER = 'http://www.cs.utep.edu/cheon/cs3360/project/omok';

  /// URL for the info API.
  static const _INFO ='/info/';

  /// URL for the new API.
  static const _NEW ='/new/';

  /// URL for the play API.
  static const _PLAY ='/play/';

  /// URL to set the strategy.
  static const _SET_STRATEGY ='?strategy';

  /// URL to specify the pid.
  static const _PID ='?pid';

  /// URL to make a move.
  static const _MOVE ='move';

  /// Variable containing the server URL that is being used for the game.
  final _serverUrl;

  /// Parser to parse the API responses.
  var parser = ResponseParser();

  WebClient(this._serverUrl);

  /// Returns the information returned from the info url.
  /// Print an message if there is an error.
  Future<Info> getInfo() async {
    try {
      var newURL = _serverUrl + _INFO;
      var response = await http.get(Uri.parse(newURL));
      return parser.parseInfo(response.body);
    } catch (e) {
      stdout.writeln('Server Error.');
    }
  }

  /// Returns the information returned from the new url.
  /// Print an message if there is an error.
  Future<NewGame> newGame(strategy) async {
    try {
      var newURL = _serverUrl + _NEW + _SET_STRATEGY + '=$strategy';
      var response = await http.get(Uri.parse(newURL));
      return parser.parseStrategy(response.body);
    } catch (e) {
      stdout.writeln('Server Error.');
    }
  }

  /// Returns the information returned from the play url.
  /// Print an message if there is an error.
  Future<MakeMove> play(pid, move) async {
    try {
      var newURL = _serverUrl + _PLAY + _PID + '=$pid&$_MOVE=${move.x},${move.y}';
      var response = await http.get(Uri.parse(newURL));
      return parser.parseMove(response.body);
    } catch (e) {
      stdout.writeln('Server Error.');
    }
  }
}