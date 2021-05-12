<?php 

include '../play/Game.php';

define('PID', 'pid'); // constant
define('MOVE', 'move');

// get the PID and the MOVE from user input.
if (!array_key_exists(PID, $_GET)) {
    $info = array('response' => false, 'reason' => 'pid not specified');
    echo json_encode($info);
    exit;
}

if (!array_key_exists(MOVE, $_GET)) {
    $info = array('response' => false, 'reason' => 'move not specified');
    echo json_encode($info);
    exit;
}

$pid = $_GET[PID];
$move = $_GET[MOVE];

if (!is_numeric($pid[0])){
    $info = array('response' => false, 'reason' => 'Unknown pid');
    echo json_encode($info);
    exit;
}

$intArray = explode(',', $move);
foreach ($intArray as &$i) $i = (int) $i;

if (count($intArray) != 2){
    $info = array('response' => false, 'reason' => 'Move not well-formed');
    echo json_encode($info);
    exit;
}

if ($intArray[0] < 0 || $intArray[1] < 0 || $intArray[0] > 14 || $intArray[1] > 14){
    $info = array('response' => false, 'reason' => 'Invalid move coordinate');
    echo json_encode($info);
    exit;
}

// open the file for the current game. 
$file = "../games/$pid.txt";
$json = file_get_contents($file);
$game = Game::fromJson($json);

// make a player move based on user input.
$playerMove = $game->makePlayerMove($intArray[0], $intArray[1]);

if ($playerMove->isWin || $playerMove->isDraw) {
    unlink($file);
    $info = array('response' => true, 'ack_move' => $playerMove->toJson());
    echo json_encode($info);
    exit;
}

if(!$playerMove){
    unlink($file);
    $info = array('response' => false, 'reason' => 'already placed');
    echo json_encode($info);
    exit;
}

// make the opponent move if it is not a winning game.
$opponentMove = $game->makeOpponentMove();
if ($opponentMove->isWin || $opponentMove->isDraw) {
        unlink($file);
        $info = array('response' => true, 'ack_move' => $playerMove->toJson(), 'move' => $opponentMove->toJson());
        echo json_encode($info);
        exit;
}

$info = array('response' => true, 'ack_move' => $playerMove->toJson());
echo json_encode($info);
storeState($file, $game->toJson());
        
