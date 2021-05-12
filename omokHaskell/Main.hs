-- Janeth Meraz
-- Course: CS 3360
-- Professor: Dr. Cheon
-- TA: Ivan Gastelum

-- Main module that provides a console-based UI for playing omok game.
module Main where
  import System.IO
  import System.Random
  import Board

-- Number 1
  -- Return the character representation of player p.
  playerToChar :: Int -> Char
  playerToChar p
    | p == mkPlayer = 'O'
    | p == mkOpponent = 'X'
    | otherwise = '.'

  -- Read a 1-based pair of indices denoting an unmarked place in the board.
  -- Allow the user to input -1 to exit the game.
  readXY:: [[Int]] -> Int -> IO(Int, Int)
  readXY bd p = do
    putStrLn $ "Player " ++ [playerToChar p] ++ "'s turn. Enter x and y coordinates (1-" ++ show(size bd) ++ " or -1 to quit, i.e. 4 5):"
    line <- getLine
    let parsed = reads line :: [(Int, String)] in
      if length parsed == 0
      then readXY'
      else let (x, _) = head parsed in
        if x == -1
        then return (-1, -1)
        else let inRange = (withinBounds x bd) in
          if inRange == True && (length (tail line)) > 0
          then let parsed = reads (tail(tail(line))) :: [(Int, String)] in
            if length parsed == 0
            then readXY'
            else let (y, _) = head parsed in
              if (withinBounds y bd) == True && isEmpty x y bd
              then return (x,y)
              else readXY'
          else readXY'
    where
      readXY' = do
        putStrLn "Invalid input!"
        readXY bd p
      withinBounds n bd
        | n < 1 = False
        | n > (size bd) = False
        | otherwise = True

  -- Return an empty pair of indices from the board.
  -- Allows the user to play against a computer.
  getRandomXY :: [[Int]] -> a -> IO (Int,Int)
  getRandomXY bd p = do
    x <- randomRIO(1,(size bd))
    y <- randomRIO(1,(size bd))
    if (isEmpty x y bd) == True
    then return (x,y)
    else getRandomXY bd p

-- Number 2
  -- Initialize the board.
  boardSize :: Int
  boardSize = 15

  -- Main function to play the omok game.
  -- Prompt the user to input if they want to play with a computer or not.
  main :: IO ()
  main = do
    putStrLn "Would you like to play against a computer? Y/N"
    line <- getLine
    if length line == 0
    then tryAgain
    else let x = head line in
      case x of
      'N' -> againstPerson
      'n' -> againstPerson
      'Y' -> againstComputer
      'y' -> againstComputer
      e -> tryAgain
    where
      tryAgain = do
        putStrLn "Invalid input!"
        main
      againstPerson = twoPlayers bd mkPlayer mkOpponent
        where bd = mkBoard boardSize
      againstComputer = onePlayer bd mkPlayer mkOpponent
        where bd = mkBoard boardSize

  -- Handle two users playing at the same time.
  -- Display the game state, read from the users, and display the results.
  twoPlayers :: [[Int]] -> Int -> Int -> IO ()
  twoPlayers bd p1 p2 = do
    (isOver, bd') <- doMove bd p1
    if isOver then (results bd' p1) else twoPlayers bd' p2 p1
    where
      doMove bd p = do
        printBoard bd
        (x, y) <- readXY bd p
        if x == -1
        then return(True, bd)
        else let bd' = mark x y bd p in
          if isWonBy bd' p
          then return (True, bd')
          else return (False, bd')

  -- Handle one person playing against a computer.
  -- Display the game state, read from the user, and display the results.
  onePlayer :: [[Int]] -> Int -> Int -> IO ()
  onePlayer bd p1 p2 = do
  (isOver, bd') <- doMove bd p1
  if isOver then (results bd' p1) else onePlayer bd' p2 p1
  where
    doMove bd p = do
      printBoard bd
      case p of
        1 -> user
        2 -> comp
      where
        user = do
          (x, y) <- readXY bd p
          if x == -1
          then return(True, bd)
          else let bd' = mark x y bd p in
            if isWonBy bd' p
            then return (True, bd')
            else return (False, bd')
        comp = do
          (x, y) <- getRandomXY bd p
          let bd' = mark x y bd p in
            if isWonBy bd' p
            then return (True, bd')
            else return (False, bd')

  -- Display the final results of the game once it is over.
  results :: [[Int]] -> Int -> IO ()
  results bd p = do
    printBoard bd
    if isWonBy bd p == True
    then putStrLn $ "Player " ++ [playerToChar p] ++ " won! :D"
    else putStrLn "No one won :("

  -- Display the current state of the board.
  printBoard :: [[Int]] -> IO ()
  printBoard bd = putStrLn (boardToStr playerToChar bd)
