import Data.Char
import Data.Function
import Data.List
import Data.Maybe

main :: IO ()
main = do
    solutions <- solve <$> getPuzzle
    if null solutions
        then putStrLn "No solution found."
        else do
            putStrLn "Solution(s):"
            mapM_ printPuzzle solutions

-- I/O functions

getPuzzle :: IO [Int]
getPuzzle = do
    putStrLn "Please enter the puzzle, row by row, with '.' for empty cells."
    puzzle <- map (\c -> if c == '.' then 0 else digitToInt c) <$> getStrPuzzle 9
    if length puzzle == 81 && all (\x -> (x >= 0) && (x <= 9)) puzzle
        then return puzzle
        else putStrLn "Invalid puzzle. Please try again." *> getPuzzle

getStrPuzzle :: Int -> IO String
getStrPuzzle 0 = return ""
getStrPuzzle n = (++) <$> getLine <*> getStrPuzzle (n - 1)

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
        posList = filter (\x -> row x || col x || box x) [0..80]
        row = ((==) `on` (`div` 9)) pos
        col = ((==) `on` (`mod` 9)) pos
        box = ((&&) . ((==) `on` (`div` 27)) pos) <*> ((==) `on` ((`div` 3) . (`mod` 9))) pos

replace :: Int -> a -> [a] -> [a]
replace pos val list = take pos list ++ [val] ++ drop (pos + 1) list
