<?php 
// By: Janeth Meraz
// CS 3360

class Board {
    public $places;
    public $size;
    public $spaces_filled;
    
    function __construct() {
        $this->size = 15;
        
        $this->places = array();
        for($i = 0; $i < $this->size; $i++){
            $row = array();
            for ($j = 0; $j < $this->size; $j++){
                $row[] = 0;
            }
            $this->places[] = $row;
        }
    }
    
    // check if the space on the board is empty.
    function isEmpty($x,$y){
        return $this->places[$x][$y] == 0;
    }
    
    // place a value on the board.
    function place($x,$y,$value){
        $this->places[$x][$y] = $value;
    }
    
    // check if the move is a winning move.
    // return the winning row.
    public function win(){
        if ($this->winRow()){
            return $this->winRow();
        } else if ($this->winCol()){
            return $this->winCol();
        } else if ($this->winRDiag()){
            return $this->winRDiag();
        } else if ($this->winLDiag()){
            return $this->winLDiag();
        }
        return False;
    }
    
    // helper functions to determine if it is a winning move.
    function winRow(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$i][$j] == 1 and $board[$i][$j+1] == 1 and $board[$i][$j+2] == 1 and $board[$i][$j+3] == 1 and $board[$i][$j+4] == 1){
                    return [$i,$j,$i,$j+1,$i,$j+2,$i,$j+3,$i,$j+4];
                }
                if ($board[$j][$i] == 2 and $board[$j][$j+1] == 2 and $board[$j][$i+2] == 2 and $board[$j][$i+3] == 2 and $board[$j][$i+4] == 2){
                    return [$i,$j,$i,$j+1,$i,$j+2,$i,$j+3,$i,$j+4];
                }
            }
        }
        return False;
    }
    
    function winCol(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$j][$i] == 1 and $board[$j][$i+1] == 1 and $board[$j][$i+2] == 1 and $board[$j][$i+3] == 1 and $board[$j][$i+4] == 1){
                    return [$j,$i,$j,$i+1,$j,$i+2,$j,$i+3,$j,$i+4];
                }
                if ($board[$j][$i] == 2 and $board[$j][$j+1] == 2 and $board[$j][$i+2] == 2 and $board[$j][$i+3] == 2 and $board[$j][$i+4] == 2){
                    return [$j,$i,$j,$i+1,$j,$i+2,$j,$i+3,$j,$i+4];
                }
            }
        }
        return False;
    }
    
    function winRDiag(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound-5; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$i][$j] == 1 and $board[$i+1][$j+1] == 1 and $board[$i+2][$j+2] == 1 and $board[$i+3][$j+3] == 1 and $board[$i+4][$j+4] == 1){
                    return [$i,$j,$i+1,$j+1,$i+2,$j+2,$i+3,$j+3,$i+4,$j+4];
                }
                if ($board[$j][$i] == 2 and $board[$j+1][$j+1] == 2 and $board[$j+2][$i+2] == 2 and $board[$j+3][$i+3] == 2 and $board[$j+4][$i+4] == 2){
                    return [$i,$j,$i+1,$j+1,$i+2,$j+2,$i+3,$j+3,$i+4,$j+4];
                }
            }
        }
        return False;
    }
    
    function winLDiag(){
        global $board;
        $bound = $board->size;
        for ($i = 4; $i < $bound; $i++){
            for ($j = 4; $j < $bound; $j++){
                if ($board[$i][$j] == 1 and $board[$i-1][$j-1] == 1 and $board[$i-2][$j-2] == 1 and $board[$i-3][$j-3] == 1 and $board[$i-4][$j-4] == 1){
                    return [$i,$j,$i-1,$j-1,$i-2,$j-2,$i-3,$j-3,$i-4,$j-4];
                }
                if ($board[$j][$i] == 2 and $board[$j-1][$j-1] == 2 and $board[$j-2][$i-2] == 2 and $board[$j-3][$i-3] == 2 and $board[$j-4][$i-4] == 2){
                    return [$i,$j,$i-1,$j-1,$i-2,$j-2,$i-3,$j-3,$i-4,$j-4];
                }
            }
        }
        return False;
    }
}
