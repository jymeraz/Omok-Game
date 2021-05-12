<?php 

class Move{
    public $x;
    public $y;
    public $isWin;
    public $isDraw;
    public $row;
    
    function toJson() {
        echo json_encode($this);
    }
}
