import Data.Char
import Data.List
import Data.Maybe

main :: IO ()
main = do
    putStrLn "Please enter the puzzle, row by row, with '.' for empty cells."
    puzzle <- getPuzzle
    let solved = solve puzzle
    if null solved
        then putStrLn "No solution found."
        else do
            putStrLn "Solution(s):"
            mapM_ printPuzzle solved

-- I/O functions

getPuzzle :: IO [Int]
getPuzzle = do
    strPuzzle <- getStrPuzzle 9
    let puzzle = map (\c -> if c == '.' then 0 else digitToInt c) strPuzzle
    if length puzzle == 81 && all (\x -> (x >= 0) && (x <= 9)) puzzle
        then return puzzle
        else do
            putStrLn "Invalid puzzle. Please try again."
            getPuzzle

getStrPuzzle :: Int -> IO String
getStrPuzzle 0 = return ""
getStrPuzzle n = do
    line <- getLine
    rest <- getStrPuzzle (n - 1)
    return $ line ++ rest

printPuzzle :: [Int] -> IO ()
printPuzzle [] = return ()
printPuzzle puzzle = do
    putStrLn $ map intToDigit $ take 9 puzzle
    printPuzzle $ drop 9 puzzle

-- Solver functions

solve :: [Int] -> [[Int]]
solve puzzle = if isNothing pos then [puzzle] else solutions
    where
        pos = elemIndex 0 puzzle
        numList = possibleList puzzle $ fromJust pos
        puzzles = map (\x -> replace (fromJust pos) x puzzle) numList
        solutions = concatMap solve puzzles

possibleList :: [Int] -> Int -> [Int]
possibleList puzzle pos = [1..9] \\ [puzzle !! i | i <- posList]
    where
        posList = rowPosList ++ colPosList ++ boxPosList
        rowPosList = [i | i <- [0..80], i `mod` 9 == pos `mod` 9]
        colPosList = [i | i <- [0..80], i `div` 9 == pos `div` 9]
        boxPosList = [i | i <- [0..80], i `div` 27 == pos `div` 27 && i `mod` 9 `div` 3 == pos `mod` 9 `div` 3]

replace :: Int -> a -> [a] -> [a]
replace pos val list = take pos list ++ [val] ++ drop (pos + 1) list
