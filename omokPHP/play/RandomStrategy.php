<?php 
// By: Janeth Meraz
// CS 3360

class RandomStrategy {
    var $board;
    
    function __construct(Board $board = null) {
        $this->board = new Board;
    }
    
    function toJson() {
        return array(‘name’ => get_class($this));
    }
    
    static function fromJson() {
        $strategy_place = new static();
        return $strategy;
    }
    
    // randomly pick a place. 
    public function pickPlace() {
        global $board;
        $bound = $board->size;
        $row = rand(0,$bound-1);
        $col = rand(0,$bound-1);
        while (!$board->isEmpty($row,$col) && !$board->isFull()){
            if ($col < $bound - 1) {
                $col += 1;
            }
            else if ($row < $bound - 1){
                $row += 1;
                $col = 0;
            } else {
                $row = 0;
                $col = 0;
            }
        }
        $board->place($row, $col);
        return[$row, $col];
    }
}
