<?php 

include '../play/Board.php';
include '../play/SmartStrategy.php';
include '../play/RandomStrategy.php';
include '../play/Move.php';

class Game {
    public $board;
    public $strategy;

    function __construct($strategy) {
        $this->strategy = $strategy;
        $this->board = new Board();
    }
    
    function toJson() { 
        echo json_encode($this);
    } // JSON rep. of this game
    
    static function fromJson($json) {
        $obj = json_decode($json); // of stdClass
        $strategy = $obj->{'strategy'};
        $board = $obj->{'board'};
        $game = new Game();
        $game->board = Board::fromJson($board);
        $name = $strategy->{'name'};
        $game->strategy = $name::fromJson($strategy);
        $game->strategy->board = $game->board;
        return $game;
    }
    
    // function to make the player move a piece.
    function makePlayerMove($x,$y){
        if (!$this->board->isEmpty($x,$y)){
            return False;
        } else {
            $this->board[$x][$y] = 2;
        }
    }
    
    // function to make the opponent move a place.
    function makeOpponentMove($x,$y){
        if ($this->strategy == "Random"){
            $rand = new RandomStrategy();
            $place = $rand->pickPlace($x,$y);
            return $place;
        }
        $smart = new SmartStrategy();
        $place = $smart->pickPlace($x,$y);
        return $place;
    }
}

