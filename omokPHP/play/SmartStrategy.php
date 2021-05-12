<?php 

class SmartStrategy {
    var $board;
    
    function __construct(Board $board = null) {
        $this->board = new Board;
    }
    
    function toJson() {
        return array(‘name’ => get_class($this));
    }
    
    static function fromJson() {
        $strategy = new static();
        return $strategy;
    }
    
    // pick a place based on whether there is a possible win.
    // if there is no win, pick based on defense. 
    // otherwise, pick randomly. 
    public function pickPlace() {
        global $board;
        $bound = $board->size;
        $row = checkRows();
        $col = checkCols();
        $rdiag = rightDiagonal();
        $ldiag = leftDiagonal();
        
        if ($row){
            $board->place($row[0], $row[1]);
            return [$row[0], $row[1]];
        } else if ($col){
            $board->place($col[0], $col[1]);
            return [$col[0], $col[1]];
        } else if ($rdiag) {
            $board->place($rdiag[0], $rdiag[1]);
            return [$rdiag[0], $rdiag[1]];
        } else if ($ldiag) {
            $board->place($ldiag[0], $ldiag[1]);
            return [$ldiag[0], $ldiag[1]];
        }
        
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
    
    public function checkRows(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$i][$j] == 1 and $board[$i][$j+1] == 1 and $board[$i][$j+2] == 1 and $board[$i][$j+3] == 1 and $board[$i][$j+4] == 1){
                    $row = $i;
                    $colp1 = $j-1;
                    $colp2 = $j+1;
                    break;
                }
                if ($board[$j][$i] == 2 and $board[$j][$j+1] == 2 and $board[$j][$i+2] == 2 and $board[$j][$i+3] == 2 and $board[$j][$i+4] == 2){
                    $defendrow = $i;
                    $defendcolp1 = $j-1;
                    $defendcolp2 = $j+1;
                    #break;
                }
            }
        }
        if ($colp1 > 0){
            return [$row, $colp1]; 
        } else if  ($colp2 < $board->size){
            return [$row, $colp1];
        } else if ($defendcolp1 > 0){
            return [$defendrow, $defendcolp1];
        } else if ($defendcolp2 < $board->size){
            return [$defendrow, $defendcolp2];
        }
        return False;
    }
    
    public function checkCols(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$j][$i] == 1 and $board[$j][$i+1] == 1 and $board[$j][$i+2] == 1 and $board[$j][$i+3] == 1 and $board[$j][$i+4] == 1){
                    $col = $i;
                    $rowp1 = $j-1;
                    $rowp2 = $j+1;
                    break;
                }
                if ($board[$j][$i] == 2 and $board[$j][$j+1] == 2 and $board[$j][$i+2] == 2 and $board[$j][$i+3] == 2 and $board[$j][$i+4] == 2){
                    $defendcol = $i;
                    $defendrowp1 = $j-1;
                    $defendrowp2 = $j+1;
                    #break;
                }
            }
        }
        if ($rowp1 > 0){
            return [$rowp1, $col];
        } else if  ($rowp2 < $board->size){
            return [$rowp2, $col];
        } else if ($defendrowp1 > 0){
            return [$defendrowp1, $defendcol];
        } else if ($defendrowp2 < $board->size){
            return [$defendrowp2, $defendcol];
        }
        return False;
    }
    
    public function rightDiagonal(){
        global $board;
        $bound = $board->size;
        for ($i = 0; $i < $bound-5; $i++){
            for ($j = 0; $j < $bound-5; $j++){
                if ($board[$i][$j] == 1 and $board[$i+1][$j+1] == 1 and $board[$i+2][$j+2] == 1 and $board[$i+3][$j+3] == 1 and $board[$i+4][$j+4] == 1){
                    $row = $i;
                    $colp1 = $j-1;
                    $colp2 = $j+1;
                    break;
                }
                if ($board[$j][$i] == 2 and $board[$j+1][$j+1] == 2 and $board[$j+2][$i+2] == 2 and $board[$j+3][$i+3] == 2 and $board[$j+4][$i+4] == 2){
                    $defendrow = $i;
                    $defendcolp1 = $j-1;
                    $defendcolp2 = $j+1;
                }
            }
        }
        if ($colp1 > 0){
            return [$row, $colp1];
        } else if  ($colp2 < $board->size){
            return [$row, $colp1];
        } else if ($defendcolp1 > 0){
            return [$defendrow, $defendcolp1];
        } else if ($defendcolp2 < $board->size){
            return [$defendrow, $defendcolp2];
        }
        return False;
    }
    
    public function leftDiagonal(){
        global $board;
        $bound = $board->size;
        for ($i = 4; $i < $bound; $i++){
            for ($j = 4; $j < $bound; $j++){
                if ($board[$i][$j] == 1 and $board[$i-1][$j-1] == 1 and $board[$i-2][$j-2] == 1 and $board[$i-3][$j-3] == 1 and $board[$i-4][$j-4] == 1){
                    $row = $i;
                    $colp1 = $j-1;
                    $colp2 = $j+1;
                    break;
                }
                if ($board[$j][$i] == 2 and $board[$j-1][$j-1] == 2 and $board[$j-2][$i-2] == 2 and $board[$j-3][$i-3] == 2 and $board[$j-4][$i-4] == 2){
                    $defendrow = $i;
                    $defendcolp1 = $j-1;
                    $defendcolp2 = $j+1;
                }
            }
        }
        if ($colp1 > 0){
            return [$row, $colp1];
        } else if  ($colp2 < $board->size){
            return [$row, $colp1];
        } else if ($defendcolp1 > 0){
            return [$defendrow, $defendcolp1];
        } else if ($defendcolp2 < $board->size){
            return [$defendrow, $defendcolp2];
        }
        return False;
    }
}
