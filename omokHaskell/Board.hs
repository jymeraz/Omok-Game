-- Janeth Meraz
-- Course: CS 3360
-- Professor: Dr. Cheon
-- TA: Ivan Gastelum

-- Board module to model an omok board and two players.
module Board where

-- Number 1
  -- Make an empty board of size n.
  mkBoard :: Int -> [[Int]]
  mkBoard n = [ [ 0 | j <- [1..n] ] | i <- [1..n] ]

  -- Create the first player.
  mkPlayer :: Int
  mkPlayer = 1

  -- Create the second player.
  mkOpponent :: Int
  mkOpponent = 2

  -- Return the size of the board.
  size :: [[Int]] -> Int
  size bd = length bd

  -- Return a row y of a board bd.
  row :: Int -> [[Int]] -> [Int]
  row _ [] = []
  row y (h:t)
    | y == 1 = h
    | otherwise = row (y-1) t

  -- Return a column x of a board bd.
  column :: Int -> [[Int]] -> [Int]
  column x bd = [index x h | h <- bd]
    where index y (h:t)
            | y == 1 = h
            | otherwise = index (y-1) t

  -- Return a list of all the diagonal rows of the board.
  diagonalRows :: [[Int]] -> [[Int]]
  diagonalRows bd = tlRows bd ++ blRows bd ++ trRows bd ++ brRows bd
    where
      tlRows bd = map (topLeft bd) [0..(size bd - 1)]
      topLeft bd 0 = [head bd !! 0]
      topLeft bd i = head bd !! i : topLeft (tail bd) (i - 1)
      blRows bd = tlRows (reverse bd)
      trRows bd = tlRows(reverseCol bd)
      brRows bs = tlRows (reverseCol(reverse bd))
      reverseCol [] = []
      reverseCol (h:t) = reverse(h) : reverseCol(t)

-- Number 2
  -- Mark a place in a board bd by a player p.
  mark :: Int -> Int -> [[a]] -> a -> [[a]]
  mark _ _ ([[]]) _ = []
  mark x y (h:t) p
    | x == 1 = (markCol y h p) : t
    | otherwise = h : (mark (x-1) y t p)
      where
        markCol _ ([]) p = []
        markCol 1 (h:t) p = p : t
        markCol y (h:t) p = h : (markCol (y-1) t p)

  -- Check if a place in the board is unmarked.
  isEmpty :: Int -> Int -> [[Int]] -> Bool
  isEmpty _ _ ([[]]) = False
  isEmpty x y (h:t)
    | x == 1 = checkCol y h
    | otherwise = isEmpty (x-1) y t
      where
        checkCol _ ([]) = False
        checkCol 1 (h:t) = h == 0
        checkCol y (h:t) = checkCol (y-1) t

  -- Check if a place in a board is marked.
  isMarked :: Int -> Int -> [[Int]] -> Bool
  isMarked _ _ ([[]]) = False
  isMarked x y (h:t)
    | x == 1 = checkCol y h
    | otherwise = isMarked (x-1) y t
      where
        checkCol _ ([]) = False
        checkCol 1 (h:t) = h /= 0
        checkCol y (h:t) = checkCol (y-1) t

  -- Check if a place in the board bd is marked by player p.
  isMarkedBy :: Int -> Int -> [[Int]] -> Int -> Bool
  isMarkedBy _ _ ([[]]) _ = False
  isMarkedBy x y (h:t) p
    | x == 1 = checkCol y h p
    | otherwise = isMarkedBy (x-1) y t p
      where
        checkCol _ ([]) _ = False
        checkCol 1 (h:t) p = h == p
        checkCol y (h:t) p = checkCol (y-1) t p

  -- Return the player of the stone placed in a specific spot.
  marker :: Int -> Int -> [[Int]] -> Int
  marker x y (h:t)
    | x == 1 = markCol y h
    | otherwise = marker (x-1) y t
      where
        markCol 1 (h:t) = h
        markCol y (h:t) = markCol (y-1) t

  -- Check if all the places in the board are marked.
  isFull:: [[Int]] -> Bool
  isFull bd = not (foldl1 (||) (map hasEmpty bd))
    where
      hasEmpty row = length (filter (\p->p == 0) row) > 0

-- Number 3
  -- Determine if the game is won by player p.
  isWonBy :: [[Int]] -> Int -> Bool
  isWonBy bd p = checkWin 1 bd p

  -- Iterate through all the rows, columns, and diagonals to check for a win.
  checkWin :: Int -> [[Int]] -> Int -> Bool
  checkWin i bd p
    | i > length bd = False
    | (hasWinSeq (row i bd) p) == True || (hasWinSeq (column i bd) p) == True  || checkDiagonal (diagonalRows bd) p == True = True
    | otherwise = checkWin (i+1) bd p
      where
        checkDiagonal [] _ = False
        checkDiagonal (h:t) p
          | hasWinSeq h p == True = True
          | otherwise = checkDiagonal t p
        hasWinSeq [] p = False
        hasWinSeq (h:t) p
          | h == p && length t >= 4 = allP (take 4 t) || hasWinSeq t p
          | otherwise = hasWinSeq t p
            where
              allP [] = True
              allP (h:t) = h == p && allP t

  -- Check if the board ended in a draw.
  isDraw :: [[Int]] -> Bool
  isDraw bd = (isWonBy bd mkPlayer) == False && (isWonBy bd mkOpponent) == False && (isFull bd) == True

  -- Check if the board has ended.
  isGameOver :: [[Int]] -> Bool
  isGameOver bd = (isWonBy bd mkPlayer) == True || (isWonBy bd mkOpponent) == True || (isDraw bd) == True

-- Number 4
  -- Convert the board to a string for printing.
  boardToStr :: (Int -> Char) -> [[Int]] -> [Char]
  boardToStr _ [] = []
  boardToStr playerToChar bd = nums ++ dashes ++ addSpace (concat(spaces 1 playerToChar bd))
    where
      spaces _ _ [] = []
      spaces i playerToChar (h:t) = (show (mod i 10) ++ "|" ++ (map playerToChar h) ++ "\n") : spaces (i+1) playerToChar t
      dashes = "y  " ++ concat(["-" | n <- [1.. ((size bd)*2)]]) ++ "\n"
      nums = " x  " ++ concat([show (mod n 10) ++ " " | n <- [1.. size bd]]) ++ "\n"
      addSpace [] = []
      addSpace (h:t)
        | h == '\n' = h : addSpace t
        | otherwise = h : ' ' : addSpace t
