<?php 

include '../play/Game.php';

define('STRATEGY', 'strategy'); // constant
$strategies = ["Smart", "Random"]; // supported strategies

// check that there is input for the stategy.
if (!array_key_exists(STRATEGY, $_GET)) { 
    $info = array('response' => false, 'reason' => 'Strategy not specified');
    echo json_encode($info);
    exit; 
}

$strategy = $_GET[STRATEGY];

if (!in_array($strategy, $strategies)){
    $info = array('response' => false, 'reason' => 'Unknown Strategy');
    echo json_encode($info);
    exit;
}

// create a new player id for the game.
$player_id = uniqid();
$info = array('response' => true, 'pid' => "$player_id");
echo json_encode($info);


// $filename = "../games/$player_id.txt";
// $fp = fopen($filename, 'w');
// $game = new Game($strategy);
// fwrite($fp, $game->toJson());
// fclose($fp);

?>


